import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:astro_brahmand/model/success_model.dart';
import 'package:astro_brahmand/view/screen/agora/live_stream/model/live_gift_list_model.dart';
import 'package:astro_brahmand/view/screen/dashboard/controller/live_astrologer_controller.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_progress_dialog.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../model/group_puja_remaining_time_model.dart';
import '../../../../../utill/app_constants.dart';
import '../../../../../utill/app_strings.dart';
import '../../../../../utill/color_resources.dart';
import '../../../../../utill/dimensions.dart';
import '../../../../../utill/shared_preference.dart';
import '../../../../widget/custom_empty_screen.dart';
import '../../../../widget/custom_text_medium.dart';
import '../../../../widget/custom_text_regular.dart';
import '../../../chat/model/chat_message_model.dart';
import '../../../chat/model/chat_remaining_time_model.dart';
import '../../../splash/controller/config_controller.dart';
import '../model/live_gift_model.dart';
import '../model/live_request_model.dart';
import 'group_pooja_live_stream_init_controller.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class GroupPoojaLiveStreamController extends FullLifeCycleController
    with FullLifeCycleMixin {
  final GroupPoojaLiveStreamInitController liveDataController = Get.put(GroupPoojaLiveStreamInitController());
  final LiveAstrologerController liveAstrologerController = Get.put(LiveAstrologerController());

  //Realtime
  late FirebaseDatabase db;
  late DatabaseReference dbReference;
  late DatabaseReference messageReference;

  final String liveChild = "LIVE";
  final String messageChild = "messages";
  final String liveEndChild = "liveEnd";
  final String userCountChild = "userCount";
  final String giftsChild = "gifts";
  final String giftsListChild = "giftList";
  final String requestsChild = "requests";
  final String callChild = "publicVoiceCall";
  final String videoCallChild = "publicVideoCall";

  final String publicVoiceCallStatus = "publicVoiceCall";
  final String publicVideoCallStatus = "publicVideoCall";
  final String astrologerStatus = "astrologer_status";

  final String chatAcceptedChild = "chatAccepted";
  final String chatDeclinedByChild = "chatDeclinedBy";

  //Listeners
  var onMessageListener;
  var onUserCountListener;
  var onGiftListener;
  var onRequestAddListener;
  var onRequestRemovedListener;
  var liveEndListener;
  var onCallStatusListener;
  var onVideoCallStatusListener;

  RxInt liveUserCount = 1.obs;
  var isLiveEnd = false.obs;
  var callStatus = false.obs;
  var videoCallStatus = false.obs;

  //MyRequest Listeners
  var onMyRequestAcceptListener;
  var onMyCallEndedListener;

  RxBool isMyRequestPending = false.obs;
  RxBool isMyRequestAccepted = false.obs;
  RxBool isMyCallEnded = false.obs;

  //API
  final Dio _dio = Dio();
  final isGetTimeLoading = false.obs;
  final isGetTimeSuccess = false.obs;
  ChatRemainingTimeModel chatRemainingTimeModel = ChatRemainingTimeModel();
  RxList<ChatMessageModel> chatHistoryList = <ChatMessageModel>[].obs;
  RxList<LiveRequestModel> requestList = <LiveRequestModel>[].obs;

  //Agora
  late String agoraAppId;
  late String agoraToken;
  late String uniqueId;

  late RtcEngine engine;
  RxInt remoteUid = 0.obs;
  RxInt remoteAstrologerUid = 0.obs;
  RxInt remoteCustomerUid = 0.obs;
  RxBool localUserJoined = false.obs;
  RxBool muted = false.obs;
  RxBool mutedVideo = false.obs;
  RxBool beautyVideo = true.obs;
  BeautyOptions options = const BeautyOptions(
    lighteningContrastLevel: LighteningContrastLevel.lighteningContrastNormal,
    lighteningLevel: 0.7,
    smoothnessLevel: 0.5,
    rednessLevel: 0.1,
  );

  TextEditingController messageController = TextEditingController();

  //Data
  int astrologerUID = 0;
  String? astrologerUniId;
  String? customerUniId;
  int customerUid = 0;
  String? customerName;
  String? customerImage;
  String? orderId;
  String? groupPoojaAssignId;

  //Gift List
  final isGiftLoading = false.obs;
  final isGiftSuccess = false.obs;
  LiveGiftListModel liveGiftListModel = LiveGiftListModel();
  RxInt selectedGiftIndex = 0.obs;
  RxString walletBalance = '***'.obs;

  SuccessModel giftSendSuccessModel = SuccessModel();
  SuccessModel requestSendSuccessModel = SuccessModel();

  var currentGift = Rxn<LiveGiftModel>();
  var hasGift = false.obs;
  var giftsQueue = <LiveGiftModel>[].obs;
  Timer? giftDisplayTimer;

  Rxn<LiveRequestModel> currentCallSession = Rxn<LiveRequestModel>();

  var isFollowLoading = false.obs;
  RxBool isFollow = false.obs;
  SuccessModel astrologerFollowModel = SuccessModel();

  final ConfigController configController = Get.find();
  final RxBool isRemoteVideoMuted = false.obs;
  final RxBool isRemoteUserMuted = false.obs;

  //Timer
  RxInt seconds = 60.obs;
  RxBool isTimerRunning = false.obs;
  Timer? _timer;

  GroupPujaRemainingTimeModel groupPujaRemainingTimeModel = GroupPujaRemainingTimeModel();

  @override
  Future<void> onInit() async {
    super.onInit();
    WakelockPlus.enable();
    currentCallSession.value = null;
    //Get Arg from request
    await getLocalData();
    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    uniqueId = arguments['uniqueId'] ?? '';
    agoraAppId = arguments['agoraAppId'] ?? '';
    agoraToken = arguments['token'] ?? '';
    astrologerUniId = arguments['astrologerId'] ?? '';
    astrologerUID = arguments['astrologerUID'] ?? 0;
    orderId = arguments['orderId'] ?? 0;
    groupPoojaAssignId = arguments['groupPoojaAssignId'] ?? 0;

    db = FirebaseDatabase.instance;
    dbReference = db.ref(liveChild).child(astrologerUniId!);
    messageReference = dbReference.child(messageChild);

    DataSnapshot publicVoiceCallStatusSnapshot =
        await dbReference.child(publicVoiceCallStatus).get();
    if (publicVoiceCallStatusSnapshot.exists &&
        publicVoiceCallStatusSnapshot.value == true) {
      callStatus.value = true;
    } else {
      callStatus.value = false;
    }

    DataSnapshot publicVideoCallStatusSnapshot =
        await dbReference.child(publicVideoCallStatus).get();
    if (publicVideoCallStatusSnapshot.exists &&
        publicVideoCallStatusSnapshot.value == true) {
      videoCallStatus.value = true;
    } else {
      videoCallStatus.value = false;
    }

    //LiveUserCount
    DataSnapshot userCountSnapshot =
        await dbReference.child(userCountChild).get();
    if (userCountSnapshot.exists && userCountSnapshot.value != null) {
      liveUserCount.value = int.parse(userCountSnapshot.value.toString());
    } else {
      liveUserCount.value = 1;
    }

    registerListeners();
    initAgora();
  }

  @override
  void onResumed() {
    AppLogger.d('OnResumed');
  }

  @override
  void onPaused() {
    AppLogger.d('onPaused');
  }

  @override
  void onClose() {
    super.onClose();
    _dispose();

    AppLogger.d('onClose');
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  Future<void> _dispose() async {
    WakelockPlus.disable();
    await engine.leaveChannel();
    await engine.release();
  }

  Future<void> getLocalData() async {
    customerUniId =
        await SharedPreferencesHelper.getData(AppConstants.userUniId);
    customerUid =
        await SharedPreferencesHelper.getIntData(AppConstants.userUid);
    customerName = await SharedPreferencesHelper.getData(AppConstants.name);
    customerImage =
        await SharedPreferencesHelper.getData(AppConstants.profileImage);
  }

  String getCurrentDateTime() {
    DateTime now = DateTime.now();
    String formattedDate =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    String formattedTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    return '$formattedDate $formattedTime';
  }

  //Realtime
  void registerListeners() {
    onMessageListener = messageReference.onChildAdded.listen((event) {
      final json = event.snapshot.value as Map<dynamic, dynamic>;
      final message = ChatMessageModel.fromJson(json);
      addMessage(message);
    }, onError: (error) {
      AppLogger.d('[LIVE] onMessageListener $error');
    });

    onUserCountListener =
        dbReference.child(userCountChild).onValue.listen((event) {
      var dataSnapshot = event.snapshot;
      AppLogger.d('[LIVE] onUserCountListener:onDataChange $dataSnapshot');
      liveUserCount.value = int.parse(dataSnapshot.value.toString());
    }, onError: (error) {
      AppLogger.d('[LIVE] onUserCountListener:onError $error');
    });

    onGiftListener = dbReference.child(giftsChild).onChildAdded.listen((event) {
      var gift = LiveGiftModel.fromJson(event.snapshot.value);
      giftsQueue.add(gift);
      if (!hasGift.value) {
        _displayNextGift();
      }
    }, onError: (error) {
      AppLogger.d('[LIVE] onGiftListListener $error');
    });

    liveEndListener = dbReference.child(liveEndChild).onValue.listen((event) {
      var dataSnapshot = event.snapshot;
      AppLogger.d('[LIVE] ChatEnd:onDataChange $dataSnapshot');
      isLiveEnd.value = dataSnapshot.value as bool;
      if (isLiveEnd.value) {
        onMessageListener.cancel();
        onUserCountListener.cancel();
        onGiftListener.cancel();
        liveEndListener.cancel();
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAllNamed('/dashboard');
        });
      }
    }, onError: (error) {
      AppLogger.d('[LIVE] ChatEnd:onError $error');
    });
  }

  void sendFirstMsg() {
    String message = "joined";
    var chatMessage = ChatMessageModel(
        senderUniId: customerUniId,
        date: getCurrentDateTime(),
        fileUrl: "",
        messageType: AppConstants.text,
        name: customerName,
        profileImageUrl: customerImage,
        selectedText: "",
        selectedType: "",
        text: message);
    sendMessage(chatMessage);
  }

  void sendMessage(ChatMessageModel message) {
    messageReference.push().set(message.toJson());
  }

  void sendGift(LiveGiftModel gift) {
    dbReference.child(giftsChild).push().set(gift.toJson());
    dbReference.child(giftsListChild).push().set(gift.toJson());
  }

  void _displayNextGift() {
    if (giftsQueue.isNotEmpty) {
      currentGift.value = giftsQueue.removeAt(0);
      hasGift.value = true;

      giftDisplayTimer = Timer(const Duration(seconds: 10), () {
        hasGift.value = false;
        currentGift.value = null;

        _displayNextGift();
      });
    } else {
      hasGift.value = false;
    }
  }

  void updateLiveCount(bool isJoin) {
    if (isJoin) {
      liveUserCount.value++;
    } else {
      liveUserCount.value--;
    }

    dbReference.update({userCountChild: liveUserCount.value});
  }

  // void showEndConfirmDialog() {
  //   Get.defaultDialog(
  //     title: AppStrings.alert.tr,
  //     content: const Text("Are you sure you want to END this live session?"),
  //     confirm: TextButton(
  //       onPressed: () {
  //         Get.offAllNamed('/dashboard');
  //         // Get.back();
  //       },
  //       child: Container(
  //           padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
  //           decoration: BoxDecoration(
  //             color: Colors.red,
  //             borderRadius: BorderRadius.circular(5),
  //           ),
  //           child: CustomTextRegular(
  //             AppStrings.yes.tr,
  //             color: ColorResources.toolbarText,
  //           )),
  //     ),
  //     cancel: TextButton(
  //       onPressed: () {
  //         Get.back();
  //       },
  //       child: Container(
  //           padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
  //           decoration: BoxDecoration(
  //             color: ColorResources.colorPrimary,
  //             borderRadius: BorderRadius.circular(5),
  //           ),
  //           child: CustomTextRegular(
  //             AppStrings.no.tr,
  //             color: ColorResources.toolbarText,
  //           )),
  //     ),
  //   );
  // }

  void showLeaveDialog() {
    liveAstrologerController.isAstrologerSuccess(false);
    liveAstrologerController.getAllAstrologer("live");
    Get.bottomSheet(
      enableDrag: true,
      SafeArea(
        child: Container(
          height: Get.height * 0.2,
          decoration: const BoxDecoration(
            color: ColorResources.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.borderRadiusMedium)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeOverSmall),
                child: CustomTextMedium(
                  "Do Follow our Astrologer before leaving!",
                  fontSize: Dimensions.fontSizeLarge,
                ),
              ),
              const Divider(thickness: 1.2),
              SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 8),
                        child: ElevatedButton(
                          onPressed: () {
                            // Action for "Leave" button
                            Get.offAllNamed('/dashboard');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text("Leave"),
                        ),
                      ),
                    ),
                    // if(liveAstrologerController.astrologerFollowModel.status == 0)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 8),
                        child: ElevatedButton(
                          onPressed: () {
                            AppLogger.d("astrologerUniId->$astrologerUniId");
                            // Action for "Follow & Leave" button
                            liveAstrologerController.astrologerFollow("1", astrologerUniId.toString());
                            CustomSnackBar.showTop(AppStrings.astroFollowMsg);
                            Get.offAllNamed('/dashboard');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorResources.colorPrimary,
                            foregroundColor: ColorResources.toolbarText,
                          ),
                          child: const Text("Follow & Leave"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void addMessage(ChatMessageModel messageModel) {
    chatHistoryList.insert(0, messageModel);
  }


  Future<void> getGifts() async {
    isGiftLoading(true);
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getLiveGifts,
          data: {'api_key': apiKey, "user_uni_id": uniId});
      if (response.statusCode == 200) {
        liveGiftListModel = LiveGiftListModel.fromJson(response.data);
        if (liveGiftListModel.status == AppConstants.success) {
          walletBalance.value = liveGiftListModel.walletBalance.toString();
          isGiftSuccess(true);
        } else {
          isGiftSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isGiftSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isGiftLoading(false);
    }
  }

  Future<void> sendGiftApi(String astrologerId, LiveGiftData giftData) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.sendLiveGift, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "astrologer_uni_id": astrologerId,
        "gift_id": giftData.id.toString(),
        "livechannel": uniqueId.toString()
      });

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        giftSendSuccessModel = SuccessModel.fromJson(response.data);
        if (giftSendSuccessModel.status == AppConstants.success) {
          sendGift(LiveGiftModel(
              senderUniId: customerUniId,
              name: customerName,
              profileImageUrl: customerImage,
              giftName: giftData.giftName.toString(),
              giftPrice: giftData.giftPrice.toString(),
              giftImageUrl: giftData.giftImage.toString(),
              date: getCurrentDateTime()));
        } else {
          CustomSnackBar.showTop(giftSendSuccessModel.msg.toString());
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
        AppLogger.d("[LIVE] local user ${connection.localUid} joined");
        localUserJoined.value = true;
        updateLiveCount(true);
        sendFirstMsg();
        getRemainingDuration();
      },
      onUserJoined:
          (RtcConnection connection, int remoteUid, int elapsed) async {
        AppLogger.d("[LIVE] remote user $remoteUid joined");
        this.remoteUid.value = remoteUid;
        if (remoteUid == astrologerUID) {
          remoteAstrologerUid.value = remoteUid;
          AppLogger.d("remoteAstrologerUid.value${remoteAstrologerUid.value}");
        }
        else {
          remoteCustomerUid.value = remoteUid;
        }
      },
      onUserOffline: (RtcConnection connection, int remoteUid,
          UserOfflineReasonType reason) {
        AppLogger.d("[LIVE] remote user $remoteUid left channel");
        this.remoteUid.value = 0;
        if (remoteUid == astrologerUID) {
          remoteAstrologerUid.value = 0;
        } else {
          remoteCustomerUid.value = 0;
          currentCallSession.value = null;
          // stopTimer();
        }
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
        AppLogger.d('[LIVE] [onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
      },
      onLeaveChannel: (RtcConnection connection, stats) {
        AppLogger.d("[LIVE] onLeaveChannel");
        //updateLiveCount(false);
      },
    ));

    await engine.setClientRole(role: ClientRoleType.clientRoleAudience);
    await engine.enableVideo();
    await engine.joinChannel(
      token: agoraToken,
      channelId: uniqueId,
      uid: customerUid,
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

  void onBeautyToggle() {
    beautyVideo.value = !beautyVideo.value;
    if (beautyVideo.value) {
      engine.setBeautyEffectOptions(
          enabled: beautyVideo.value, options: options);
    } else {
      engine.setBeautyEffectOptions(
          enabled: beautyVideo.value, options: const BeautyOptions());
    }
  }

  void onSwitchCamera() {
    engine.switchCamera().then((value) {}).catchError((err) {});
  }

  void showTypingBottomSheet() {
    Get.bottomSheet(
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    controller: messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none, // Removes the border line
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Type something...',
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (messageController.text.isNotEmpty) {
                        String? uniId = await SharedPreferencesHelper.getData(
                            AppConstants.userUniId);
                        ChatMessageModel chatMessage = ChatMessageModel(
                          senderUniId: uniId,
                          date: getCurrentDateTime(),
                          fileUrl: "",
                          messageType: AppConstants.text,
                          name: customerName,
                          profileImageUrl: customerImage,
                          selectedText: "",
                          selectedType: "",
                          text: messageController.text.toString(),
                        );
                        sendMessage(chatMessage);
                        messageController.clear();
                        Get.back();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: ColorResources.colorPrimary),
                    child: const Icon(
                      Icons.send,
                      color: ColorResources.black,
                    ))
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        isScrollControlled: true);
  }

  void showGiftsBottomSheet() {
    selectedGiftIndex.value = -1;
    getGifts();
    Get.bottomSheet(
      SafeArea(
        child: Container(
          width: Get.width,
          constraints: const BoxConstraints(maxHeight: 400),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextMedium(
                        "Send a gift",
                        fontSize: Dimensions.fontSizeLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Obx(
                      () => CustomTextMedium(
                        "${configController.currencySymbol} ${walletBalance.value.toString()}",
                        fontSize: Dimensions.fontSizeExtraLarge,
                      ),
                    ),
                  ],
                ),
                const Gap(Dimensions.gapDefault),
                Obx(
                  () {
                    if (isGiftSuccess.isTrue) {
                      return GridView.builder(
                        itemCount: liveGiftListModel.data?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 2.0),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              selectedGiftIndex.value = index;
                            },
                            child: Obx(
                              () => Container(
                                decoration: BoxDecoration(
                                  color: selectedGiftIndex.value == index
                                      ? Colors.grey[300]
                                      : null,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomNetworkImage(
                                      imageUrl: liveGiftListModel
                                          .data![index].giftImage
                                          .toString(),
                                      height: 25,
                                      width: 25,
                                    ),
                                    const Gap(Dimensions.gapExtraSmall),
                                    CustomTextRegular(
                                        liveGiftListModel.data![index].giftName
                                            .toString(),
                                        fontSize: Dimensions.fontSizeSmall),
                                    CustomTextMedium(
                                        "${configController.currencySymbol} ${liveGiftListModel.data![index].giftPrice.toString()}",
                                        fontSize: Dimensions.fontSizeSmall),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (isGiftLoading.isTrue) {
                      return const CircularProgressIndicator();
                    } else {
                      return const EmptyScreen();
                    }
                  },
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed("/wallet");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                              color: ColorResources.colorPrimaryLight,
                              borderRadius: BorderRadius.circular(20)),
                          child: CustomTextMedium(
                            "Recharge",
                            color: ColorResources.black,
                            fontSize: Dimensions.fontSizeSmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const Gap(Dimensions.gapExtraSmall),
                    Obx(() {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (selectedGiftIndex.value != -1) {
                              Get.back();
                              sendGiftApi(
                                  astrologerUniId.toString(),
                                  liveGiftListModel
                                      .data![selectedGiftIndex.value]);
                            } else {
                              CustomSnackBar.showTop("Please select a gift.");
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                                color: selectedGiftIndex.value != -1
                                    ? ColorResources.colorPrimaryMedium
                                    : ColorResources.black6,
                                borderRadius: BorderRadius.circular(20)),
                            child: CustomTextMedium(
                              "Send",
                              color: selectedGiftIndex.value != -1
                                  ? ColorResources.toolbarText
                                  : ColorResources.black5,
                              fontSize: Dimensions.fontSizeSmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }


  Future<void> notifyMe(String status, String astrologerUniId) async {
    isFollowLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.astrologerFollow, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'astrologer_uni_id': astrologerUniId,
        'status' : status
      });
      if (response.statusCode == 200) {
        astrologerFollowModel = SuccessModel.fromJson(response.data);
        if(astrologerFollowModel.status == AppConstants.success){
          if(status == "1"){
            isFollow(true);
          }else{
            isFollow(false);
          }
        }

      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isFollowLoading(false);
    }
  }

  Future<void> getRemainingDuration() async {
    isGetTimeLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getRemainingGroupPujaTime, data: {'api_key': apiKey, 'user_uni_id': uniId, 'order_id': orderId, 'group_puja_assign_id': groupPoojaAssignId, 'started_by':'Customer'});
      if (response.statusCode == 200) {
        AppLogger.d('getGroupPoojaLiveDuration Api Response ${response.data.toString()}');
        groupPujaRemainingTimeModel = GroupPujaRemainingTimeModel.fromJson(response.data);
        if (groupPujaRemainingTimeModel.status == AppConstants.success) {
          isGetTimeSuccess(true);
          seconds.value = int.parse(groupPujaRemainingTimeModel.second.toString());
          updateDurationInDb();
          startTimer();
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
      isTimerRunning.toggle();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (seconds.value > 0) {
          seconds--;
        } else {
          // Get.offAllNamed('/dashboard');
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

  void updateDurationInDb() {
    dbReference.child('duration').set(seconds.value);
  }
}
