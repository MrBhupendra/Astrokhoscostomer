import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../../utill/app_logger.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../controller/order_controller.dart';

/// Music-player style dialog for a voice-call recording.
///
/// The dialog owns its `AudioPlayer` for its whole lifetime: it is created in
/// [initState] and released in [dispose]. Because the player lives and dies
/// with this route, closing the dialog — the close button, the system back
/// button or a tap outside it — always stops the recording, and nothing keeps
/// playing after the user leaves the screen or switches tabs.
///
/// [OrderController] keeps owning the signed-URL cache, the request token and
/// the Recording button state; this dialog only reports playback back to it.
class RecordingAudioPlayerDialog extends StatefulWidget {
  final OrderController controller;

  /// uniqeid of the recording, used when a stale signed URL must be refreshed.
  final String recordingId;

  final String url;

  /// Request token of the tap that opened this dialog. Every callback carries
  /// it so a superseded dialog can never write state for a newer recording.
  final int sessionToken;

  /// False when [url] came straight from the API and cannot be stale yet.
  final bool allowRefresh;

  const RecordingAudioPlayerDialog({
    super.key,
    required this.controller,
    required this.recordingId,
    required this.url,
    required this.sessionToken,
    required this.allowRefresh,
  });

  @override
  State<RecordingAudioPlayerDialog> createState() =>
      _RecordingAudioPlayerDialogState();
}

class _RecordingAudioPlayerDialogState
    extends State<RecordingAudioPlayerDialog> {
  AudioPlayer? _player;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<PlayerState>? _stateSubscription;
  StreamSubscription<void>? _completeSubscription;

  /// Bumped for every initialization attempt and once more in [dispose], so a
  /// result that arrives late is dropped instead of being used.
  int _initSession = 0;

  bool _isDisposed = false;
  bool _hasFailed = false;
  bool _isReady = false;

  /// Plays through the loudspeaker by default; the route button switches to
  /// the earpiece for private listening.
  bool _isSpeaker = true;
  bool _isSwitchingRoute = false;

  PlayerState _playerState = PlayerState.stopped;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  /// Slider value while the thumb is being dragged, so position updates from
  /// the player do not fight the user's finger.
  double? _dragPositionMs;

  static const double _dialogWidthFactor = 0.8;
  static const Duration _skipStep = Duration(seconds: 10);

  @override
  void initState() {
    super.initState();
    _initialize(widget.url, allowRefresh: widget.allowRefresh);
  }

  /// Audio route for the recording.
  ///
  /// A finished Agora call can leave Android's AudioManager in communication
  /// mode, which sends plain media playback to the earpiece. Setting the
  /// context explicitly sets that global mode each time, so the chosen route
  /// is the one actually used.
  AudioContext _audioContext({required bool speaker}) {
    return AudioContext(
      android: AudioContextAndroid(
        isSpeakerphoneOn: speaker,
        audioMode: speaker
            ? AndroidAudioMode.normal
            : AndroidAudioMode.inCommunication,
        stayAwake: false,
        contentType: AndroidContentType.speech,
        usageType: speaker
            ? AndroidUsageType.media
            : AndroidUsageType.voiceCommunication,
        audioFocus: AndroidAudioFocus.gain,
      ),
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playAndRecord,
        options: speaker ? const {AVAudioSessionOptions.defaultToSpeaker} : const {},
      ),
    );
  }

  /// Creates the player for [url] once. A failure on a cached URL means the S3
  /// signature has most likely expired: that entry is dropped, a fresh URL is
  /// requested and initialization is retried exactly once.
  Future<void> _initialize(String url, {required bool allowRefresh}) async {
    final int session = ++_initSession;
    final AudioPlayer player = AudioPlayer();

    try {
      await player.setReleaseMode(ReleaseMode.stop);
      await player.setAudioContext(_audioContext(speaker: _isSpeaker));
      // Awaits the prepared event, so an expired signed URL throws here.
      await player.setSourceUrl(url);
    } catch (e) {
      AppLogger.d('OnExceptionInitRecordingAudio==> ${e.toString()}');
      await player.dispose();
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
    // still loading — drop the result instead of playing it.
    if (!_isCurrent(session)) {
      await player.dispose();
      return;
    }

    _player = player;
    _positionSubscription = player.onPositionChanged.listen((position) {
      if (!mounted || _isDisposed) return;
      setState(() => _position = position);
    });
    _durationSubscription = player.onDurationChanged.listen((duration) {
      if (!mounted || _isDisposed) return;
      setState(() => _duration = duration);
    });
    _stateSubscription = player.onPlayerStateChanged.listen(_onPlayerStateChanged);
    _completeSubscription = player.onPlayerComplete.listen((_) => _onCompleted());

    final Duration? duration = await player.getDuration();
    if (!_isCurrent(session)) return;

    setState(() {
      _isReady = true;
      if (duration != null) _duration = duration;
    });

    await player.resume();
    if (!_isCurrent(session)) return;

    widget.controller.onRecordingStarted(widget.sessionToken);
  }

  /// True while [session] is still the live attempt and the widget is alive.
  bool _isCurrent(int session) =>
      mounted && !_isDisposed && session == _initSession;

  void _onPlayerStateChanged(PlayerState state) {
    if (!mounted || _isDisposed) return;
    setState(() => _playerState = state);

    // Switching the route re-prepares the source on Android, which briefly
    // stops it; that is not the user stopping playback.
    if (_isSwitchingRoute) return;

    widget.controller.onRecordingStateChanged(
      widget.sessionToken,
      isPlaying: state == PlayerState.playing,
      isBuffering: false,
    );
  }

  void _onCompleted() {
    if (_isDisposed) return;
    widget.controller.onRecordingCompleted(widget.sessionToken);
    _close();
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
    _player?.pause();

    final ModalRoute<Object?>? route = ModalRoute.of(context);
    if (route != null && route.isCurrent) Navigator.of(context).pop();
  }

  Future<void> _togglePlayPause() async {
    final AudioPlayer? player = _player;
    if (player == null || !_isReady) return;

    if (_playerState == PlayerState.playing) {
      await player.pause();
      return;
    }
    await player.resume();
  }

  Future<void> _skip(Duration step) async {
    final AudioPlayer? player = _player;
    if (player == null || !_isReady) return;

    Duration target = _position + step;
    if (target < Duration.zero) target = Duration.zero;
    if (_duration > Duration.zero && target > _duration) target = _duration;
    await player.seek(target);
  }

  /// Moves playback between the loudspeaker and the earpiece.
  ///
  /// On Android a new audio context re-prepares the source, which stops it, so
  /// the position is restored and playback resumed if it was playing.
  Future<void> _toggleRoute() async {
    final AudioPlayer? player = _player;
    if (player == null || !_isReady || _isSwitchingRoute) return;

    final bool toSpeaker = !_isSpeaker;
    final Duration resumeAt = _position;
    final bool wasPlaying = _playerState == PlayerState.playing;

    setState(() {
      _isSwitchingRoute = true;
      _isSpeaker = toSpeaker;
    });

    try {
      await player.setAudioContext(_audioContext(speaker: toSpeaker));
      await player.seek(resumeAt);
      if (wasPlaying) await player.resume();
    } catch (e) {
      AppLogger.d('OnExceptionSwitchRecordingRoute==> ${e.toString()}');
    } finally {
      if (mounted && !_isDisposed) setState(() => _isSwitchingRoute = false);
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    // Invalidate any initialization still in flight.
    _initSession++;

    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _stateSubscription?.cancel();
    _completeSubscription?.cancel();

    final AudioPlayer? player = _player;
    _player = null;
    if (player != null) unawaited(_releasePlayer(player));

    widget.controller.onRecordingClosed(widget.sessionToken);

    super.dispose();
  }

  /// Stops and releases the player, then puts the global audio route back to
  /// the neutral default so the earpiece/speaker choice made here does not
  /// leak into other audio in the app.
  static Future<void> _releasePlayer(AudioPlayer player) async {
    try {
      await player.stop();
      await player.dispose();
      await AudioPlayer.global.setAudioContext(AudioContext());
    } catch (e) {
      AppLogger.d('OnExceptionReleaseRecordingAudio==> ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double dialogWidth =
        MediaQuery.sizeOf(context).width * _dialogWidthFactor;

    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: ColorResources.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: dialogWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            _buildArtwork(),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            if (_isReady) ...[
              _buildSeekBar(),
              _buildTransportControls(),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              _buildRouteButton(),
            ] else
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: CircularProgressIndicator(),
              ),
            const SizedBox(height: Dimensions.paddingSizeDefault),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Expanded(child: CustomTextMedium("Call Recording", maxLines: 1)),
          IconButton(icon: const Icon(Icons.close), onPressed: _close),
        ],
      ),
    );
  }

  Widget _buildArtwork() {
    final bool isPlaying = _playerState == PlayerState.playing;

    return Container(
      width: 112,
      height: 112,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorResources.colorPrimary.withOpacity(0.08),
        border: Border.all(
          color: ColorResources.colorPrimary.withOpacity(isPlaying ? 0.6 : 0.2),
          width: 2,
        ),
      ),
      child: Icon(
        isPlaying ? Icons.graphic_eq_rounded : Icons.call_rounded,
        size: 52,
        color: ColorResources.colorPrimary,
      ),
    );
  }

  Widget _buildSeekBar() {
    final double maxMs = _duration.inMilliseconds.toDouble();
    final double positionMs = _dragPositionMs ??
        _position.inMilliseconds.toDouble().clamp(0.0, maxMs > 0 ? maxMs : 0.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: Column(
        children: [
          Slider(
            value: maxMs > 0 ? positionMs.clamp(0.0, maxMs) : 0.0,
            max: maxMs > 0 ? maxMs : 1.0,
            activeColor: ColorResources.colorPrimary,
            inactiveColor: ColorResources.colorPrimary.withOpacity(0.2),
            onChanged: maxMs > 0
                ? (value) => setState(() => _dragPositionMs = value)
                : null,
            onChangeEnd: maxMs > 0
                ? (value) async {
                    await _player?.seek(Duration(milliseconds: value.round()));
                    if (mounted) setState(() => _dragPositionMs = null);
                  }
                : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextRegular(
                  _formatDuration(Duration(milliseconds: positionMs.round())),
                  fontSize: Dimensions.fontSizeSmall,
                  maxLines: 1,
                  color: ColorResources.black1,
                ),
                CustomTextRegular(
                  _formatDuration(_duration),
                  fontSize: Dimensions.fontSizeSmall,
                  maxLines: 1,
                  color: ColorResources.black1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransportControls() {
    final bool isPlaying = _playerState == PlayerState.playing;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 32,
          tooltip: "Back 10s",
          icon: const Icon(Icons.replay_10_rounded),
          color: ColorResources.colorPrimary,
          onPressed: () => _skip(-_skipStep),
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        Material(
          color: ColorResources.colorPrimary,
          shape: const CircleBorder(),
          child: IconButton(
            iconSize: 36,
            icon: Icon(
              isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: ColorResources.white,
            ),
            onPressed: _togglePlayPause,
          ),
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        IconButton(
          iconSize: 32,
          tooltip: "Forward 10s",
          icon: const Icon(Icons.forward_10_rounded),
          color: ColorResources.colorPrimary,
          onPressed: () => _skip(_skipStep),
        ),
      ],
    );
  }

  Widget _buildRouteButton() {
    return OutlinedButton.icon(
      onPressed: _isSwitchingRoute ? null : _toggleRoute,
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorResources.colorPrimary,
        side: BorderSide(color: ColorResources.colorPrimary.withOpacity(0.6)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
        ),
      ),
      icon: Icon(
        _isSpeaker ? Icons.volume_up_rounded : Icons.phone_in_talk_rounded,
        size: 20,
      ),
      label: CustomTextRegular(
        _isSpeaker ? "Speaker" : "Earpiece",
        fontSize: Dimensions.fontSizeSmall,
        maxLines: 1,
        color: ColorResources.colorPrimaryDark,
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
