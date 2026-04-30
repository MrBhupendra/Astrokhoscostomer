import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import '../../../../../model/success_model.dart';
import '../../../../../utill/app_constants.dart';
import '../../../../../utill/app_features.dart';
import '../../../../../utill/app_strings.dart';
import '../../../../../utill/common_methods.dart';
import '../../../../../utill/images.dart';
import '../../../../../utill/shared_preference.dart';
import '../../../../widget/custom_dialog_widget.dart';
import '../../../../widget/custom_snack_bar.dart';
import '../../../chat/controller/chat_intake_form_controller.dart';
import '../../../chat/controller/image_picker_controller.dart';
import '../../../chat/model/chat_birth_model.dart';
import '../../../chat/model/chat_remaining_time_model.dart';
import '../../../chat/model/chat_session_model.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter/material.dart';
import '../../../dashboard/controller/dashboard_controller.dart';
import '../../../wallet/controller/wallet_controller.dart';

class VoiceCallController extends FullLifeCycleController
    with FullLifeCycleMixin {
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
  var durationListener;
  var chatAcceptedListener;
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
  RxBool speaker = false.obs;


  //getRemainingTime
  final Dio _dio = Dio();
  final isGetTimeLoading = false.obs;
  final isGetTimeSuccess = false.obs;
  ChatRemainingTimeModel chatRemainingTimeModel = ChatRemainingTimeModel();

  // Send Image On call
  final ImagePickerController imagePickerController = Get.put(ImagePickerController());
  final isSendImageLoading = false.obs;
  final isSendImageSuccess = false.obs;
  SuccessModel sendImageModel = SuccessModel();

  //Timer
  RxInt seconds = 60.obs;
  RxInt popupAfterDuration = 60.obs;
  RxBool isTimerRunning = false.obs;
  Timer? _timer;

  // Remaining offer time
  RxInt offerSeconds = 0.obs;
  bool hasShownOfferDialog = false;

  String? customerName;
  String? customerImage;

  //Sensor Handle
  RxBool isNear = false.obs;
  late StreamSubscription<dynamic> _streamSubscription;

  bool isBackPressed = false;

  // @override
  // Future<void> onInit() async {
  //   super.onInit();
  //   listenSensor();
  //   startOnGoingCallNotification(seconds.value);
  //   startMicNotification();
  //   if (Get.context != null) {
  //     try {
  //       WidgetsBinding.instance.addPostFrameCallback((_) async {
  //         try {
  //           WakelockPlus.enable();
  //         } catch (e) {
  //           debugPrint("[VCController] Failed to enable wakelock: $e");
  //         }
  //       });
  //     } catch (e) {
  //       debugPrint("[VCController] Failed to enable wakelock: $e");
  //     }
  //   }
  //   // WakelockPlus.enable();
  //   Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
  //   channelName = arguments['channelName'] ?? '';
  //   uniqueId = arguments['uniqueId'] ?? '';
  //   agoraAppId = arguments['agoraAppId'] ?? '';
  //   agoraToken = arguments['token'] ?? '';
  //
  //   print("VoiceController Data-> channel:$channelName uniqueId:$uniqueId agoraAppId:$agoraAppId token:$agoraToken");
  //
  //   db = FirebaseDatabase.instance;
  //   dbReference = db.ref(chatGroupChild).child(channelName);
  //   // Future.delayed(const Duration(seconds: 1), () async {
  //   //   getRemainingDuration(uniqueId);
  //   // });
  //   DataSnapshot chatEndSnapshot = await dbReference.child('chatEnd').get();
  //   if (chatEndSnapshot.exists && chatEndSnapshot.value == false) {
  //     isChatAccepted(true);
  //     getRemainingDuration(uniqueId);
  //   } else {
  //     playSound();
  //     initChatSession(
  //       ChatSessionModel(
  //           chatId: uniqueId,
  //           chatAccepted: false,
  //           chatEnd: false,
  //           customerStatus: true,
  //           duration: seconds.value,
  //           chatDeclinedBy: "",
  //           type: chatIntakeFormController.callType == AppConstants.emergencyCall ? AppConstants.emergencyCall : AppConstants.call),
  //     );
  //   }
  //
  //   dbReference.child(customerStatus).set(true);
  //   registerListeners();
  //   initAgora();
  // }

  @override
  Future<void> onInit() async {
    super.onInit();
    listenSensor();
    startOnGoingCallNotification(seconds.value);
    startMicNotification();
    if (Get.context != null) {
      try {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          try {
            WakelockPlus.enable();
          } catch (e) {
            debugPrint("[VCController] Failed to enable wakelock: $e");
          }
        });
      } catch (e) {
        debugPrint("[VCController] Failed to enable wakelock: $e");
      }
    }
    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    channelName = arguments['channelName'] ?? '';
    uniqueId = arguments['uniqueId'] ?? '';
    agoraAppId = arguments['agoraAppId'] ?? '';
    agoraToken = arguments['token'] ?? '';
    customerName = await SharedPreferencesHelper.getData(AppConstants.name);
    customerImage =
    await SharedPreferencesHelper.getData(AppConstants.profileImage);

    print(
        "VoiceController Data-> channel:$channelName uniqueId:$uniqueId agoraAppId:$agoraAppId token:$agoraToken");

    db = FirebaseDatabase.instance;
    dbReference = db.ref(chatGroupChild).child(channelName);

    DataSnapshot chatEndSnapshot = await dbReference.child('chatEnd').get();
    if (chatEndSnapshot.exists && chatEndSnapshot.value == false) {
      // isChatAccepted(true);
      getRemainingDuration(uniqueId);
      _ensureBirthDataWritten();
    } else {
      print('No data available or new session.');
      playSound();
      initChatSession(
        ChatSessionModel(
            chatId: uniqueId,
            chatAccepted: false,
            chatEnd: false,
            customerStatus: true,
            duration: seconds.value,
            chatDeclinedBy: "",
            type: chatIntakeFormController.callType == AppConstants.emergencyCall ? AppConstants.emergencyCall : AppConstants.call),
      );
    }

    // dbReference.child(customerStatus).set(true);
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
      if (kDebugMode) {
        debugPrint("[Customer VCController] _ensureBirthDataWritten failed: $e");
      }
    }
  }

  @override
  Future<void> onResumed() async {
    dbReference.child(customerStatus).set(true);
    // DataSnapshot chatEndSnapshot = await dbReference.child('chatEnd').get();
    // if (chatEndSnapshot.exists && chatEndSnapshot.value == false) {
    //   getRemainingDuration(uniqueId);
    // }
    if (kDebugMode) {
      print('OnResumed VCScreen');
    }
  }

  @override
  void onPaused() {
    startMicNotification();
    // dbReference.child(customerStatus).set(false);
    if (kDebugMode) {
      print('onPaused VCScreen');
    }
  }

  @override
  Future<void> onClose() async {
    super.onClose();
    // dbReference.child(customerStatus).set(false);
    stopTimer();
    stopSound();
    if (Get.context != null) {
      try {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          try {
            WakelockPlus.disable();
          } catch (e) {
            debugPrint("[VCController] Failed to disable wakelock: $e");
          }
        });
      } catch (e) {
        debugPrint("[VCController] Failed to disable wakelock: $e");
      }
    }
    await engine.leaveChannel();
    await engine.release();
    _streamSubscription.cancel();
    if (kDebugMode) {
      print('onClose VCScreen');
    }
    if (!isBackPressed) {
      stopOngoingCallNotification();
      if (Get.isRegistered<VoiceCallController>()) {
        await Get.delete<VoiceCallController>(force: true);
      }
    }
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  //Realtime
  void initChatSession(ChatSessionModel chatSessionModel) async {
    dbReference.set(chatSessionModel.toJson()).then((_) {
      sendBirthData(ChatBirthModel(
          name: chatIntakeFormController.name,
          gender: chatIntakeFormController.gender.toString().toUpperCase(),
          dob: chatIntakeFormController.dob,
          tob: CommonMethods()
              .convertTimeInputVedic(chatIntakeFormController.tob.toString()),
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
    });
  }

  void sendBirthData(ChatBirthModel chatBirthModel) async {
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

    dbReference.child(birthChild).set(chatBirthModel.toJson());
  }

  void updateDurationInDb() {
    dbReference.child('duration').set(seconds.value);
  }

  void registerListeners() {
    chatAcceptedListener =
        dbReference.child(chatAcceptedChild).onValue.listen((event) {
      var dataSnapshot = event.snapshot;
      if (kDebugMode) {
        print('[ChatTab] ChatAccepted:onDataChange $dataSnapshot');
      }
      isChatAccepted.value = dataSnapshot.value as bool;
      if (isChatAccepted.value == true) {
        stopSound();
        //CustomSnackBar.showTop("Video Call Session Started.");
        getRemainingDuration(uniqueId);
        isReview = true;
      }
    }, onError: (error) {
      if (kDebugMode) {
        print('[VideoCall] ChatAccepted:onCancelled $error');
      }
    });

    chatEndListener = dbReference.child(chatEnd).onValue.listen((event) async {
      var dataSnapshot = event.snapshot;
      if (kDebugMode) {
        print('[VideoCall] ChatEnd:onDataChange $dataSnapshot');
      }
      isChatEnd.value = dataSnapshot.value as bool;
      if (isChatEnd.value) {
        stopOngoingCallNotification();
        stopMicNotification();
        chatAcceptedListener.cancel();
        chatEndListener.cancel();
        if (Get.isRegistered<VoiceCallController>()) {
          await Get.delete<VoiceCallController>(force: true);
        }
        // _dispose();
        if (isReview) {
          Future.delayed(const Duration(seconds: 1), () {
            if (Get.isRegistered<DashboardController>()) {
              Get.delete<DashboardController>();
            }
            Get.offAllNamed('/dashboard');
          });

          // Get.offAll(FeedbackScreen(
          //     chatIntakeFormController.astrologerUniId.toString(),
          //     chatIntakeFormController.astrologerName.toString(),
          //     chatIntakeFormController.astrologerImage.toString(),
          //     uniqueId));
        } else {
          Future.delayed(const Duration(seconds: 1), () {
            if (Get.isRegistered<DashboardController>()) {
              Get.delete<DashboardController>();
            }
            Get.offAllNamed('/dashboard');
          });

        }
      }
    }, onError: (error) {
      if (kDebugMode) {
        print('[ChatTab] ChatEnd:onCancelled $error');
      }
    });

    durationListener = dbReference.child('duration').onValue.listen((event) {
      if (event.snapshot.exists && event.snapshot.value != null) {
        int newDuration = int.tryParse(event.snapshot.value.toString()) ?? seconds.value;
        if (newDuration != seconds.value) {
          seconds.value = newDuration; // UI auto update
          if (kDebugMode) {
            print('[VideoCall] Duration updated from Firebase: $newDuration');
          }
        }
      }
    }, onError: (error) {
      if (kDebugMode) {
        print('[VideoCall] Duration listener error: $error');
      }
    });
  }

  Future<void> endCall() async {
    // dbReference.child(chatDeclinedByChild).set("Customer");
    // dbReference.child(chatEnd).set(true);

    /// Commented above code and set below one, to avoid the sequence issue of code - Zaid
    final updates = {
      chatDeclinedByChild: "Customer",
      chatEnd: true,
    };
    dbReference.update(updates);

    dbReference.child(customerStatus).set(false);
    dbReference.child(chatAcceptedChild).set(false);
    if (Get.isRegistered<VoiceCallController>()) {
      await Get.delete<VoiceCallController>(force: true);
    }
  }

  //API
  Future<void> getRemainingDuration(String uniqueId) async {
    isGetTimeLoading(true);
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      debugPrint("[CALL] getRemainingDuration request=> $apiKey $uniId $uniqueId");
      final response = await _dio.post(AppConstants.getChatRemainingTime,
          data: {'api_key': apiKey, 'user_uni_id': uniId, 'uniqeid': uniqueId});
      if (response.statusCode == 200) {
        debugPrint("[CALL] getRemainingDuration response=> ${response.data.toString()}");
        chatRemainingTimeModel = ChatRemainingTimeModel.fromJson(response.data);
        if (chatRemainingTimeModel.status == AppConstants.success) {
          isGetTimeSuccess(true);
          seconds.value = int.parse(chatRemainingTimeModel.second.toString());
          popupAfterDuration.value = int.parse(chatRemainingTimeModel.popupAfterDuration.toString());
          if(AppFeatures.freeChatOfferDialog) {
            offerSeconds.value = int.parse(chatRemainingTimeModel.popupAfterDuration.toString());
          }
          // updateDurationInDb();
          // startTimer();
          Future.delayed(const Duration(seconds: 1), () {
            startTimer();
          });
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
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (seconds.value > 0) {
          seconds--;
          await updateCallDuration(seconds.value);
        } else {
          endCall();
        }
        if (popupAfterDuration.value > 0) {
          popupAfterDuration--;
          if(popupAfterDuration.value == 0){
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
                      agoraAppId: agoraAppId,
                      agoraToken: agoraToken,
                      astroImage: chatIntakeFormController.astrologerImage,
                      astroName: chatIntakeFormController.astrologerName,
                      astroUniId: chatIntakeFormController.astrologerUniId,
                    );
                    print("callDuration===>2");
                    print(uniqueId);
                    print(channelName);
                    print(agoraAppId);
                    print(agoraToken);
                  } else {
                    print("⚠️ uniqueId is NULL or EMPTY in ChatController");
                  }

                  await Get.toNamed('/wallet');

                  Future.delayed(const Duration(seconds: 10), () {
                    getRemainingDuration(uniqueId);
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
    // Get permission
    await [Permission.microphone].request();

    engine = createAgoraRtcEngine();

    await engine.initialize(RtcEngineContext(
      appId: agoraAppId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));

    try {
      await engine.leaveChannel();
    } catch (e) {
      print("Leave error (ignore): $e");
    }

    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          localUserJoined.value = true;
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid join channel");
          this.remoteUid.value = remoteUid;
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          this.remoteUid.value = 0;
        },
      ),
    );

    await engine.joinChannel(
      token: agoraToken,
      channelId: uniqueId,
      uid: 0,
      options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster),
    );
  }

  void onToggleMute() {
    muted.value = !muted.value;
    engine.muteLocalAudioStream(muted.value);
  }

  void onToggleSpeaker() {
    speaker.value = !speaker.value;
    engine.setEnableSpeakerphone(speaker.value);
  }

  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      debugPrint("listenSensor error $details");
    };

    await ProximitySensor.setProximityScreenOff(true).onError((error, stackTrace) {
      debugPrint("could not enable screen off functionality");
      return null;
    });

    _streamSubscription = ProximitySensor.events.listen((int event) {
      // print("event = ${event}");
      isNear.value = (event > 0) ? true : false;
    });
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
        if (kDebugMode) {
          print("Error starting call notification: $e");
        }
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
        if (kDebugMode) {
          print("Sending STARTMICNOTIFICATION broadcast...");
        }
        await intent.sendBroadcast();
      } catch (e) {
        if (kDebugMode) {
          print("Error starting mic notification: $e");
        }
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
        if (kDebugMode) {
          print("Sending UPDATECALLNOTIFICATION broadcast...");
        }
        await intent.sendBroadcast();
      } catch (e) {
        debugPrint("Error triggering call notification: $e");
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
        if (kDebugMode) {
          print("Sending STOP_CALL_NOTIFICATION broadcast...");
        }
        await intent.sendBroadcast();
      } catch (e) {
        if (kDebugMode) {
          print("Error stopping call notification: $e");
        }
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
        if (kDebugMode) {
          print("Sending STOP_MIC_NOTIFICATION broadcast...");
        }
        await intent.sendBroadcast();
      } catch (e) {
        if (kDebugMode) {
          print("Error stopping call notification: $e");
        }
      }
    }
  }

  Future<void> sendImage(String uniqeId, File imageFile) async {
    isSendImageLoading(true);
    String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
    String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'api_key': apiKey,
        "user_uni_id": uniId,
        "uniqeid": uniqeId,
        "file_url": await dio.MultipartFile.fromFile(imageFile.path, filename: 'image.png'),
        // "call_type": callType,
        // "file_type": fileType,
      });
      print("uniqeId->$uniqeId");

      final response = await _dio.post(AppConstants.sendFileOnCall, data: formData);
      if (response.statusCode == 200) {
        sendImageModel = SuccessModel.fromJson(response.data);
        if (sendImageModel.status == AppConstants.success) {
          isSendImageSuccess(true);
          CustomSnackBar.showTop("Image has been sent successfully!");
        } else {
          isSendImageSuccess(false);
          CustomSnackBar.showBottom(sendImageModel.msg.toString());
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('OnException==> $e');
      }
    }finally{
      imagePickerController.isImagePicked(false);
      imagePickerController.imageFile.value = null;
      isSendImageLoading(false);
    }
  }

}
