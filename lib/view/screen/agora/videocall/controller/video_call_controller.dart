import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../utill/app_constants.dart';
import '../../../../../utill/app_strings.dart';
import '../../../../../utill/common_methods.dart';
import '../../../../../utill/images.dart';
import '../../../../../utill/shared_preference.dart';
import '../../../../widget/custom_dialog_widget.dart';
import '../../../chat/controller/chat_intake_form_controller.dart';
import '../../../chat/model/chat_birth_model.dart';
import '../../../chat/model/chat_remaining_time_model.dart';
import '../../../chat/model/chat_session_model.dart';
import '../../../dashboard/controller/dashboard_controller.dart';
import '../../../feedback/feedback_screen.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter/material.dart';

import '../../../wallet/controller/wallet_controller.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class VideoCallController extends FullLifeCycleController with FullLifeCycleMixin {
 final ChatIntakeFormController chatIntakeFormController = Get.find();

  //Realtime
  late FirebaseDatabase db;
  late DatabaseReference dbReference;

  final String chatGroupChild = "CHAT";
  final String birthChild = "birth";
  final String customerStatus = "customer_status";
  final String chatEnd = "chatEnd";
  final String chatAcceptedChild = "chatAccepted";
  final String chatDeclinedByChild = "chatDeclinedBy";

  var isChatEnd = false.obs;
  var isChatAccepted = false.obs;
  bool isReview = false;

  //Listeners
  var chatAcceptedListener;
  var chatEndListener;
 var durationListener;

 //Agora
  late String agoraAppId;
  late String agoraToken;
  late String uniqueId;
  late String channelName;

  late RtcEngine engine;
  RxInt remoteUid = 0.obs;
  RxBool localUserJoined = false.obs;
  RxBool muted = false.obs;
  RxBool mutedVideo = false.obs;

  //getRemainingTime
  final Dio _dio = Dio();
  final isGetTimeLoading = false.obs;
  final isGetTimeSuccess = false.obs;
  ChatRemainingTimeModel chatRemainingTimeModel = ChatRemainingTimeModel();

 //Timer
 RxInt seconds = 60.obs;
 RxInt popupAfterDuration = 60.obs;
 RxBool isTimerRunning = false.obs;
 Timer? _timer;
 bool _isDisposed = false;
 bool _hasShownLowBalanceDialog = false;

 // Remaining offer time
 RxInt offerSeconds = 0.obs;

 final RxBool isRemoteVideoMuted = false.obs;
 final RxBool isRemoteUserMuted = false.obs;

 bool isBackPressed = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    startOnGoingCallNotification(seconds.value);
    startMicNotification();
    if (Get.context != null) {
      try {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          try {
            WakelockPlus.enable();
          } catch (e) {
            AppLogger.d("[VCController] Failed to enable wakelock: $e");
          }
        });
      } catch (e) {
        AppLogger.d("[VCController] Failed to enable wakelock: $e");
      }
    }
    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    channelName = arguments['channelName'] ?? '';
    uniqueId = arguments['uniqueId'] ?? '';
    agoraAppId = arguments['agoraAppId'] ?? '';
    agoraToken = arguments['token'] ?? '';

    AppLogger.d("VCController Data-> channel:$channelName uniqueId:$uniqueId agoraAppId:$agoraAppId token:$agoraToken");

    db = FirebaseDatabase.instance;
    dbReference = db.ref(chatGroupChild).child(channelName);
    DataSnapshot chatEndSnapshot = await dbReference.child('chatEnd').get();
    DataSnapshot chatIdSnapshot = await dbReference.child('chatId').get();
    final bool sameActiveSession = chatEndSnapshot.exists &&
        chatEndSnapshot.value == false &&
        chatIdSnapshot.exists &&
        chatIdSnapshot.value?.toString() == uniqueId;

    if (sameActiveSession) {
      isChatAccepted(true);
      getRemainingDuration(uniqueId);
      _ensureBirthDataWritten();
    } else {
      AppLogger.d('No data available or new session.');
      playSound();
      isChatEnd.value = false;
      await initChatSession(
        ChatSessionModel(
            chatId: uniqueId,
            chatAccepted: false,
            chatEnd: false,
            customerStatus: true,
            duration: seconds.value,
            chatDeclinedBy: "",
            type: chatIntakeFormController.callType == AppConstants.emergencyVideoCall ? AppConstants.emergencyVideoCall : AppConstants.video),
      );
    }

    dbReference.child(customerStatus).set(true);
    registerListeners();
    initAgora();
  }

  void _ensureBirthDataWritten() {
    try {
      sendBirthData(ChatBirthModel(
          name: chatIntakeFormController.name,
          gender: chatIntakeFormController.gender.toString().toUpperCase(),
          dob: chatIntakeFormController.dob,
          tob: CommonMethods().convertTimeInputVedic(chatIntakeFormController.tob.toString()),
          pob: chatIntakeFormController.birthPlace,
          latitude: chatIntakeFormController.latitude,
          longitude: chatIntakeFormController.longitude,
          partnerName: chatIntakeFormController.partnerName.toString(),
          partnerGender: chatIntakeFormController.partnerGender.toString().toUpperCase(),
          partnerDob: chatIntakeFormController.partnerDob,
          partnerTob: chatIntakeFormController.partnerTob.toString().isNotEmpty
              ? CommonMethods().convertTimeInputVedic(chatIntakeFormController.partnerTob.toString())
              : "",
          partnerPob: chatIntakeFormController.partnerBirthPlace,
          partnerLatitude: chatIntakeFormController.partnerLatitude,
          partnerLongitude: chatIntakeFormController.partnerLongitude
      ));
    } catch (e) {
      AppLogger.d("[Customer VideoCallController] _ensureBirthDataWritten failed: $e");
    }
  }

  @override
  Future<void> onResumed() async {
    dbReference.child(customerStatus).set(true);
    // DataSnapshot chatEndSnapshot = await dbReference.child('chatEnd').get();
    // if (chatEndSnapshot.exists && chatEndSnapshot.value == false) {
    //   getRemainingDuration(uniqueId);
    // }
    AppLogger.d('OnResumed VCScreen');
  }

  @override
  void onPaused() {
    startMicNotification();
    // dbReference.child(customerStatus).set(false);
    AppLogger.d('onPaused VCScreen');
  }

 @override
 Future<void> onClose() async {
   _isDisposed = true;
   _cancelListeners();
   _dispose();
   stopOngoingCallNotification();
   super.onClose();
   AppLogger.d('onClose VCScreen');
 }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  //Realtime
  Future<void> initChatSession(ChatSessionModel chatSessionModel) async {
    await dbReference.set(chatSessionModel.toJson());
    await sendBirthData(ChatBirthModel(
        name: chatIntakeFormController.name,
        gender: chatIntakeFormController.gender.toString().toUpperCase(),
        dob: chatIntakeFormController.dob,
        tob: CommonMethods().convertTimeInputVedic(chatIntakeFormController.tob.toString()),
        pob: chatIntakeFormController.birthPlace,
        latitude: chatIntakeFormController.latitude,
        longitude: chatIntakeFormController.longitude,
        partnerName: chatIntakeFormController.partnerName.toString(),
        partnerGender: chatIntakeFormController.partnerGender.toString().toUpperCase(),
        partnerDob: chatIntakeFormController.partnerDob,
        partnerTob: chatIntakeFormController.partnerTob.toString().isNotEmpty ? CommonMethods().convertTimeInputVedic(chatIntakeFormController.partnerTob.toString()) : "",
        partnerPob: chatIntakeFormController.partnerBirthPlace,
        partnerLatitude: chatIntakeFormController.partnerLatitude,
        partnerLongitude: chatIntakeFormController.partnerLongitude
    ));
  }

  Future<void> sendBirthData(ChatBirthModel chatBirthModel) async {
    chatBirthModel.name ??= "anonymous";
    chatBirthModel.gender ??= "";
    chatBirthModel.latitude ??= "";
    chatBirthModel.longitude ??= "";
    chatBirthModel.dob ??= "";
    chatBirthModel.tob ??= "";
    chatBirthModel.pob ??= "";

    //Partner Details
    chatBirthModel.partnerName ??= "anonymous";
    chatBirthModel.partnerGender ??= "";
    chatBirthModel.partnerLatitude ??= "";
    chatBirthModel.partnerLongitude ??= "";
    chatBirthModel.partnerDob ??= "";
    chatBirthModel.partnerTob ??= "";
    chatBirthModel.partnerPob ??= "";

    await dbReference.child(birthChild).set(chatBirthModel.toJson());
  }

  void updateDurationInDb() {
    dbReference.child('duration').set(seconds.value);
  }


  void registerListeners() {
    chatAcceptedListener =
        dbReference.child(chatAcceptedChild).onValue.listen((event) {
          var dataSnapshot = event.snapshot;
          AppLogger.d('[ChatTab] ChatAccepted:onDataChange $dataSnapshot');
          isChatAccepted.value = dataSnapshot.value as bool;
          if (isChatAccepted.value == true) {
            stopSound();
            //CustomSnackBar.showTop("Video Call Session Started.");
            getRemainingDuration(uniqueId);
            isReview = true;
          }
        }, onError: (error) {
          AppLogger.d('[VideoCall] ChatAccepted:onCancelled $error');
        });

    chatEndListener = dbReference.child(chatEnd).onValue.listen((event) async {
      var dataSnapshot = event.snapshot;
      AppLogger.d('[VideoCall] ChatEnd:onDataChange $dataSnapshot');
      isChatEnd.value = dataSnapshot.value as bool;
      if (isChatEnd.value) {
        stopTimer();
        chatAcceptedListener.cancel();
        chatEndListener.cancel();
        stopOngoingCallNotification();
        stopMicNotification();
        if (Get.isRegistered<VideoCallController>()) {
          await Get.delete<VideoCallController>(force: true);
        }
        // _dispose();
        if (isReview) {
          Get.offAll(FeedbackScreen(
              chatIntakeFormController.astrologerUniId.toString(),
              chatIntakeFormController.astrologerName.toString(),
              chatIntakeFormController.astrologerImage.toString(),
              uniqueId));
        } else {
          if (Get.isRegistered<DashboardController>()) {
            Get.delete<DashboardController>();
          }
          Get.offAllNamed('/dashboard');
        }
      }
    }, onError: (error) {
      AppLogger.d('[ChatTab] ChatEnd:onCancelled $error');
    });

    durationListener = dbReference.child('duration').onValue.listen((event) {
      if (event.snapshot.exists && event.snapshot.value != null) {
        int newDuration = int.tryParse(event.snapshot.value.toString()) ?? seconds.value;
        if (newDuration != seconds.value) {
          seconds.value = newDuration; // UI auto update
          AppLogger.d('[VideoCall] Duration updated from Firebase: $newDuration');
        }
      }
    }, onError: (error) {
      AppLogger.d('[VideoCall] Duration listener error: $error');
    });
  }

  Future<void> endCall() async {
    // If still on connecting/ringing screen, cancel the backend request.
    // Otherwise the orphaned call request can break the next chat with same astrologer.
    if (!isChatAccepted.value && uniqueId.isNotEmpty) {
      await _declineCallRequest(uniqueId);
    }

    stopTimer();
    stopSound();
    _cancelListeners();

    final updates = {
      chatDeclinedByChild: "Customer",
      chatEnd: true,
      customerStatus: false,
      chatAcceptedChild: false,
    };
    try {
      await dbReference.update(updates);
    } catch (e) {
      AppLogger.d('[VideoCall] endCall Firebase update error: $e');
    }

    if (Get.isRegistered<VideoCallController>()) {
      await Get.delete<VideoCallController>(force: true);
    }

    Future.delayed(const Duration(milliseconds: 300), () {
      if (Get.isRegistered<DashboardController>()) {
        Get.delete<DashboardController>();
      }
      Get.offAllNamed('/dashboard');
    });
  }

  Future<void> _declineCallRequest(String uniqeid) async {
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.declineQueueRequest, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'uniqeid': uniqeid,
        'status': "Declined(Customer)"
      });
      AppLogger.d('[VideoCall] declineCallRequest response: ${response.data}');
    } catch (e) {
      AppLogger.d('[VideoCall] declineCallRequest error: $e');
    }
  }

  void _cancelListeners() {
    try {
      chatAcceptedListener?.cancel();
    } catch (_) {}
    try {
      chatEndListener?.cancel();
    } catch (_) {}
    try {
      durationListener?.cancel();
    } catch (_) {}
  }

  Future<void> _dispose() async {
    stopTimer();
    stopSound();
    WakelockPlus.disable();
    await engine.leaveChannel();
    await engine.release();
  }

  //API
  Future<void> getRemainingDuration(String uniqueId) async {
    isGetTimeLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      AppLogger.d("[VIDEO CALL] getRemainingDuration request=> $apiKey $uniId $uniqueId");
      final response = await _dio.post(AppConstants.getChatRemainingTime, data: {'api_key': apiKey, 'user_uni_id': uniId, 'uniqeid': uniqueId});
      if (response.statusCode == 200) {
        AppLogger.d("[VIDEO CALL] getRemainingDuration response=> ${response.data.toString()}");
        chatRemainingTimeModel = ChatRemainingTimeModel.fromJson(response.data);
        if (chatRemainingTimeModel.status == AppConstants.success) {
          isGetTimeSuccess(true);
          seconds.value = int.parse(chatRemainingTimeModel.second.toString());
          popupAfterDuration.value = int.parse(chatRemainingTimeModel.popupAfterDuration.toString());
          // updateDurationInDb();
          // startTimer();
          Future.delayed(const Duration(seconds: 1), () {
            startTimer();
          });
        } else {
          isGetTimeSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError getVideoCallDuration');
      }
    } catch (e) {
      isGetTimeSuccess(false);
      AppLogger.d('OnException getVideoCallDuration==> ${e.toString()}');
    } finally {
      isGetTimeLoading(false);
    }
  }

 void startTimer() {
   if (!isTimerRunning.value) {
     isTimerRunning.value = true;
     _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
       if (_isDisposed || isChatEnd.value) {
         stopTimer();
         return;
       }
       if (seconds.value > 0) {
         seconds--;
         await updateCallDuration(seconds.value);
       } else {
         endCall();
       }
       if (popupAfterDuration.value > 0) {
         popupAfterDuration--;
         if(popupAfterDuration.value == 0){
           // Guard against showing the popup after call has ended or controller is disposed.
           if (_isDisposed || isChatEnd.value) return;
           if (_hasShownLowBalanceDialog) return;
           if (Get.isDialogOpen == true) return;

           _hasShownLowBalanceDialog = true;
           Get.dialog(
             CustomDialogWidget(
               imagePath: Images.icCoin,
               title: AppStrings.lowBalance.tr,
               description: AppStrings.lowBalancePopup.tr,
               onYesPressed: () async {
                 Get.back();

                 if (!Get.isRegistered<WalletController>()) {
                   Get.put(WalletController());
                 }
                 if (uniqueId.isNotEmpty) {
                   Get.find<WalletController>().setPaymentData(
                     uniqueId: uniqueId,
                     channelName: channelName,
                     astroImage: chatIntakeFormController.astrologerImage,
                     astroName: chatIntakeFormController.astrologerName,
                     astroUniId: chatIntakeFormController.astrologerUniId,
                   );
                 } else {
                   AppLogger.d("⚠️ uniqueId is NULL or EMPTY in ChatController");
                 }

                 await Get.toNamed('/wallet');

                 Future.delayed(const Duration(seconds: 10), () {
                   if (!_isDisposed && !isChatEnd.value) {
                     getRemainingDuration(uniqueId);
                   }
                 });
               },
             ),
           );
         }
       } else {
         return;
         // endChat();
       }
     });
   }
 }

 void stopTimer() {
   if (_timer != null) {
     _timer!.cancel();
     _timer = null;
   }
   isTimerRunning.value = false;
 }

  String getFormattedTime() {
    int hours = seconds ~/ 3600;
    int minutes = (seconds ~/ 60) % 60;
    num remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void playSound() {
    FlutterRingtonePlayer()
        .play(fromAsset: "assets/raw/dialing.mp3", looping: true);
  }

  void stopSound() {
    FlutterRingtonePlayer().stop();
  }

  //Agora

 Future<void> initAgora() async {
   await [Permission.microphone, Permission.camera].request();

   engine = createAgoraRtcEngine();
   await engine.initialize(RtcEngineContext(
     appId: agoraAppId,
     channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
   ));

   try {
     await engine.leaveChannel();
   } catch (e) {
     AppLogger.d("Leave error (ignore): $e");
   }

   engine.registerEventHandler(RtcEngineEventHandler(
     onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
       AppLogger.d("local user ${connection.localUid} joined");
       localUserJoined.value = true;
     },
     onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
       AppLogger.d("remote user $remoteUid joined");
       this.remoteUid.value = remoteUid;
     },
     onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
       AppLogger.d("remote user $remoteUid left channel");
       this.remoteUid.value = 0;
     },
     onUserMuteAudio: (RtcConnection connection, int uid, bool muted) {
       AppLogger.d("Remote user $uid audio muted: $muted");
       if (remoteUid.value == uid) {
         isRemoteUserMuted.value = muted;
       }
     },
     onUserMuteVideo: (RtcConnection connection, int uid, bool muted) {
       AppLogger.d("Remote user $uid video muted: $muted");
       if (remoteUid.value == uid) {
         isRemoteVideoMuted.value = muted;
       }
     },
     onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
       AppLogger.d('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
     },
     onLeaveChannel: (RtcConnection connection, stats) {
     },
   ));

   await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
   await engine.enableVideo();
   await engine.startPreview();
   await engine.joinChannel(
     token: agoraToken,
     channelId: uniqueId,
     uid: 0,
     options: const ChannelMediaOptions(),
   );
 }

  void onToggleMute() {
    muted.value = !muted.value;
    engine.muteLocalAudioStream(muted.value);
  }

  void onVideoOff() {
    mutedVideo.value = !mutedVideo.value;
    engine.muteLocalVideoStream(mutedVideo.value);
  }

  void onSwitchCamera() {
    engine.switchCamera().then((value) {}).catchError((err) {});
  }

 void startOnGoingCallNotification(int seconds) async {
   if (Platform.isAndroid) {
     try {
       var intent = AndroidIntent(
         action: "com.astrobrahmand.customer.START_CALL_NOTIFICATION",
         package: "com.astrobrahmand.customer",
         arguments: <String, dynamic>{
           "call_duration_seconds": seconds,
         },
         flags: <int>[
           Flag.FLAG_INCLUDE_STOPPED_PACKAGES,
           Flag.FLAG_RECEIVER_FOREGROUND
         ],
       );
       await intent.sendBroadcast();
     } catch (e) {
       AppLogger.d("Error starting call notification: $e");
     }
   }
 }

 void startMicNotification() async {
   if (Platform.isAndroid) {
     try {
       var intent = const AndroidIntent(
         action: "com.astrobrahmand.customer.START_MICROPHONE_NOTIFICATION",
         package: "com.astrobrahmand.customer",
         flags: <int>[
           Flag.FLAG_INCLUDE_STOPPED_PACKAGES,
           Flag.FLAG_RECEIVER_FOREGROUND
         ],
       );
       AppLogger.d("Sending STARTMICNOTIFICATION broadcast...");
       await intent.sendBroadcast();
     } catch (e) {
       AppLogger.d("Error starting mic notification: $e");
     }
   }
 }

 Future<void> updateCallDuration(int seconds) async {
   if (Platform.isAndroid) {
     await Future.delayed(const Duration(milliseconds: 300));
     try {
       var intent = AndroidIntent(
         action: "com.astrobrahmand.customer.UPDATE_CALL_NOTIFICATION",
         package: "com.astrobrahmand.customer",
         arguments: <String, dynamic>{
           "call_duration_seconds": seconds, // Pass call duration in intent
         },
         flags: <int>[
           Flag.FLAG_INCLUDE_STOPPED_PACKAGES,
           Flag.FLAG_RECEIVER_FOREGROUND
         ],
       );
       AppLogger.d("Sending UPDATECALLNOTIFICATION broadcast...");
       await intent.sendBroadcast();
     } catch (e) {
       AppLogger.d("Error triggering call notification: $e");
     }
   }
 }


 void stopOngoingCallNotification() async {
   if (Platform.isAndroid) {
     try {
       var intent = const AndroidIntent(
         action: "com.astrobrahmand.customer.STOP_CALL_NOTIFICATION",
         package: "com.astrobrahmand.customer",
         flags: <int>[
           Flag.FLAG_INCLUDE_STOPPED_PACKAGES,
           Flag.FLAG_RECEIVER_FOREGROUND
         ],
       );
       AppLogger.d("Sending STOP_CALL_NOTIFICATION broadcast...");
       await intent.sendBroadcast();
     } catch (e) {
       AppLogger.d("Error stopping call notification: $e");
     }
   }
 }

 void stopMicNotification() async {
   if (Platform.isAndroid) {
     try {
       var intent = const AndroidIntent(
         action: "com.astrobrahmand.customer.STOP_MIC_NOTIFICATION",
         package: "com.astrobrahmand.customer",
         flags: <int>[
           Flag.FLAG_INCLUDE_STOPPED_PACKAGES,
           Flag.FLAG_RECEIVER_FOREGROUND
         ],
       );
       AppLogger.d("Sending STOP_MIC_NOTIFICATION broadcast...");
       await intent.sendBroadcast();
     } catch (e) {
       AppLogger.d("Error stopping call notification: $e");
     }
   }
 }

}
