import 'package:astro_brahmand/model/live_order_history_model.dart';
import 'package:astro_brahmand/model/order_history_model.dart';
import 'package:astro_brahmand/model/product_order_model.dart';
import 'package:astro_brahmand/model/service_order_model.dart';
import 'package:astro_brahmand/model/wallet_history_model.dart';
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;

import '../../../../model/get_image_model.dart';
import '../../../../model/group_pooja_order_model.dart';
import '../../../../model/live_mandir_darshan_order_model.dart';
import '../../../../model/success_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../agora/videocall/model/service_start_video_call_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';

import '../model/recording_model.dart';
import '../widget/recording_audio_player_dialog.dart';
import '../widget/recording_video_player_dialog.dart';
class OrderController extends GetxController {

  final Dio _dio = Dio();
  num offsetCount = 0;
  num offsetGroupPoojaCount = 0;
  bool isNoMoreData = false;
  bool isNoMoreGroupPoojaData = false;
  ScrollController scrollController = ScrollController();
  ScrollController groupPoojaScrollController = ScrollController();

  final isCallLoading = false.obs;
  final isCallSuccess = false.obs;
  OrderHistoryModel orderHistoryModel = OrderHistoryModel();
  List<OrderHistoryData> orderHistoryData = [];

  final isWalletLoading = false.obs;
  final isWalletSuccess = false.obs;
  WalletHistoryModel walletHistoryModel = WalletHistoryModel();
  List<WalletHistoryData> walletHistoryData = [];

  final isProductLoading = false.obs;
  final isProductSuccess = false.obs;
  ProductOrderModel productOrderModel = ProductOrderModel();
  ProductOrderData productOrderData = ProductOrderData();

  final isServiceLoading = false.obs;
  final isServiceSuccess = false.obs;
  ServiceOrderModel serviceOrderModel = ServiceOrderModel();

  final isGroupPoojaLoading = false.obs;
  final isGroupPoojaSuccess = false.obs;
  GroupPoojaOrderModel groupPoojaOrderModel = GroupPoojaOrderModel();
  List<GroupPoojaOrderData> groupPoojaOrderData = [];

  // Get Images on Call
  final isImageLoading = false.obs;
  final isImageSuccess = false.obs;
  GetImageModel getImageModel = GetImageModel();

  //GroupPoojaLive
  SuccessModel groupPoojaLiveJoinModel = SuccessModel();

  //CancelGroupPooja
  SuccessModel cancelGroupPoojaOrderModel = SuccessModel();

  //VideoCall
  ServiceStartVideoCallModel startVideoCallModel = ServiceStartVideoCallModel();
  //Realtime
  late FirebaseDatabase db;
  late DatabaseReference dbReference;
  final String chatGroupChild = "SERVICE-VIDEO";

  final isLiveHistoryLoading = false.obs;
  final isLiveHistorySuccess = false.obs;
  LiveOrderHistoryModel liveOrderHistoryModel = LiveOrderHistoryModel();

  //Mandir Darshan
  SuccessModel liveJoinModel = SuccessModel();
  bool isNoMoreMandirDarshanData = false;
  final isMandirDarshanOrderListLoading = false.obs;
  final isMandirDarshanOrderListSuccess = false.obs;
  LiveMandirDarshanOrderModel liveMandirDarshanOrderModel = LiveMandirDarshanOrderModel();
  List<MandirDarshanOrderData> mandirDarshanOrderData = [];

  // ==================== CALL RECORDING ====================

  /// Signed recording URLs held in memory, keyed by the order's uniqueId.
  /// Never cleared on stop/complete — only when a URL turns out to be expired.
  final Map<String, String> _recordingUrlCache = {};

  /// API calls that are still in flight, keyed by uniqueId, so repeated taps
  /// on the same order share one request instead of firing duplicates.
  final Map<String, Future<String?>> _recordingUrlRequests = {};

  /// uniqueId of the recording that is currently selected (loading or playing).
  final RxString activeRecordingId = ''.obs;

  /// True while the URL is being fetched or the audio is buffering.
  final RxBool isRecordingLoading = false.obs;

  /// True only while the audio is actually playing.
  final RxBool isRecordingPlaying = false.obs;

  /// Bumped for every new play request. A request whose token no longer matches
  /// has been superseded and must not write state for a newer recording.
  int _recordingRequestToken = 0;

  /// Guards against duplicate taps while a toggle is still being processed.
  bool _isRecordingToggleBusy = false;

  /// Recordings play in a dialog that owns its player for its whole lifetime:
  /// [RecordingAudioPlayerDialog] for voice calls, [RecordingVideoPlayerDialog]
  /// for video calls. This controller keeps the URL cache, the request token
  /// and the button state, so both share them and only one recording is ever
  /// active.
  ///
  /// Holds the request token of the open recording dialog, or null when none
  /// is. Tracked by token rather than a bool so the close callback of a dialog
  /// that is still animating out cannot clear the flag of the one replacing it.
  int? _openRecordingDialogToken;

  /// A call recording exists for voice calls (`call_type` "call") and video
  /// calls (`call_type` "video"). Chat and every other order type have none.
  bool canPlayRecording(String? callType) {
    final String type = callType?.toString().trim().toLowerCase() ?? "";
    return type == AppConstants.call || type == AppConstants.video;
  }

  /// Whether the order's `call_type` means the recording is a video file.
  /// The API endpoint is the same either way — only the returned URL differs.
  bool isVideoRecording(String? callType) =>
      (callType?.toString().trim().toLowerCase() ?? "") == AppConstants.video;

  bool isRecordingActive(String uniqueId) =>
      uniqueId.isNotEmpty && activeRecordingId.value == uniqueId;

  bool isRecordingLoadingFor(String uniqueId) =>
      isRecordingActive(uniqueId) && isRecordingLoading.value;

  bool isRecordingPlayingFor(String uniqueId) =>
      isRecordingActive(uniqueId) && isRecordingPlaying.value;

  /// Start playback for [uniqueId], or stop it when it is already active.
  ///
  /// [isVideo] selects the player: video-call recordings open the video
  /// dialog, voice-call recordings the audio dialog. Only one recording can
  /// play at a time, whichever player it uses. The signed URL is fetched once
  /// per uniqueId and reused from [_recordingUrlCache] on every later play, for
  /// both media types.
  Future<void> toggleRecording(String uniqueId, {bool isVideo = false}) async {
    final String recordingId = uniqueId.trim();
    if (recordingId.isEmpty || recordingId == 'null') {
      CustomSnackBar.showBottom('Recording not available');
      return;
    }

    // Duplicate-click protection: ignore taps while a toggle is in progress.
    if (_isRecordingToggleBusy) return;
    _isRecordingToggleBusy = true;

    try {
      // Tapping the active recording stops it. The cached URL is kept.
      if (isRecordingActive(recordingId) &&
          (isRecordingPlaying.value || isRecordingLoading.value)) {
        await stopRecording();
        return;
      }

      // Any request started earlier is now stale.
      final int token = ++_recordingRequestToken;

      // Only one recording may play at a time — across both players.
      await _stopActivePlayback();

      activeRecordingId.value = recordingId;
      isRecordingLoading(true);
      isRecordingPlaying(false);

      final String? cachedUrl = _recordingUrlCache[recordingId];
      final String? recordingUrl =
          cachedUrl ?? await _resolveRecordingUrl(recordingId);

      // A newer recording was requested while this one was loading.
      if (token != _recordingRequestToken) return;

      if (recordingUrl == null || recordingUrl.trim().isEmpty) {
        _resetRecordingState(token);
        return;
      }

      _openRecordingDialog(
        recordingId: recordingId,
        url: recordingUrl,
        token: token,
        isVideo: isVideo,
        // Only a cached URL can be stale; a URL just returned by the API is not.
        allowRefresh: cachedUrl != null,
      );
    } catch (e) {
      AppLogger.d('OnExceptionToggleRecording==> ${e.toString()}');
      _resetRecordingState();
      CustomSnackBar.showBottom('Unable to play recording');
    } finally {
      _isRecordingToggleBusy = false;
    }
  }

  /// Stop playback and return to the initial state. The URL cache is untouched.
  Future<void> stopRecording() async {
    // Invalidate anything still in flight so it cannot resume playback.
    _recordingRequestToken++;
    await _stopActivePlayback();
    _resetRecordingState();
  }

  /// Opens the player for this recording: the audio dialog for a voice call,
  /// the video dialog for a video call. Each owns its player for its whole
  /// lifetime and reports playback back through the callbacks below, tagged
  /// with [token]. Closing the dialog — its close button, the system back
  /// button or a tap outside it — stops playback, so nothing keeps playing once
  /// the user leaves the screen or switches tabs.
  ///
  /// Both dialogs refresh an expired signed URL once themselves via
  /// [refreshRecordingUrl] when [allowRefresh] is true.
  void _openRecordingDialog({
    required String recordingId,
    required String url,
    required int token,
    required bool allowRefresh,
    required bool isVideo,
  }) {
    _recordingUrlCache[recordingId] = url;

    if (_openRecordingDialogToken != null) return;
    _openRecordingDialogToken = token;

    final Widget dialog = isVideo
        ? RecordingVideoPlayerDialog(
            controller: this,
            recordingId: recordingId,
            url: url,
            sessionToken: token,
            allowRefresh: allowRefresh,
          )
        : RecordingAudioPlayerDialog(
            controller: this,
            recordingId: recordingId,
            url: url,
            sessionToken: token,
            allowRefresh: allowRefresh,
          );

    unawaited(
      Get.dialog(dialog).whenComplete(() {
        if (_openRecordingDialogToken != token) return;
        _openRecordingDialogToken = null;
        // The route future completes the moment the dialog is popped, however
        // it was closed. Resetting here as well as in the dialog's dispose
        // means the button can never be left showing "Stop" if the widget is
        // torn down late or out of order. Both paths are idempotent.
        onRecordingClosed(token);
      }),
    );
  }

  /// Drops the cached URL for [uniqueId] and signs a new one. Called by the
  /// recording dialogs when playback fails on a URL that came from the cache.
  Future<String?> refreshRecordingUrl(String uniqueId) {
    _recordingUrlCache.remove(uniqueId);
    return _resolveRecordingUrl(uniqueId);
  }

  /// The dialog is playing: leave "Stop" showing for this recording.
  void onRecordingStarted(int token) {
    if (token != _recordingRequestToken) return;
    if (_openRecordingDialogToken != token) return;
    isRecordingLoading(false);
    isRecordingPlaying(true);
  }

  /// Mirrors the real player state onto the button, so "Stop" shows only while
  /// the recording is actually playing.
  void onRecordingStateChanged(
    int token, {
    required bool isPlaying,
    required bool isBuffering,
  }) {
    if (token != _recordingRequestToken) return;
    // Once the dialog has been popped its player may still emit a last update;
    // ignore it so it cannot revive "Stop" after the reset.
    if (_openRecordingDialogToken != token) return;
    isRecordingLoading(isBuffering);
    isRecordingPlaying(isPlaying);
  }

  /// Playback finished — back to "Recording", cached URL kept.
  void onRecordingCompleted(int token) {
    if (token != _recordingRequestToken) return;
    _resetRecordingState(token);
  }

  void onRecordingFailed(int token) {
    if (token != _recordingRequestToken) return;
    _resetRecordingState(token);
    CustomSnackBar.showBottom('Unable to play recording');
  }

  /// The dialog was closed. A stale token means a newer recording already took
  /// over, so this close must not touch its state.
  void onRecordingClosed(int token) {
    if (token != _recordingRequestToken) return;
    _resetRecordingState(token);
  }

  /// Stops whichever recording is active by closing its dialog, which releases
  /// its own player on unmount. The token was already bumped by the caller, so
  /// the dialog's close callback is stale and cannot reset the state of the
  /// recording replacing it.
  Future<void> _stopActivePlayback() async {
    _closeRecordingDialog();
  }

  void _closeRecordingDialog() {
    if (_openRecordingDialogToken == null) return;
    _openRecordingDialogToken = null;
    if (Get.isDialogOpen ?? false) Get.back();
  }

  /// Fetch the signed URL for [uniqueId], sharing an in-flight call if one is
  /// already running for the same uniqueId, and cache the result.
  Future<String?> _resolveRecordingUrl(String uniqueId) async {
    final Future<String?>? inFlightRequest = _recordingUrlRequests[uniqueId];
    if (inFlightRequest != null) return inFlightRequest;

    final Future<String?> request = getAgoraRecordingUrl(uniqueId);
    _recordingUrlRequests[uniqueId] = request;
    try {
      final String? url = await request;
      if (url != null && url.trim().isNotEmpty) {
        _recordingUrlCache[uniqueId] = url;
      }
      return url;
    } finally {
      if (identical(_recordingUrlRequests[uniqueId], request)) {
        _recordingUrlRequests.remove(uniqueId);
      }
    }
  }

  /// Back to the initial "Recording" state. When [token] is given the reset is
  /// skipped if a newer request has already taken over.
  void _resetRecordingState([int? token]) {
    if (token != null && token != _recordingRequestToken) return;
    activeRecordingId.value = '';
    isRecordingLoading(false);
    isRecordingPlaying(false);
  }

  /// POST AppConstants.getAgoraRecordingUrl as multipart/form-data and return
  /// the signed MP4 URL, or null when the recording is not available.
  Future<String?> getAgoraRecordingUrl(String uniqueId) async {
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final FormData formData = FormData.fromMap({
        'api_key': apiKey,
        'user_uni_id': uniId,
        'uniqeid': uniqueId,
      });

      final response = await _dio.post(
        AppConstants.getAgoraRecordingUrl,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      if (response.statusCode == 200) {
        final dynamic body = response.data is String
            ? jsonDecode(response.data as String)
            : response.data;

        final RecordingModel recordingModel =
            RecordingModel.fromJson(Map<String, dynamic>.from(body as Map));

        if (recordingModel.status == AppConstants.success &&
            (recordingModel.url?.trim().isNotEmpty ?? false)) {
          return recordingModel.url;
        }

        CustomSnackBar.showBottom(
          recordingModel.msg?.trim().isNotEmpty == true
              ? recordingModel.msg!
              : 'Recording not available',
        );
      } else {
        AppLogger.d('OnApiErrorGetAgoraRecordingUrl');
        CustomSnackBar.showBottom('Unable to get recording');
      }
    } catch (e) {
      AppLogger.d('OnExceptionGetAgoraRecordingUrl==> ${e.toString()}');
      CustomSnackBar.showBottom('Something went wrong while getting recording');
    }

    return null;
  }

  @override
  void onClose() {
    _closeRecordingDialog();
    scrollController.dispose();
    groupPoojaScrollController.dispose();

    super.onClose();
  }

  Future<void> getCallHistory(String type,num offset) async {
    if(offset == 0){
      offsetCount = 0;
      isNoMoreData = false;
      orderHistoryData.clear();
    }

    isCallLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.userCallHistory, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'call_type': type,
        "offset": offset
      });
      if (response.statusCode == 200) {
        orderHistoryModel = OrderHistoryModel.fromJson(response.data);
        if(orderHistoryModel.status == AppConstants.success){
          offsetCount = orderHistoryModel.offset!;
          isCallSuccess(true);

          for (var element in (orderHistoryModel.data ?? [])) {
            orderHistoryData.add(element);
          }
        }
        else{
          if(offset == 0){
            isCallSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isCallLoading(false);
    }
  }

  Future<void> getWalletHistory(num offset) async {
    if(offset == 0){
      offsetCount = 0;
      isNoMoreData = false;
      walletHistoryData.clear();
    }

    isWalletLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getWalletHistory, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        "offset": offset
      });
      if (response.statusCode == 200) {
        walletHistoryModel = WalletHistoryModel.fromJson(response.data);
        if(walletHistoryModel.status == AppConstants.success){
          offsetCount = walletHistoryModel.offset!;
          isWalletSuccess(true);

          for (var element in (walletHistoryModel.data ?? [])) {
            walletHistoryData.add(element);
          }
        }
        else{
          if(offset == 0){
            isWalletSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isWalletLoading(false);
    }
  }

  Future<void> getShopOrder() async {
    isProductLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getShopOrder, data: {
        'api_key': apiKey,
        'user_uni_id': uniId
      });
      if (response.statusCode == 200) {
        // print('API getProductOrder Response: ${response.data}');
        productOrderModel = ProductOrderModel.fromJson(response.data);
        if(productOrderModel.status == AppConstants.success){
          isProductSuccess(true);
        }
        else{
          isProductSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isProductLoading(false);
    }
  }

  //Service
  Future<void> getServiceOrder() async {
    isServiceLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getServiceOrder, data: {
        'api_key': apiKey,
        'user_uni_id': uniId
      });
      if (response.statusCode == 200) {
        AppLogger.d('API getServiceOrder Response: ${response.data}');
        serviceOrderModel = ServiceOrderModel.fromJson(response.data);
        if(serviceOrderModel.status == AppConstants.success){
          isServiceSuccess(true);
        }
        else{
          isServiceSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isServiceLoading(false);
    }
  }

  Future<void> startServiceVideoCall(String? orderId,String? astrologerUniId) async {
    int notificationStatus = 1;
    String? customerUniUd = await SharedPreferencesHelper.getData(AppConstants.userUniId);
    String channelName = '$customerUniUd-$astrologerUniId-Video';
    db = FirebaseDatabase.instance;
    dbReference = db.ref(chatGroupChild).child(channelName);
    DataSnapshot chatEndSnapshot = await dbReference.child('chatEnd').get();
    if (chatEndSnapshot.exists && chatEndSnapshot.value == false) {
      notificationStatus = 0;
    }

    CustomProgressDialog.showDialog();
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.startServiceVideoCall, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'order_id': orderId,
        'started_by': "Customer",
        'notification_status': notificationStatus,
      });

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        startVideoCallModel = ServiceStartVideoCallModel.fromJson(response.data);
        if (startVideoCallModel.status == AppConstants.success) {
          Get.back();

          String? agoraAppId = await SharedPreferencesHelper.getData(AppConstants.agoraAppId);
          String channelName = '$customerUniUd-$astrologerUniId-Video';

        //  print("StartVideoCall Data-> channel:$channelName uniqueId:${startVideoCallModel.data?.uniqeid.toString()} agoraAppId:$agoraAppId token:${startVideoCallModel.data!.agoraToken.toString()}");
          Get.toNamed('/serviceVideoCallScreen',arguments: {
            'channelName' : channelName,
            'uniqueId' : orderId,
            'agoraAppId' : agoraAppId,
            'token' : startVideoCallModel.token.toString(),
          });
        } else {
          //Handle error code here
            CustomSnackBar.showBottom(startVideoCallModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
    }
  }

  //GroupPooja
  Future<void> getGroupPoojaOrder(num offset) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (offset == 0) {
        offsetCount = 0;
        isNoMoreGroupPoojaData = false;
        groupPoojaOrderData.clear();
      }

      isGroupPoojaLoading(true);
      try {
        String? apiKey = await SharedPreferencesHelper.getData(
            AppConstants.userApiKey);
        String? uniId = await SharedPreferencesHelper.getData(
            AppConstants.userUniId);
        final response = await _dio.post(
            AppConstants.getCustomerGroupPujaOrder, data: {
          'api_key': apiKey,
          'user_uni_id': uniId,
          'offset': offset,
        });
        AppLogger.d('API getGroupPoojaOrder Response: ${response.data}');
        if (response.statusCode == 200) {
          groupPoojaOrderModel = GroupPoojaOrderModel.fromJson(response.data);
          if (groupPoojaOrderModel.status == AppConstants.success) {
            offsetCount = groupPoojaOrderModel.offset!;
            isGroupPoojaSuccess(true);
            if (groupPoojaOrderModel.data != null &&
                groupPoojaOrderModel.data!.isNotEmpty) {
              for (var element in (groupPoojaOrderModel.data ?? [])) {
                groupPoojaOrderData.add(element);
              }
            }
          }
          else {
            if (offset == 0) {
              isGroupPoojaSuccess(false);
            }
            isNoMoreGroupPoojaData = true;
          }
        } else {
          AppLogger.d('OnApiError');
        }
      } catch (e) {
        AppLogger.d('OnException==> ${e.toString()}');
      } finally {
        isGroupPoojaLoading(false);
      }
    });
  }


  Future<void> joinGroupPoojaLiveStream(String orderId, String astrologerUniId, String uniqueId, String groupPoojaAssignId) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? agoraAppId = await SharedPreferencesHelper.getData(AppConstants.agoraAppId);
      final response = await _dio.post(AppConstants.joinGroupPuja, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'order_id' : orderId,
        'group_puja_assign_id' : groupPoojaAssignId,
        'started_by' : "Customer"
      });
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        groupPoojaLiveJoinModel = SuccessModel.fromJson(response.data);
        if(groupPoojaLiveJoinModel.status == AppConstants.success){
          AppLogger.d("GroupPoojaLiveSuccess -> ${response.data.toString()}");
          String? token = response.data["token"];
          Get.toNamed('/groupPoojaLiveStreamScreen',arguments: {
            'uniqueId': uniqueId,
            'agoraAppId': agoraAppId,
            'token': token,
            'astrologerId': astrologerUniId,
            'astrologerUID': response.data["astrologer"]!["id"]!.toInt(),
            'orderId': orderId,
            'groupPoojaAssignId': groupPoojaAssignId
          });
        }else{
          CustomSnackBar.showBottom(groupPoojaLiveJoinModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      getCustomerMandirDarshanOrder(0);
      AppLogger.d('OnException==> ${e.toString()}');
    }
  }

  Future<void> cancelGroupPoojaOrder(String orderId) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.cancelGroupPujaByCustomerApi, data: {
        'api_key': apiKey,
        'customer_uni_id': uniId,
        'order_id': orderId,
      });
      AppLogger.d("orderId$orderId");
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('Cancel Group Pooja Response: ${response.data}');
        cancelGroupPoojaOrderModel = SuccessModel.fromJson(response.data);
        if(cancelGroupPoojaOrderModel.status == AppConstants.success){
          CustomSnackBar.showTop(cancelGroupPoojaOrderModel.msg.toString());
          getGroupPoojaOrder(0);
        }
        else{
          CustomSnackBar.showBottom(cancelGroupPoojaOrderModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    }
  }

  Future<void> getCustomerMandirDarshanOrder(num offset) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (offset == 0) {
        offsetCount = 0;
        isNoMoreMandirDarshanData = false;
        mandirDarshanOrderData.clear();
      }

      isMandirDarshanOrderListLoading(true);
      try {
        String? apiKey = await SharedPreferencesHelper.getData(
            AppConstants.userApiKey);
        String? uniId = await SharedPreferencesHelper.getData(
            AppConstants.userUniId);
        final response = await _dio.post(
            AppConstants.getCustomerMandirDarshanOrder, data: {
          'api_key': apiKey,
          'user_uni_id': uniId,
          'offset': offset,
        });
        AppLogger.d('API getCustomerMandirDarshanOrder Response: ${response.data}');
        if (response.statusCode == 200) {
          liveMandirDarshanOrderModel =
              LiveMandirDarshanOrderModel.fromJson(response.data);
          if (liveMandirDarshanOrderModel.status == AppConstants.success) {
            offsetCount = liveMandirDarshanOrderModel.offset!;
            isMandirDarshanOrderListSuccess(true);
            if (liveMandirDarshanOrderModel.data != null &&
                liveMandirDarshanOrderModel.data!.isNotEmpty) {
              for (var element in (liveMandirDarshanOrderModel.data ?? [])) {
                mandirDarshanOrderData.add(element);
              }
            }
          }
          else {
            if (offset == 0) {
              isMandirDarshanOrderListSuccess(false);
            }
            isNoMoreMandirDarshanData = true;
          }
        } else {
          AppLogger.d('OnApiErrorGetCustomerMandirDarshanOrder');
        }
      } catch (e) {
        AppLogger.d('OnExceptionGetCustomerMandirDarshanOrder==> ${e.toString()}');
      } finally {
        isMandirDarshanOrderListLoading(false);
      }
    });
  }

  Future<void> joinMandirDarshan(String astrologerUniId, String uniqueId, String assignId) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? agoraAppId = await SharedPreferencesHelper.getData(AppConstants.agoraAppId);
      AppLogger.d("$apiKey $uniId $assignId Customer");
      final response = await _dio.post(AppConstants.joinMandirDarshan, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'live_temple_darshan_assign_id' : assignId,
        'started_by' : "Customer"
      });
      AppLogger.d("responseTemple:::$response");
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        liveJoinModel = SuccessModel.fromJson(response.data);
        if(liveJoinModel.status == AppConstants.success){
          String? token = response.data["token"];
          Get.toNamed('/liveStreamScreen',arguments: {
            'uniqueId': uniqueId,
            'agoraAppId': agoraAppId,
            'token': token,
            'astrologerId': astrologerUniId,
            'astrologerUID': response.data["astrologer"]!["id"]!.toInt()
          });
          AppLogger.d("As1 Req $token $uniqueId $agoraAppId $astrologerUniId ${response.data["astrologer"]!["id"]!.toInt()}");
        }else{
          CustomSnackBar.showBottom(liveJoinModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiErrorJoinMandirDarshan');
      }
    } catch (e) {
      AppLogger.d('OnExceptionJoinMandirDarshan==> ${e.toString()}');
    } finally {
      CustomProgressDialog.dismissDialog();
    }
  }

  Future<void> getLiveOrderHistory(String giftType, num offset) async {
    isLiveHistoryLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getLiveGiftHistory, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'gift_type ': giftType,
        'offset ': offset,
      });
      if (response.statusCode == 200) {
        AppLogger.d('API liveOrderHistoryModel Response: ${response.data}');
        liveOrderHistoryModel = LiveOrderHistoryModel.fromJson(response.data);
        if(liveOrderHistoryModel.status == AppConstants.success){
          isLiveHistorySuccess(true);
        }
        else{
          isLiveHistorySuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isLiveHistoryLoading(false);
    }
  }

  String formatDuration(String durationString) {
    try {
      int totalSecs = int.tryParse(durationString) ?? 0;
      int hours = totalSecs ~/ 3600;
      int minutes = (totalSecs % 3600) ~/ 60;
      int seconds = totalSecs % 60;
      return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    } catch (e) {
      return "00:00:00";
    }
  }

  Future<void> getImage(String uniqueId) async {
    isImageSuccess(false);
    isImageLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getFileOnCall,data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "uniqeid" : uniqueId,
        "send_by" : "Astrologer",
      });

      if (response.statusCode == 200) {
        getImageModel = GetImageModel.fromJson(response.data);
        if(getImageModel.status == AppConstants.success){
          if(getImageModel.data!.isNotEmpty) {
            isImageSuccess(true);
          }
        }
        else{
          isImageSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isImageLoading(false);
    }
  }

}