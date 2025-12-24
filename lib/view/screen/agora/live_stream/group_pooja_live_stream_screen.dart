import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:astro_brahmand/view/screen/agora/live_stream/wiget/live_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_network_image.dart';
import '../../../widget/custom_round_network_image.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../chat/model/chat_message_model.dart';
import '../../splash/controller/config_controller.dart';
import 'controller/group_pooja_live_stream_controller.dart';

class GroupPoojaLiveStreamScreen extends StatelessWidget {
  GroupPoojaLiveStreamScreen({super.key});

  final GroupPoojaLiveStreamController controller = Get.put(GroupPoojaLiveStreamController());
  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    // LiveAstrologerController liveAstrologerController = Get.put<LiveAstrologerController>(LiveAstrologerController());
    // liveAstrologerController.isAstrologerSuccess(false);
    // liveAstrologerController.getAllAstrologer("live");
    return PopScope(
      onPopInvoked: (bool isPopGesture) {
        if (!isPopGesture) {
          controller.showLeaveDialog();
        }
      },
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          body: Obx(
            () {
              return Stack(
                children: [
                  //Video Views
                  Center(
                      child: Column(
                    children: [
                      //Astrologer
                      Expanded(
                          child: controller.remoteAstrologerUid.value != 0 &&
                                  controller.remoteAstrologerUid.value == controller.astrologerUID
                              ? _remoteAstrologerVideo()
                              : Image.asset(Images.bgLive, fit: BoxFit.fill)),
                      //Other Customer
                      Visibility(
                        visible: controller.remoteCustomerUid.value != 0 &&
                            controller.currentCallSession.value != null &&
                            controller.currentCallSession.value?.isVideoCall == true,
                        child: Expanded(child: _remoteCustomerVideo()),
                      ),
                      //When local user join as host
                      Visibility(
                        visible: controller.localUserJoined.value &&
                            controller.isMyRequestAccepted.isTrue &&
                            controller.currentCallSession.value != null &&
                            controller.currentCallSession.value?.isVideoCall == true,
                        child: Expanded(
                            child: controller.localUserJoined.value &&
                                    controller.isMyRequestAccepted.isTrue &&
                                    controller.currentCallSession.value != null &&
                                    controller.currentCallSession.value?.isVideoCall == true
                                ? AgoraVideoView(
                                    controller: VideoViewController(
                                      rtcEngine: controller.engine,
                                      canvas: const VideoCanvas(uid: 0),
                                    ),
                                  )
                                : Image.asset(Images.bgLive, fit: BoxFit.fill)),
                      ),
                    ],
                  )),
                  //Others Views
                  Container(
                      height: Get.height,
                      width: Get.width,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              //Customer Joined
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.liveButtonRadius),
                                child: Container(
                                  padding: const EdgeInsets.all(
                                      Dimensions.liveButtonIconPadding),
                                  color: Colors.black.withOpacity(0.3),
                                  child: Row(
                                    children: [
                                      CustomRoundNetworkImage(
                                          imageUrl: controller
                                              .liveDataController
                                              .astrologerImage
                                              .toString(),
                                          height: Dimensions.liveImageSize,
                                          width: Dimensions.liveImageSize),
                                      //Customer
                                      Obx(() {
                                        if (controller.currentCallSession.value != null) {
                                          return Visibility(
                                            visible: true,
                                            child: CustomRoundNetworkImage(
                                              imageUrl: controller.currentCallSession.value?.profileImageUrl.toString() ?? "",
                                              height: Dimensions.liveImageSize,
                                              width: Dimensions.liveImageSize,
                                            ),
                                          );
                                        } else {
                                          return const SizedBox
                                              .shrink(); // Return an empty widget if the condition is not met
                                        }
                                      }),

                                      const Gap(Dimensions.gapSmall),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextMedium(
                                            controller.liveDataController
                                                .astrologerName
                                                .toString(),
                                            fontSize: Dimensions.fontSizeSmall,
                                            color: ColorResources.white,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Visibility(
                                visible: controller.isRemoteUserMuted.value,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.liveButtonRadius),
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                        Dimensions.liveButtonIconPadding),
                                    color: Colors.black.withOpacity(0.3),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            CustomTextMedium(
                                              "${controller.liveDataController.astrologerName} muted audio",
                                              fontSize: Dimensions.fontSizeSmall,
                                              color: ColorResources.white,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              //Viewers
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.liveButtonRadius),
                                child: Container(
                                  padding: const EdgeInsets.all(
                                      Dimensions.liveButtonIconPadding),
                                  color: Colors.black.withOpacity(0.3),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.supervisor_account,
                                        color: Colors.white,
                                        size:
                                            Dimensions.liveButtonIconSizeSmall,
                                      ),
                                      const Gap(Dimensions.gapExtraSmall),
                                      Obx(
                                        () => CustomTextMedium(
                                          controller.liveUserCount.toString(),
                                          fontSize: Dimensions.fontSizeSmall,
                                          color: ColorResources.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(Dimensions.gapExtraSmall),
                              //Close
                              GestureDetector(
                                onTap: () {
                                  controller.showLeaveDialog();
                                },
                                child: ClipOval(
                                  child: Container(
                                    color: Colors.black.withOpacity(0.3),
                                    padding: const EdgeInsets.all(
                                        Dimensions.liveButtonIconPadding),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: Dimensions.liveButtonIconSize,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: const Color.fromRGBO(
                                0, 0, 0, 0.5),
                            padding: const EdgeInsets.all(4.0),
                            child: CustomTextRegular(
                              controller.getFormattedTime(),
                              color: ColorResources.toolbarText,
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                          ),
                          const Spacer(),
                          //Bottom Views
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() {
                                if (controller.hasGift.value &&
                                    controller.currentGift.value != null) {
                                  var gift = controller.currentGift.value!;
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.liveButtonRadius),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      color: Colors.black.withOpacity(0.3),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomRoundNetworkImage(
                                              imageUrl: gift.profileImageUrl
                                                  .toString(),
                                              height: 30,
                                              width: 30),
                                          const Gap(Dimensions.gapExtraSmall),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomTextMedium(
                                                gift.name.toString(),
                                                fontSize:
                                                    Dimensions.fontSizeSmall,
                                                color: ColorResources.white,
                                              ),
                                              CustomTextMedium(
                                                gift.giftName.toString(),
                                                fontSize: Dimensions
                                                    .fontSizeExtraSmall,
                                                color: ColorResources.white,
                                              ),
                                            ],
                                          ),
                                          const Gap(Dimensions.gapExtraSmall),
                                          CustomNetworkImage(
                                              imageUrl:
                                                  gift.giftImageUrl.toString(),
                                              height: 40,
                                              width: 40),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                              const Gap(Dimensions.gapSmall),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Obx(
                                          () => SizedBox(
                                            height: 250,
                                            child: ListView.builder(
                                              itemCount: controller
                                                  .chatHistoryList.length,
                                              reverse: true,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                ChatMessageModel message =
                                                    controller
                                                        .chatHistoryList[index];
                                                return LiveMessageWidget(
                                                    message);
                                              },
                                            ),
                                          ),
                                        ),
                                        //Typing
                                        GestureDetector(
                                          onTap: () {
                                            controller.showTypingBottomSheet();
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.liveButtonRadius),
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              child: Row(
                                                children: [
                                                  CustomTextRegular(
                                                    "Say hi...",
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                    color: ColorResources.white,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Gap(Dimensions.gapExtraLarge),
                                  Column(
                                    children: [
                                      _actionButton(
                                        icon: Icons.wallet_giftcard_sharp,
                                        color: Colors.black.withOpacity(0.3),
                                        iconColor: Colors.white,
                                        onPressed:
                                            controller.showGiftsBottomSheet,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Gap(Dimensions.gapSmall),
                              //Buttons Controls Mute an other
                              Visibility(
                                visible: false,
                                child: Row(
                                  children: [
                                    _controlButton(
                                      icon: Icons.flip_camera_ios,
                                      color: Colors.black.withOpacity(0.3),
                                      iconColor: Colors.white,
                                      onPressed: controller.onSwitchCamera,
                                    ),
                                    _controlButton(
                                      icon: controller.beautyVideo.value
                                          ? Icons
                                              .face_retouching_natural_outlined
                                          : Icons.face_retouching_off_outlined,
                                      color: controller.beautyVideo.value
                                          ? ColorResources.white
                                          : Colors.black.withOpacity(0.3),
                                      iconColor: controller.beautyVideo.value
                                          ? ColorResources.colorPrimaryMedium
                                          : Colors.white,
                                      onPressed: controller.onBeautyToggle,
                                    ),
                                    _controlButton(
                                      icon: controller.muted.value
                                          ? Icons.mic
                                          : Icons.mic_off,
                                      color: controller.muted.value
                                          ? ColorResources.white
                                          : Colors.black.withOpacity(0.3),
                                      iconColor: controller.muted.value
                                          ? ColorResources.colorPrimaryMedium
                                          : Colors.white,
                                      onPressed: controller.onToggleMute,
                                    ),
                                    _controlButton(
                                      icon: controller.mutedVideo.value
                                          ? Icons.videocam
                                          : Icons.videocam_off,
                                      color: controller.mutedVideo.value
                                          ? ColorResources.white
                                          : Colors.black.withOpacity(0.3),
                                      iconColor: controller.mutedVideo.value
                                          ? ColorResources.colorPrimaryMedium
                                          : Colors.white,
                                      onPressed: controller.onVideoOff,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _remoteAstrologerVideo() {
    if (controller.remoteAstrologerUid.value != 0 &&
        controller.remoteAstrologerUid.value == controller.astrologerUID) {
      return controller.isRemoteVideoMuted.value
          ? Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Images.logo,
                width: 100,
                height: 100,
              ),
              Text(
                'Video muted by ${controller.liveDataController.astrologerName}',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      )
          : AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: controller.engine,
          canvas: VideoCanvas(uid: controller.remoteAstrologerUid.value),
          connection: RtcConnection(channelId: controller.uniqueId),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _remoteCustomerVideo() {
    if (controller.remoteCustomerUid.value != 0 &&
        controller.currentCallSession.value != null &&
        controller.currentCallSession.value?.isVideoCall == true) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: controller.engine,
          canvas: VideoCanvas(uid: controller.remoteCustomerUid.value),
          connection: RtcConnection(channelId: controller.uniqueId),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _controlButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color color = Colors.white,
    Color iconColor = ColorResources.colorPrimaryMedium,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(Dimensions.liveButtonIconPaddingMedium),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(
            child: Icon(
              icon,
              size: Dimensions.liveButtonIconSizeMedium,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color color = Colors.white,
    Color iconColor = ColorResources.colorPrimaryMedium,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(Dimensions.liveButtonIconPaddingMedium),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
          child: Icon(
            icon,
            size: Dimensions.liveButtonIconSizeMedium,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
