import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../utill/app_logger.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../controller/order_controller.dart';

/// Portrait player for a video-call recording.
///
/// This widget owns the `VideoPlayerController` for its whole lifetime: it is
/// created here after `initialize()` succeeds and released in [dispose], which
/// Flutter runs only after the video surface below has been unmounted.
///
/// Chewie is deliberately not used here. Rotating a Chewie player rotates its
/// control bar with it, and its fullscreen route drives the device orientation
/// (and shares one `PlayerNotifier` across two control subtrees, which is what
/// produced "A PlayerNotifier was used after being disposed"). Only the video
/// surface is rotated below; the controls stay upright.
///
/// [OrderController] keeps owning the signed-URL cache, the request token and
/// the Recording button state; this dialog only reports playback back to it.
class RecordingVideoPlayerDialog extends StatefulWidget {
  final OrderController controller;

  /// uniqeid of the recording, used when a stale signed URL must be refreshed.
  final String recordingId;

  final String url;

  /// Request token of the tap that opened this dialog. Every callback carries
  /// it so a superseded dialog can never write state for a newer recording.
  final int sessionToken;

  /// False when [url] came straight from the API and cannot be stale yet.
  final bool allowRefresh;

  const RecordingVideoPlayerDialog({
    super.key,
    required this.controller,
    required this.recordingId,
    required this.url,
    required this.sessionToken,
    required this.allowRefresh,
  });

  @override
  State<RecordingVideoPlayerDialog> createState() =>
      _RecordingVideoPlayerDialogState();
}

class _RecordingVideoPlayerDialogState
    extends State<RecordingVideoPlayerDialog> {
  VideoPlayerController? _videoController;

  /// Bumped for every initialization attempt and once more in [dispose], so a
  /// result that arrives late is dropped instead of being used.
  int _initSession = 0;

  bool _isDisposed = false;
  bool _isExpanded = false;
  bool _hasFailed = false;
  bool _isMuted = false;

  /// Quarter turns from the header's rotate button. The recording is shown at
  /// the dimensions the file itself reports, so nothing is rotated by default;
  /// an Agora recording is composited on the server and which way is "up"
  /// cannot be read from the file, so the viewer turns it when needed.
  int _userQuarterTurns = 0;

  static const double _dialogWidthFactor = 0.8;
  static const double _dialogHeightFactor = 0.8;
  static const double _expandedWidthFactor = 0.96;
  static const double _expandedHeightFactor = 0.94;
  static const double _headerHeight = 56.0;
  static const double _controlsHeight = 44.0;

  int get _quarterTurns => _userQuarterTurns % 4;

  @override
  void initState() {
    super.initState();
    _initialize(widget.url, allowRefresh: widget.allowRefresh);
  }

  /// Creates the player for [url] once. A failure on a cached URL means the S3
  /// signature has most likely expired: that entry is dropped, a fresh URL is
  /// requested and initialization is retried exactly once.
  Future<void> _initialize(String url, {required bool allowRefresh}) async {
    final int session = ++_initSession;

    final VideoPlayerController videoController =
        VideoPlayerController.networkUrl(Uri.parse(url));

    try {
      await videoController.initialize();
    } catch (e) {
      AppLogger.d('OnExceptionInitRecordingVideo==> ${e.toString()}');
      await videoController.dispose();
      if (!_isCurrent(session)) return;

      if (allowRefresh) {
        final String? freshUrl =
            await widget.controller.refreshRecordingUrl(widget.recordingId);
        if (!_isCurrent(session)) return;

        if (freshUrl != null && freshUrl.trim().isNotEmpty) {
          // Retried with allowRefresh false, so this cannot loop.
          await _initialize(freshUrl, allowRefresh: false);
          return;
        }
      }

      _failAndClose();
      return;
    }

    // The dialog was closed, or another recording took over, while this was
    // still loading — drop the result instead of showing it.
    if (!_isCurrent(session)) {
      await videoController.dispose();
      return;
    }

    final VideoPlayerValue value = videoController.value;

    // Shown exactly at the dimensions the file reports — no rotation is applied
    // on top of the file's own `rotationCorrection`, which `VideoPlayer` already
    // handles. The header's rotate button is there when a viewer wants to turn
    // a server-composited recording.
    AppLogger.d('RecordingVideoMetadata==> ${value.size.width.toInt()}x'
        '${value.size.height.toInt()} '
        'rotation ${value.rotationCorrection % 360}°');

    videoController.addListener(_onVideoChanged);

    setState(() => _videoController = videoController);

    await videoController.play();
    if (!_isCurrent(session)) return;

    widget.controller.onRecordingStarted(widget.sessionToken);
  }

  /// True while [session] is still the live attempt and the widget is alive.
  bool _isCurrent(int session) =>
      mounted && !_isDisposed && session == _initSession;

  void _onVideoChanged() {
    final VideoPlayerController? videoController = _videoController;
    if (_isDisposed || videoController == null) return;
    if (!videoController.value.isInitialized) return;

    if (videoController.value.hasError) {
      _failAndClose();
      return;
    }

    final Duration duration = videoController.value.duration;
    final bool isCompleted = duration > Duration.zero &&
        videoController.value.position >= duration &&
        !videoController.value.isPlaying;

    if (isCompleted) {
      widget.controller.onRecordingCompleted(widget.sessionToken);
      _close();
      return;
    }

    widget.controller.onRecordingStateChanged(
      widget.sessionToken,
      isPlaying: videoController.value.isPlaying,
      isBuffering: videoController.value.isBuffering,
    );
  }

  void _failAndClose() {
    if (_hasFailed) return;
    _hasFailed = true;
    widget.controller.onRecordingFailed(widget.sessionToken);
    _close();
  }

  void _close() {
    if (_isDisposed || !mounted) return;
    // Paused before the pop so no late "still playing" event can arrive while
    // the route is animating out and put the button back to "Stop".
    _videoController?.pause();

    // Popped through this route rather than Get's global isDialogOpen flag, so
    // closing works even when that flag is out of step, and nothing else can be
    // popped by accident.
    final ModalRoute<Object?>? route = ModalRoute.of(context);
    if (route != null && route.isCurrent) Navigator.of(context).pop();
  }

  Future<void> _togglePlayPause() async {
    final VideoPlayerController? videoController = _videoController;
    if (videoController == null || !videoController.value.isInitialized) return;

    if (videoController.value.isPlaying) {
      await videoController.pause();
      return;
    }

    // Replay from the start once the recording has finished.
    if (videoController.value.position >= videoController.value.duration) {
      await videoController.seekTo(Duration.zero);
    }
    await videoController.play();
  }

  Future<void> _toggleMute() async {
    final VideoPlayerController? videoController = _videoController;
    if (videoController == null) return;

    final bool muted = !_isMuted;
    await videoController.setVolume(muted ? 0 : 1);
    if (!mounted) return;
    setState(() => _isMuted = muted);
  }

  @override
  void dispose() {
    _isDisposed = true;
    // Invalidate any initialization still in flight.
    _initSession++;

    final VideoPlayerController? videoController = _videoController;
    _videoController = null;

    videoController?.removeListener(_onVideoChanged);
    videoController?.dispose();

    widget.controller.onRecordingClosed(widget.sessionToken);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    // The dialog keeps its 80% x 80% portrait shape; the video is rotated to
    // fill it instead of the dialog being reshaped around the video.
    final double dialogWidth = screenSize.width *
        (_isExpanded ? _expandedWidthFactor : _dialogWidthFactor);
    final double dialogHeight = screenSize.height *
        (_isExpanded ? _expandedHeightFactor : _dialogHeightFactor);

    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: ColorResources.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: dialogWidth,
        height: dialogHeight,
        child: Column(
          children: [
            SizedBox(height: _headerHeight, child: _buildHeader()),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const SizedBox(width: Dimensions.paddingSizeSmall),
        Expanded(child: CustomTextMedium("Call Recording", maxLines: 1)),
        IconButton(
          tooltip: "Rotate",
          icon: const Icon(Icons.screen_rotation_alt),
          onPressed: _videoController == null
              ? null
              : () => setState(
                  () => _userQuarterTurns = (_userQuarterTurns + 1) % 4),
        ),
        IconButton(
          tooltip: _isExpanded ? "Shrink" : "Expand",
          icon: Icon(_isExpanded ? Icons.fullscreen_exit : Icons.fullscreen),
          // Portrait stays portrait: only this dialog grows.
          onPressed: () => setState(() => _isExpanded = !_isExpanded),
        ),
        IconButton(icon: const Icon(Icons.close), onPressed: _close),
      ],
    );
  }

  Widget _buildBody() {
    final VideoPlayerController? videoController = _videoController;

    if (videoController == null || !videoController.value.isInitialized) {
      return Container(
        color: ColorResources.black,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: videoController,
      builder: (context, value, child) {
        return Container(
          color: ColorResources.black,
          child: Stack(
            children: [
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, constraints) =>
                      Center(child: _buildVideoSurface(constraints, value)),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildControls(videoController, value),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Largest box with the recording's aspect ratio that fits the player area,
  /// rotated by [_quarterTurns]. `RotatedBox` swaps the child's constraints, so
  /// the video keeps its true shape — it is never stretched or squashed — and
  /// only the surface turns: the controls below stay upright.
  Widget _buildVideoSurface(BoxConstraints constraints, VideoPlayerValue value) {
    final int turns = _quarterTurns;
    final double videoAspectRatio =
        value.aspectRatio > 0 ? value.aspectRatio : 1.0;
    final double shownAspectRatio =
        turns.isOdd ? 1 / videoAspectRatio : videoAspectRatio;

    double width = constraints.maxWidth;
    double height = width / shownAspectRatio;
    if (height > constraints.maxHeight) {
      height = constraints.maxHeight;
      width = height * shownAspectRatio;
    }

    return SizedBox(
      width: width,
      height: height,
      child: RotatedBox(
        quarterTurns: turns,
        child: VideoPlayer(_videoController!),
      ),
    );
  }

  Widget _buildControls(
    VideoPlayerController videoController,
    VideoPlayerValue value,
  ) {
    return Container(
      height: _controlsHeight,
      color: Colors.black54,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32),
            iconSize: 22,
            icon: Icon(
              value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: ColorResources.white,
            ),
            onPressed: _togglePlayPause,
          ),
          CustomTextRegular(
            _formatDuration(value.position),
            fontSize: 10,
            maxLines: 1,
            color: ColorResources.white,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: VideoProgressIndicator(
                videoController,
                allowScrubbing: true,
                colors: VideoProgressColors(
                  playedColor: ColorResources.colorPrimary,
                  bufferedColor: ColorResources.white.withOpacity(0.4),
                  backgroundColor: ColorResources.white.withOpacity(0.2),
                ),
              ),
            ),
          ),
          CustomTextRegular(
            _formatDuration(value.duration),
            fontSize: 10,
            maxLines: 1,
            color: ColorResources.white,
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32),
            iconSize: 20,
            icon: Icon(
              _isMuted ? Icons.volume_off : Icons.volume_up,
              color: ColorResources.white,
            ),
            onPressed: _toggleMute,
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
