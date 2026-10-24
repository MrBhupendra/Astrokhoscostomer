import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:astro_brahmand/model/success_model.dart';
import 'package:astro_brahmand/view/screen/agora/live_stream/model/live_gift_list_model.dart';
import 'package:astro_brahmand/view/screen/dashboard/controller/live_astrologer_controller.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_progress_dialog.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:astro_brahmand/view/widget/simmer_widget/simmer_list_view.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../utill/app_constants.dart';
import '../../../../../utill/app_features.dart';
import '../../../../../utill/app_strings.dart';
import '../../../../../utill/color_resources.dart';
import '../../../../../utill/dimensions.dart';
import '../../../../../utill/images.dart';
import '../../../../../utill/shared_preference.dart';
import '../../../../widget/custom_elevated_button.dart';
import '../../../../widget/custom_empty_screen.dart';
import '../../../../widget/custom_round_network_image.dart';
import '../../../../widget/custom_text_medium.dart';
import '../../../../widget/custom_text_regular.dart';
import '../../../chat/model/chat_message_model.dart';
import '../../../chat/model/chat_remaining_time_model.dart';
import '../../../splash/controller/config_controller.dart';
import '../model/live_gift_model.dart';
import '../model/live_request_model.dart';
import '../wiget/live_request_widget.dart';
import 'live_stream_init_controller.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class LiveStreamController extends FullLifeCycleController with FullLifeCycleMixin {
  final LiveStreamInitController liveDataController = Get.put(LiveStreamInitController());
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

  final String publicVoiceCallStatusChild = "publicVoiceCall";
  final String publicVideoCallStatusChild = "publicVideoCall";
  final String privateVoiceCallStatusChild = "privateVoiceCall";
  final String privateVideoCallStatusChild = "privateVideoCall";
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
  var onPrivateCallStatusListener;
  var onPrivateVideoCallStatusListener;

  RxInt liveUserCount = 1.obs;
  var isLiveEnd = false.obs;
  var callStatus = false.obs;
  var videoCallStatus = false.obs;
  var privateCallStatus = false.obs;
  var privateVideoCallStatus = false.obs;

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

  //Timer
  RxInt seconds = 60.obs;
  RxBool isTimerRunning = false.obs;
  Timer? _timer;

  Rxn<LiveRequestModel> currentCallSession = Rxn<LiveRequestModel>();

  var isFollowLoading = false.obs;
  RxBool isFollow = false.obs;
  SuccessModel astrologerFollowModel = SuccessModel();

  final ConfigController configController = Get.find();
  final RxBool isRemoteVideoMuted = false.obs;
  final RxBool isRemoteUserMuted = false.obs;

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

    db = FirebaseDatabase.instance;
    dbReference = db.ref(liveChild).child(astrologerUniId!);
    messageReference = dbReference.child(messageChild);

    //Public voice call
    DataSnapshot publicVoiceCallStatusSnapshot = await dbReference.child(publicVoiceCallStatusChild).get();
    if (publicVoiceCallStatusSnapshot.exists && publicVoiceCallStatusSnapshot.value == true) {
      callStatus.value = true;
    } else {
      callStatus.value = false;
    }

    //Private voice call
    DataSnapshot privateVoiceCallStatusSnapshot = await dbReference.child(privateVoiceCallStatusChild).get();
    if (privateVoiceCallStatusSnapshot.exists && privateVoiceCallStatusSnapshot.value == true) {
      privateCallStatus.value = true;
    } else {
      privateCallStatus.value = false;
    }

    //Public video call
    DataSnapshot publicVideoCallStatusSnapshot = await dbReference.child(publicVideoCallStatusChild).get();
    if (publicVideoCallStatusSnapshot.exists && publicVideoCallStatusSnapshot.value == true) {
      videoCallStatus.value = true;
    } else {
      videoCallStatus.value = false;
    }

    //Private video call
    DataSnapshot privateVideoCallStatusSnapshot = await dbReference.child(privateVideoCallStatusChild).get();
    if (privateVideoCallStatusSnapshot.exists && privateVideoCallStatusSnapshot.value == true) {
      privateVideoCallStatus.value = true;
    } else {
      privateVideoCallStatus.value = false;
    }

    //LiveUserCount
    DataSnapshot userCountSnapshot = await dbReference.child(userCountChild).get();
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
    stopTimer();
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

    onUserCountListener = dbReference.child(userCountChild).onValue.listen((event) {
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

    onRequestAddListener = dbReference.child(requestsChild).orderByChild('timestamp').onChildAdded.listen((event) {
      final json = event.snapshot.value as Map<dynamic, dynamic>;
      final request = LiveRequestModel.fromJson(json);
      addRequest(request);
    }, onError: (error) {
      AppLogger.d('[LIVE] onRequestAddListener $error');
    });

    onRequestRemovedListener = dbReference.child(requestsChild).onChildRemoved.listen((event) {
      final json = event.snapshot.value as Map<dynamic, dynamic>;
      final request = LiveRequestModel.fromJson(json);
      removeRequest(request);
    }, onError: (error) {
      AppLogger.d('[LIVE] onRequestRemovedListener $error');
    });

    //Public Voice Call
    onCallStatusListener = dbReference.child(publicVoiceCallStatusChild).onValue.listen((event) {
      var dataSnapshot = event.snapshot;
      AppLogger.d('[LIVE] onCallStatusListener:onDataChange $dataSnapshot');
      callStatus.value = dataSnapshot.value as bool;
    }, onError: (error) {
      AppLogger.d('[LIVE] onCallStatusListener:onError $error');
    });

    //Private Voice Call
    onPrivateCallStatusListener = dbReference.child(privateVoiceCallStatusChild).onValue.listen((event) {
      var dataSnapshot = event.snapshot;
      AppLogger.d('[LIVE] onPrivateCallStatusListener:onDataChange $dataSnapshot');
      privateCallStatus.value = dataSnapshot.value as bool;
    }, onError: (error) {
      AppLogger.d('[LIVE] onPrivateCallStatusListener:onError $error');
    });

    //Public Video Call
    onVideoCallStatusListener = dbReference.child(publicVideoCallStatusChild).onValue.listen((event) {
      var dataSnapshot = event.snapshot;
      AppLogger.d('[LIVE] onVideoCallStatusListener:onDataChange $dataSnapshot');
      videoCallStatus.value = dataSnapshot.value as bool;
    }, onError: (error) {
      AppLogger.d('[LIVE] onVideoCallStatusListener:onError $error');
    });

    //Private Video Call
    onPrivateVideoCallStatusListener = dbReference.child(privateVideoCallStatusChild).onValue.listen((event) {
      var dataSnapshot = event.snapshot;
      AppLogger.d('[LIVE] onPrivateVideoCallStatusListener:onDataChange $dataSnapshot');
      privateVideoCallStatus.value = dataSnapshot.value as bool;
    }, onError: (error) {
      AppLogger.d('[LIVE] onPrivateVideoCallStatusListener:onError $error');
    });

    liveEndListener = dbReference.child(liveEndChild).onValue.listen((event) {
      var dataSnapshot = event.snapshot;
      AppLogger.d('[LIVE] ChatEnd:onDataChange $dataSnapshot');
      isLiveEnd.value = dataSnapshot.value as bool;
      if (isLiveEnd.value) {
        onMessageListener.cancel();
        onUserCountListener.cancel();
        onGiftListener.cancel();
        onRequestAddListener.cancel();
        onRequestRemovedListener.cancel();
        onCallStatusListener.cancel();
        onVideoCallStatusListener.cancel();
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
          height: Get.height * 0.5,
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
                  "Check other live sessions",
                  fontSize: Dimensions.fontSizeLarge,
                ),
              ),
              const Divider(thickness: 1.2),
              Expanded(
                child: Obx(
                      () {
                    if (liveAstrologerController.isAstrologerSuccess.isTrue) {
                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: liveAstrologerController.astrologerModel.data?.length, // Adjust this count based on your data
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              Get.delete<LiveStreamController>();
                              bool isLogin = await SharedPreferencesHelper.getIsLogin();
                              if (isLogin) {
                                String callRate = '**', callDuration = '**', videoRate = '**', videoDuration = '**',privateCallRate = '**', privateCallDuration = '**', privateVideoRate = '**', privateVideoDuration = '**';
                                liveAstrologerController.astrologerModel.data?[index].prices?.forEach((priceItem) {
                                  String type = priceItem.type.toString();
                                  switch (type) {
                                    case AppConstants.liveAudioCall:
                                      callRate = priceItem.price.toString();
                                      callDuration = priceItem.timeInMinutes.toString();
                                      break;
                                    case AppConstants.liveVideoCall:
                                      videoRate = priceItem.price.toString();
                                      videoDuration = priceItem.timeInMinutes.toString();
                                      break;
                                    case AppConstants.privateLiveAudioCall:
                                      privateCallRate = priceItem.price.toString();
                                      privateCallDuration = priceItem.timeInMinutes.toString();
                                      break;
                                    case AppConstants.privateLiveVideoCall:
                                      privateVideoRate = priceItem.price.toString();
                                      privateVideoDuration = priceItem.timeInMinutes.toString();
                                      break;
                                  }
                                });
                                final LiveStreamInitController liveController = Get.put(LiveStreamInitController());
                                String astrologerName = liveAstrologerController.astrologerModel.data![index].displayName.toString();
                                String astrologerImage = liveAstrologerController.astrologerModel.data![index].astroImg.toString();
                                liveController.setAstrologerData(astrologerName, astrologerImage, callRate, videoRate, callDuration, videoDuration,privateCallRate, privateVideoRate, privateCallDuration, privateVideoDuration,AppConstants.live);
                                // Join Live
                                int astrologerUID = liveAstrologerController.astrologerModel.data![index].user!.id!.toInt();
                                String uniqueId = liveAstrologerController.astrologerModel.data![index].liveChannel.toString();
                                String astrologerUniId = liveAstrologerController.astrologerModel.data![index].astrologerUniId.toString();
                                liveAstrologerController.joinLiveStream(astrologerUID, uniqueId, astrologerUniId);
                                AppLogger.d("astrologerUID->$astrologerUID uniqueId->$uniqueId astrologerUniId->$astrologerUniId");
                              }else{
                                Get.toNamed('/login');
                              }
                            },
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(color: ColorResources.colorPrimary)
                                      ),
                                      child: CustomRoundNetworkImage(
                                          imageUrl: liveAstrologerController.astrologerModel.data![index].astroImg.toString(),
                                          height: 55,
                                          width: 55
                                      ),
                                    ),
                                    // const CircleAvatar(
                                    //   radius: 30,
                                    //   backgroundImage: NetworkImage(
                                    //     'https://astrokhosh.com/uploads/astrologer/1722519399-astro_img.png', // Replace with actual image URLs
                                    //   ),
                                    // ),
                                    // Positioned(
                                    //   bottom: 0,
                                    //   left: 10,
                                    //   right: 10,
                                    //   child: Container(
                                    //     padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                    //     decoration: BoxDecoration(
                                    //       color: ColorResources.colorPrimary,
                                    //       borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                                    //     ),
                                    //     child: CustomTextRegular(
                                    //       "LIVE",
                                    //       fontSize: Dimensions.fontSizeExtraSmall,
                                    //       color: ColorResources.toolbarText,
                                    //       textAlign: TextAlign.center,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                const Gap(4),
                                CustomTextRegular(
                                  liveAstrologerController.astrologerModel.data![index].displayName.toString(),
                                  fontSize: Dimensions.fontSizeSmall,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    else if (liveAstrologerController.isAstrologerLoading.isTrue) {
                      return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const SimmerListView();
                        },
                      );
                    } else {
                      return const EmptyScreen();
                    }
                  },
                ),
              ),
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

  void addRequest(LiveRequestModel requestModel) {
    requestList.add(requestModel);
  }

  void removeRequest(LiveRequestModel requestModel) {
    requestList
        .removeWhere((item) => item.senderUniId == requestModel.senderUniId);
  }

  void sendRequest(LiveRequestModel requestModel) {
    dbReference
        .child(requestsChild)
        .child(customerUid.toString())
        .set(requestModel.toJson())
        .then((_) {
      //Send Message
      String message = "${requestModel.name} Joined the Wait List";
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

      isMyRequestPending(true);
      registerMyRequestListeners();
    });
  }

  void deleteMyRequest(LiveRequestModel requestModel) {
    dbReference.child(requestsChild).child(requestModel.senderUid.toString()).remove();
    isMyRequestPending(false);
    //Cancel Listeners
    onMyRequestAcceptListener.cancel();
    onMyCallEndedListener.cancel();
  }

  Future<void> registerMyRequestListeners() async {
    DataSnapshot myRequest = await dbReference.child(requestsChild).child(customerUid.toString()).get();

    if (myRequest.exists) {
      onMyRequestAcceptListener = dbReference.child(requestsChild).child(customerUid.toString()).child("isAccepted").onValue
          .listen((event) async {
        var isAcceptedSnap = event.snapshot;

        if (isAcceptedSnap.exists) {
          isMyRequestAccepted.value = isAcceptedSnap.value as bool;

          if(isMyRequestAccepted.isTrue){
            isMyRequestPending(false); //Now request is accepted so hide cancel button
            currentCallSession.value = await getCurrentCallSession(customerUid.toString()); //Get values in call session
            showRequestAcceptedDialog(liveDataController.astrologerName.toString(),liveDataController.astrologerImage.toString(),currentCallSession.value!.callType.toString());
            seconds.value =  currentCallSession.value?.duration as int;
            startTimer();
            if(currentCallSession.value != null && currentCallSession.value?.isVideoCall == true){
              await switchToVideoCoHost();
            }else if(currentCallSession.value != null && currentCallSession.value?.isVideoCall == false){
              await switchToAudioCoHost();
            }
          }
        } else {
          AppLogger.d("[LIVE] isAcceptedSnap not exists");
        }
      }, onError: (error) {
        AppLogger.d('[LIVE] onMyRequestAcceptListener:onError $error');
      });


      onMyCallEndedListener = dbReference.child(requestsChild).child(customerUid.toString()).child("isEnd").onValue
          .listen((event) async {
        var isEndedSnap = event.snapshot;
        if (isEndedSnap.exists) {
          isMyCallEnded.value = isEndedSnap.value as bool;
          if( isMyCallEnded.isTrue){
            isMyRequestPending(false); //Request is declined so hide cancel button
            isMyRequestAccepted(false); //Hide end button
            currentCallSession.value = null;
            stopTimer();
            //Cancel Listeners
            onMyRequestAcceptListener.cancel();
            onMyCallEndedListener.cancel();
            await engine.setClientRole(role: ClientRoleType.clientRoleAudience);
            await engine.joinChannel(
              token: agoraToken,
              channelId: uniqueId,
              uid: customerUid,
              options: const ChannelMediaOptions(),
            );
          }

        }else {
          AppLogger.d("[LIVE] isEndedSnap not exists");
        }

      },onError: (error) {
        AppLogger.d('[LIVE] onMyCallEndedListener:onError $error');
      });


    } else {
      CustomSnackBar.showTop("No request found to register listener");
      AppLogger.d('[LIVE] No request found to register listener');
    }

    // onMyCallEndedListener = dbReference
    //     .child(requestsChild)
    //     .child(customerUid.toString())
    //     .child("isEnd")
    //     .onValue
    //     .listen((event) async {
    //   var dataSnapshot = event.snapshot;
    //   currentCallSession = null;
    //   isMyCallEnded.value = dataSnapshot.value as bool;
    //   if (isMyCallEnded.value) {
    //     if (isMyRequestWasAccepted == true) {
    //       deleteMyRequest(
    //         LiveRequestModel(
    //           senderUid: customerUid.toString(),
    //         ),
    //       );
    //       isMyRequestPending(false);
    //       isMyRequestWasAccepted = false;
    //       await engine.setClientRole(role: ClientRoleType.clientRoleAudience);
    //       await engine.enableVideo();
    //       await engine.joinChannel(
    //         token: agoraToken,
    //         channelId: uniqueId,
    //         uid: customerUid,
    //         options: const ChannelMediaOptions(),
    //       );
    //     }
    //     onMyRequestAcceptListener.cancel();
    //     onMyCallEndedListener.cancel();
    //   }
    //
    //   if (kDebugMode) {
    //     print('[LIVE] onMyCallEndedListener:onDataChange $dataSnapshot');
    //   }
    // }, onError: (error) {
    //   if (kDebugMode) {
    //     print('[LIVE] onMyCallEndedListener:onError $error');
    //   }
    // });
  }

  Future<void> endCall() async {
    DataSnapshot isAccepted = await dbReference
        .child(requestsChild)
        .child(customerUid.toString())
        .child("isAccepted")
        .get();

    if (isAccepted.exists) {
      dbReference
          .child(requestsChild)
          .child(customerUid.toString())
          .child("isAccepted")
          .set(false);
      dbReference
          .child(requestsChild)
          .child(customerUid.toString())
          .child("isEnd")
          .set(true);
    }
  }

  void leaveLive() {}

  Future<LiveRequestModel?> getCurrentCallSession(String customerUid) async {
    DataSnapshot snapshot =
    await dbReference.child(requestsChild).child(customerUid).get();
    if (snapshot.value != null) {
      final json = Map<String, dynamic>.from(snapshot.value as Map);
      return LiveRequestModel.fromJson(json);
    } else {
      return null;
    }
  }

  //API
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

  Future<void> sendRequestApi(String uniqueId, String astrologerId, String callType, bool videoCall) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.sendLiveRequest, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "astrologer_uni_id": astrologerId,
        "call_type": callType,
        "channel_name": uniqueId
      });

      AppLogger.d("AS1 Req $apiKey  $uniId  $astrologerId  $callType  $uniqueId");

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        requestSendSuccessModel = SuccessModel.fromJson(response.data);
        if (requestSendSuccessModel.status == AppConstants.success) {
          int? liveDurationSeconds = response.data["data"]["second"];
          //num? liveDurationMin = response.data["data"]["minutes"];
          sendRequest(
            LiveRequestModel(
                senderUid: customerUid.toString(),
                senderUniId: customerUniId,
                orderId: "CALL100",
                name: customerName,
                profileImageUrl: customerImage,
                duration: liveDurationSeconds,
                date: getCurrentDateTime(),
                isAccepted: false,
                isEnd: false,
                isVideoCall: videoCall,
                callType: callType,
                timestamp: ServerValue.timestamp),
          );
        } else {
          CustomSnackBar.showTop(requestSendSuccessModel.msg.toString());
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
      },
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) async {
        AppLogger.d("[LIVE] remote user $remoteUid joined");
        this.remoteUid.value = remoteUid;
        if (remoteUid == astrologerUID) {
          remoteAstrologerUid.value = remoteUid;
        } else {
          remoteCustomerUid.value = remoteUid;
          currentCallSession.value = await getCurrentCallSession(remoteCustomerUid.value.toString());
          seconds.value =  currentCallSession.value?.duration as int;
          startTimer();

          if(currentCallSession.value?.callType == AppConstants.privateLiveAudioCall){
            engine.muteRemoteAudioStream(uid: remoteCustomerUid.value, mute: true); //Customer
            engine.muteRemoteAudioStream(uid: remoteAstrologerUid.value, mute: true); //Astrologer
          }

          if(currentCallSession.value?.callType == AppConstants.privateLiveVideoCall){
            engine.muteRemoteAudioStream(uid: remoteCustomerUid.value, mute: true); //Customer
            engine.muteRemoteVideoStream(uid: remoteCustomerUid.value, mute: true); //Customer
            engine.muteRemoteAudioStream(uid: remoteAstrologerUid.value, mute: true); //Astrologer
          }
        }
      },
      onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
        AppLogger.d("[LIVE] remote user $remoteUid left channel");
        engine.muteRemoteAudioStream(uid: remoteCustomerUid.value, mute: false); //Customer
        engine.muteRemoteVideoStream(uid: remoteCustomerUid.value, mute: false); //Customer
        engine.muteRemoteAudioStream(uid: remoteAstrologerUid.value, mute: false); //Astrologer
        this.remoteUid.value = 0;
        if (remoteUid == astrologerUID) {
          remoteAstrologerUid.value = 0;
        } else {
          remoteCustomerUid.value = 0;
          currentCallSession.value = null;
          isRemoteUserMuted.value = false;
          isRemoteVideoMuted.value = false;
          stopTimer();
        }
      },
      onUserMuteAudio: (RtcConnection connection, int uid, bool muted) {
        AppLogger.d("Remote user $uid audio muted: $muted");
        isRemoteUserMuted.value = muted;
      },
      onUserMuteVideo: (RtcConnection connection, int uid, bool muted) {
        AppLogger.d("Remote user $uid video muted: $muted");
        isRemoteVideoMuted.value = muted;
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

  void showCallBottomSheet() {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
              child: Column(
                children: [
                  CustomRoundNetworkImage(
                      imageUrl: liveDataController.astrologerImage.toString(),
                      height: Dimensions.liveImageProfileSize,
                      width: Dimensions.liveImageProfileSize),
                  const Gap(Dimensions.gapDefault),
                  CustomTextMedium(
                    liveDataController.astrologerName.toString(),
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                  const Gap(Dimensions.gapOverLarge),
                  //Public Voice Call
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorResources.colorPrimary,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.call,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Gap(6),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextMedium(
                                "Audio Call",
                                fontSize: Dimensions.fontSizeFifteen,
                                color: ColorResources.black,
                              ),
                              CustomTextMedium(
                                "${configController.currencySymbol} ${liveDataController.callPrice.toString()} For ${liveDataController.callDuration.toString()} min",
                                fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.black,
                              ),
                              CustomTextRegular(
                                "Astrologer on video, you on audio.",
                                fontSize: Dimensions.fontSizeSmall,
                                color: ColorResources.black5,
                              ),
                            ],
                          )),
                      Obx(() {
                        return GestureDetector(
                          onTap: () {
                            if (callStatus.isTrue) {
                              Get.back();
                              sendRequestApi(uniqueId, astrologerUniId.toString(), AppConstants.liveAudioCall, false);
                            } else {
                              CustomSnackBar.showTop("Astrologer is not available for Voice Call.");
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 15),
                            decoration: BoxDecoration(
                                color: callStatus.value
                                    ? ColorResources.colorPrimaryMedium
                                    : ColorResources.grey,
                                borderRadius: BorderRadius.circular(8)),
                            child: CustomTextMedium(
                              callStatus.value ? "Join" : "Offline",
                              color: callStatus.value
                                  ? ColorResources.white
                                  : ColorResources.red,
                              fontSize: Dimensions.fontSizeSmall,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  const Gap(Dimensions.gapExtraSmall),
        
                  //Public Video Call
                  const Divider(),
                  const Gap(Dimensions.gapExtraSmall),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorResources.colorPrimary,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.videocam_sharp,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Gap(6),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextMedium(
                                "Video Call",
                                fontSize: Dimensions.fontSizeFifteen,
                                color: ColorResources.black,
                              ),
                              CustomTextMedium(
                                "${configController.currencySymbol} ${liveDataController.videoCallPrice.toString()} For ${liveDataController.videoCallDuration.toString()} min",
                                fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.black,
                              ),
                              CustomTextRegular(
                                "Astrologer on video, you on video.",
                                fontSize: Dimensions.fontSizeSmall,
                                color: ColorResources.black5,
                              ),
                            ],
                          )),
                      Obx(() {
                        return GestureDetector(
                          onTap: () {
                            if (videoCallStatus.isTrue) {
                              Get.back();
                              sendRequestApi(uniqueId, astrologerUniId.toString(), AppConstants.liveVideoCall, true);
                            } else {
                              CustomSnackBar.showTop("Astrologer is not available for Video Call.");
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 15),
                            decoration: BoxDecoration(
                                color: videoCallStatus.value
                                    ? ColorResources.colorPrimaryMedium
                                    : ColorResources.grey,
                                borderRadius: BorderRadius.circular(8)),
                            child: CustomTextMedium(
                              videoCallStatus.value ? "Join" : "Offline",
                              color: videoCallStatus.value
                                  ? ColorResources.white
                                  : ColorResources.red,
                              fontSize: Dimensions.fontSizeSmall,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
        
                  if(AppFeatures.privateCall)
                    Column(
                      children: [
                        //Private Voice Call
                        const Divider(),
                        const Gap(Dimensions.gapExtraSmall),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorResources.colorPrimary,
                              ),
                              child: Center(
                                child: Image.asset(Images.privateCall,
                                  height: 24,
                                  width: 24,
                                  color:Colors.black,),
                              ),
                            ),
                            const Gap(6),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextMedium(
                                      "Private Audio Call",
                                      fontSize: Dimensions.fontSizeFifteen,
                                      color: ColorResources.black,
                                    ),
                                    CustomTextMedium(
                                      "${configController.currencySymbol} ${liveDataController.privateCallPrice.toString()} For ${liveDataController.privateCallDuration.toString()} min",
                                      fontSize: Dimensions.fontSizeDefault,
                                      color: ColorResources.black,
                                    ),
                                    CustomTextRegular(
                                      "Astrologer on video, you on audio.\nNo one can hear your conversation.",
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: ColorResources.black5,
                                    ),
                                  ],
                                )),
                            Obx(() {
                              return GestureDetector(
                                onTap: () {
                                  if (privateCallStatus.isTrue) {
                                    Get.back();
                                    sendRequestApi(uniqueId, astrologerUniId.toString(), AppConstants.privateLiveAudioCall, false);
                                  } else {
                                    CustomSnackBar.showTop("Astrologer is not available for Private Audio Call.");
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: privateCallStatus.value
                                          ? ColorResources.colorPrimaryMedium
                                          : ColorResources.grey,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: CustomTextMedium(
                                    privateCallStatus.value ? "Join" : "Offline",
                                    color: privateCallStatus.value
                                        ? ColorResources.white
                                        : ColorResources.red,
                                    fontSize: Dimensions.fontSizeSmall,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
        
                        //Private Video Call
                        const Divider(),
                        const Gap(Dimensions.gapExtraSmall),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorResources.colorPrimary,
                              ),
                              child: Center(
                                child: Image.asset(Images.privateVideoCall,
                                  height: 24,
                                  width: 24,
                                  color:Colors.black,),
                              ),
                            ),
                            const Gap(6),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextMedium(
                                      "Private Video Call",
                                      fontSize: Dimensions.fontSizeFifteen,
                                      color: ColorResources.black,
                                    ),
                                    CustomTextMedium(
                                      "${configController.currencySymbol} ${liveDataController.privateVideoCallPrice.toString()} For ${liveDataController.privateVideoCallDuration.toString()} min",
                                      fontSize: Dimensions.fontSizeDefault,
                                      color: ColorResources.black,
                                    ),
                                    CustomTextRegular(
                                      "Astrologer on video, you on video.\nNo one can hear your conversation.\nNo one can see your video.",
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: ColorResources.black5,
                                    ),
                                  ],
                                )),
                            Obx(() {
                              return GestureDetector(
                                onTap: () {
                                  if (privateVideoCallStatus.isTrue) {
                                    Get.back();
                                    sendRequestApi(uniqueId, astrologerUniId.toString(), AppConstants.privateLiveVideoCall, true);
                                  } else {
                                    CustomSnackBar.showTop("Astrologer is not available for Private Video Call.");
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: privateVideoCallStatus.value
                                          ? ColorResources.colorPrimaryMedium
                                          : ColorResources.grey,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: CustomTextMedium(
                                    privateVideoCallStatus.value ? "Join" : "Offline",
                                    color: privateVideoCallStatus.value
                                        ? ColorResources.white
                                        : ColorResources.red,
                                    fontSize: Dimensions.fontSizeSmall,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
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

  void showRequestBottomSheet() {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          constraints: BoxConstraints(maxHeight: Get.height*0.45),
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
                CustomTextMedium(
                  "WaitList",
                  fontSize: Dimensions.fontSizeLarge,
                ),
                const Gap(Dimensions.gapExtraExtraSmall),
                Obx(
                      () => CustomTextMedium(
                    "Total: ${requestList.length.toString()}",
                    fontSize: Dimensions.fontSizeDefault,
                    color: ColorResources.colorPrimaryMedium,
                  ),
                ),
                const Gap(Dimensions.gapDefault),
                Expanded(
                  child: Obx(
                        () => ListView.builder(
                      itemCount: requestList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        LiveRequestModel request = requestList[index];
                        return LiveRequestWidget(request);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void shareLiveStream() {
    String encodedAstrologerImage = Uri.encodeComponent(liveDataController.astrologerImage.toString());
    String slugUrl = "${AppConstants.baseUrl}/liveAstrologer/$uniqueId/$astrologerUniId/$astrologerUID/${liveDataController.astrologerName?.replaceAll(' ', '')}/${encodedAstrologerImage}/${liveDataController.callPrice}/${liveDataController.videoCallPrice}/${liveDataController.callDuration}/${liveDataController.videoCallDuration}";
    String message = """🌟Hi! ${liveDataController.astrologerName} is live right now on ${AppConstants.appName}🌙✨. Join with us by clicking the link to get a guide you through life's journey with personalized astrological insights. ${slugUrl}
    """;
    Share.share(message);
  }

  void showRequestAcceptedDialog(String name,String image,String callType) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomRoundNetworkImage(imageUrl: image, height: 60, width: 60),
              const Gap(Dimensions.gapExtraSmall),
              CustomTextMedium(name,fontSize: Dimensions.fontSizeDefault),
              const Gap(Dimensions.gapDefault),
              CustomTextRegular(callType == AppConstants.liveVideoCall ? "Your Video Call Session With $name Started."
                  : callType == AppConstants.liveAudioCall ? "Your Audio Call Session With $name Started."
                  : callType == AppConstants.privateLiveAudioCall ? "Your Private Audio Call Session With $name Started."
                  : "Your Private Video Call Session With $name Started.",
                fontSize: Dimensions.fontSizeDefault,color: ColorResources.colorPrimaryMedium,textAlign: TextAlign.center,),
              const Gap(Dimensions.gapMedium),
              CustomElevatedButton(
                text: "OK",
                onPressed: () {
                  Get.back();
                },
                backgroundColor: ColorResources.colorPrimary,
                textColor: ColorResources.toolbarText,
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> switchToVideoCoHost() async {
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.enableVideo();
    await engine.startPreview();
    await engine.setBeautyEffectOptions(
        enabled: beautyVideo.value, options: options);
    await engine.joinChannel(
      token: agoraToken,
      channelId: uniqueId,
      uid: customerUid,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> switchToAudioCoHost() async {
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.enableVideo();
    await engine.joinChannel(
      token: agoraToken,
      channelId: uniqueId,
      uid: customerUid,
      options: const ChannelMediaOptions(),
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
}
