import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../utill/app_constants.dart';
import '../../../../../utill/shared_preference.dart';
import '../../../chat/controller/chat_intake_form_controller.dart';
import '../../../chat/model/chat_remaining_time_model.dart';
import '../../../chat/model/chat_session_model.dart';
import '../../../feedback/feedback_screen.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class ServiceVideoCallController extends FullLifeCycleController with FullLifeCycleMixin {
 final ChatIntakeFormController chatIntakeFormController = Get.find();

  //Realtime
  late FirebaseDatabase db;
  late DatabaseReference dbReference;

  final String chatGroupChild = "SERVICE-VIDEO";
  final String customerStatus = "customer_status";
  final String chatEnd = "chatEnd";
  final String chatAcceptedChild = "chatAccepted";
 final String astrologerStatus = "astrologer_status";
  final String chatDeclinedByChild = "chatDeclinedBy";
 final String isVideoCallChild = "videoCall";

  var isChatEnd = false.obs;
  var isAstrologerOnline = false.obs;
  bool isReview = false;

  //Listeners
  var astrologerStatusListener;
  var chatEndListener;

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
  RxBool isTimerRunning = false.obs;
  Timer? _timer;

  @override
  Future<void> onInit() async {
    super.onInit();
    WakelockPlus.enable();
    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    channelName = arguments['channelName'] ?? '';
    uniqueId = arguments['uniqueId'] ?? '';
    agoraAppId = arguments['agoraAppId'] ?? '';
    agoraToken = arguments['token'] ?? '';

    // print("ServiceVCController Data-> channel:$channelName uniqueId:$uniqueId agoraAppId:$agoraAppId token:$agoraToken");

    db = FirebaseDatabase.instance;
    dbReference = db.ref(chatGroupChild).child(channelName);

    DataSnapshot chatEndSnapshot = await dbReference.child('chatEnd').get();
    if (chatEndSnapshot.exists && chatEndSnapshot.value == false) {
      getRemainingDuration(uniqueId);
    } else {
      print('No data available or new session.');
      playSound();
      initChatSession(
        ChatSessionModel(
            chatId: uniqueId,
            chatAccepted: false,
            chatEnd: false,
            duration: seconds.value,
            chatDeclinedBy: "",
            type: AppConstants.video),
      );
    }

    dbReference.child(customerStatus).set(true);
    registerListeners();
    initAgora();
  }

  @override
  void onResumed() {
    dbReference.child(customerStatus).set(true);
    if (kDebugMode) {
      print('OnResumed VCScreen');
    }
  }

  @override
  void onPaused() {
    dbReference.child(customerStatus).set(false);
    if (kDebugMode) {
      print('onPaused VCScreen');
    }
  }

  @override
  void onClose() {
    dbReference.child(customerStatus).set(false);
    _dispose();
    super.onClose();
    if (kDebugMode) {
      print('onClose VCScreen');
    }
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  //Realtime
  void initChatSession(ChatSessionModel chatSessionModel) {
    dbReference.set(chatSessionModel.toJson()).then((_) {
      dbReference.update({
        customerStatus: true,
        isVideoCallChild: true,
      });
    });
  }

  void updateDurationInDb() {
    dbReference.child('duration').set(seconds.value);
  }

  void registerListeners() {
    astrologerStatusListener = dbReference.child(astrologerStatus).onValue.listen((event) {
          var dataSnapshot = event.snapshot;
          if (kDebugMode) {
            print('[ChatTab] AstrologerStatus:onDataChange $dataSnapshot');
          }
          isAstrologerOnline.value = dataSnapshot.value as bool;
          if (isAstrologerOnline.value == true) {
            isAstrologerOnline(true);
            stopSound();
            getRemainingDuration(uniqueId);
            isReview = true;
          }else{
            isAstrologerOnline(false);
          }
        }, onError: (error) {
          if (kDebugMode) {
            print('[VideoCall] ChatAccepted:onCancelled $error');
          }
        });

    chatEndListener = dbReference.child(chatEnd).onValue.listen((event) {
      var dataSnapshot = event.snapshot;
      if (kDebugMode) {
        print('[VideoCall] ChatEnd:onDataChange $dataSnapshot');
      }
      isChatEnd.value = dataSnapshot.value as bool;
      if (isChatEnd.value) {
        chatEndListener.cancel();
        astrologerStatusListener.cancel();
        // _dispose();
        if (isReview) {
          Get.offAll(FeedbackScreen(
              chatIntakeFormController.astrologerUniId.toString(),
              chatIntakeFormController.astrologerName.toString(),
              chatIntakeFormController.astrologerImage.toString(),
              uniqueId));
        } else {
          Get.offAllNamed('/dashboard');
        }
      }
    }, onError: (error) {
      if (kDebugMode) {
        print('[ChatTab] ChatEnd:onCancelled $error');
      }
    });
  }

  void endCall() {
    dbReference.child(customerStatus).set(false);
    dbReference.child(chatDeclinedByChild).set("Customer");
    dbReference.child(chatEnd).set(true);
    dbReference.child(chatAcceptedChild).set(false);
    dbReference.child(isVideoCallChild).set(false);
  }

  Future<void> _dispose() async {
    stopTimer();
    stopSound();
    WakelockPlus.disable();
    await engine.leaveChannel();
    await engine.release();
  }

  //API
  Future<void> getRemainingDuration(String orderId) async {
    isGetTimeLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getServiceRemainingTime, data: {'api_key': apiKey, 'user_uni_id': uniId, 'order_id': orderId});
      if (response.statusCode == 200) {
        print('getServiceDuration Api Response ${response.data.toString()}');
        chatRemainingTimeModel = ChatRemainingTimeModel.fromJson(response.data);
        if (chatRemainingTimeModel.status == AppConstants.success) {
          isGetTimeSuccess(true);
          seconds.value = int.parse(chatRemainingTimeModel.second.toString());
          updateDurationInDb();
          startTimer();
        } else {
          isGetTimeSuccess(false);
        }
      } else {
        if (kDebugMode) {
          print('OnApiError getVideoCallDuration');
        }
      }
    } catch (e) {
      isGetTimeSuccess(false);
      if (kDebugMode) {
        print('OnException getVideoCallDuration==> ${e.toString()}');
      }
    } finally {
      isGetTimeLoading(false);
    }
  }

  void startTimer() {
    if (!isTimerRunning.value) {
      isTimerRunning.toggle();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (seconds.value > 0) {
          seconds--;
        } else {
          endCall();
        }
      });
    }
  }

  void stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      isTimerRunning.toggle();
    }
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

   engine.registerEventHandler(RtcEngineEventHandler(
     onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
       debugPrint("local user ${connection.localUid} joined");
       localUserJoined.value = true;
     },
     onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
       debugPrint("remote user $remoteUid joined");
       this.remoteUid.value = remoteUid;
     },
     onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
       debugPrint("remote user $remoteUid left channel");
       this.remoteUid.value = 0;
     },
     onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
       debugPrint(
           '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
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

}
