import 'package:astro_brahmand/view/screen/agora/voicecall/controller/voice_call_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_round_network_image.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../chat/controller/image_picker_controller.dart';
import '../../wallet/controller/wallet_controller.dart';

class VoiceCallScreen extends StatelessWidget {
  VoiceCallScreen({super.key});
  final VoiceCallController controller = Get.put(VoiceCallController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    final ImagePickerController imagePickerController = Get.put(ImagePickerController());
    return PopScope(
      onPopInvoked: (bool isPopGesture) {
        if (!isPopGesture) {
          // Same cleanup as hang-up so orphaned call request doesn't break next chat
          controller.isBackPressed = true;
          Get.offAllNamed('/dashboard');
        }
      },
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body:Obx(
                () {
              if (controller.remoteUid.value != 0 && controller.isChatAccepted.isTrue) {
                return Stack(
                  children: [
                    Center(child: Container(
                      color: ColorResources.colorPrimary,
                      child: Column(
                          children: [
                            const Gap(20),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CustomRoundNetworkImage(
                                  imageUrl: controller.chatIntakeFormController.astrologerImage
                                      .toString(),
                                  height: Dimensions.imageHeightExtraLarge,
                                  width: Dimensions.imageHeightExtraLarge,
                                ),
                              ],
                            ),
                            const Gap(2),
                            CustomTextMedium(
                              controller.chatIntakeFormController.astrologerName.toString(),
                              fontSize: Dimensions.fontSizeExtraLarge,
                              color: ColorResources.white,
                            ),
                            const Gap(2),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //QuickRecharge Button
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Obx(() => controller.isChatAccepted.isTrue
                                      ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          if (!Get.isRegistered<WalletController>()) {
                                            Get.put(WalletController());
                                          }
                                          if (controller.uniqueId.isNotEmpty) {
                                            Get.find<WalletController>().setPaymentData(
                                              uniqueId: controller.uniqueId,
                                              channelName: controller.channelName,
                                              astroImage: controller.chatIntakeFormController.astrologerImage,
                                              astroName: controller.chatIntakeFormController.astrologerName,
                                              astroUniId: controller.chatIntakeFormController.astrologerUniId,
                                            );
                                          } else {
                                            debugPrint("⚠️ uniqueId is NULL or EMPTY in ChatController");
                                          }
                                          await Get.toNamed('/wallet');

                                          Future.delayed(const Duration(seconds: 10), () {
                                            controller.getRemainingDuration(controller.uniqueId);
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: ColorResources.white.withOpacity(0.05),
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: ColorResources.white),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(8.0))),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 12.0),
                                          child: CustomTextMedium(
                                            "Quick Recharge Now",
                                            fontSize: 10.0,
                                            color: ColorResources.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                      : const SizedBox.shrink()),
                                ),
                                Obx(() => controller.remoteUid.value != 0 && controller.isChatAccepted.isTrue
                                    ? Container(
                                  color: const Color.fromRGBO(
                                      0, 0, 0, 0.5),
                                  padding: const EdgeInsets.all(4.0),
                                  child: CustomTextRegular(
                                    controller.getFormattedTime(),
                                    color: ColorResources.white,
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                                )
                                    : Container(
                                  color: const Color.fromRGBO(
                                      0, 0, 0, 0.5), // Black with 50% opacity
                                  child: CustomTextRegular("Processing..",
                                    color: ColorResources.white,
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                                )),
                              ],
                            ),
                            const Gap(Dimensions.gapLarge),
                          ]
                      ),
                    )),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Column(
                        children: [
                          //Image Uploading
                          Obx(
                                () {
                              if (imagePickerController.isImagePicked.isTrue) {
                                //SendImage
                                controller.sendImage(
                                  controller.uniqueId.toString(),
                                  imagePickerController.imageFile.value!,
                                );

                                return Visibility(
                                    visible: imagePickerController.isImagePicked.isTrue,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Image.file(
                                            imagePickerController.imageFile.value!,
                                            width: 50,
                                            height: 50,
                                          ),
                                          const Gap(5),
                                          CustomTextRegular('Uploading image..')
                                        ],
                                      ),
                                    ));
                              } else {
                                return const Visibility(
                                    visible: false,
                                    child: Text('')
                                );
                              }
                            },
                          ),
                          const Gap(Dimensions.gapDefault),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      imagePickerController.showSelectBottomSheet();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                                      decoration: BoxDecoration(
                                        // shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(10),
                                        color: ColorResources.colorPrimaryDark,
                                      ),
                                      child: CustomTextRegular(
                                        "Send Images",
                                        color: Colors.white,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(Dimensions.gapDefault),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed("/call_image_list_screen",arguments: {
                                        "uniqueId": controller.uniqueId.toString()
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                                      decoration: BoxDecoration(
                                        // shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(10),
                                        color: ColorResources.colorPrimaryDark,
                                      ),
                                      child: CustomTextRegular(
                                        "View Images",
                                        color: Colors.white,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          const Gap(Dimensions.gapExtraLarge),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Gap(10),
                              _controlButton(
                                icon: controller.speaker.value
                                    ? Icons.volume_up
                                    : Icons.volume_up,
                                color: controller.speaker.value
                                    ? Colors.white
                                    : ColorResources.colorPrimaryMedium,
                                iconColor: controller.speaker.value
                                    ? ColorResources.colorPrimaryMedium
                                    : Colors.white,
                                onPressed: controller.onToggleSpeaker,
                              ),
                              _controlButton(
                                icon: controller.muted.value
                                    ? Icons.mic_off
                                    : Icons.mic_off,
                                color: controller.muted.value
                                    ? Colors.white
                                    : ColorResources.colorPrimaryMedium,
                                iconColor: controller.muted.value
                                    ? ColorResources.colorPrimaryMedium
                                    : Colors.white,
                                onPressed: controller.onToggleMute,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    Get.toNamed("/remedies",arguments: {
                                      "astrologer_uni_id" : controller.chatIntakeFormController.astrologerUniId.toString()
                                    });
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorResources.white,
                                    ),
                                    child: Center(
                                      child: Image.asset(Images.icRemedy,
                                          width: 30, height: 30),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    controller.endCall();
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorResources.red,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.call_end,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(10),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              else {
                return Container(
                  color: ColorResources.colorPrimaryLight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(20),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Lottie.asset(
                            Images.animDialing,
                            width: 200,
                            height: 200,
                          ),
                          CustomRoundNetworkImage(
                            imageUrl: controller.chatIntakeFormController.astrologerImage
                                .toString(),
                            height: Dimensions.imageHeightExtraLarge,
                            width: Dimensions.imageHeightExtraLarge,
                          ),
                        ],
                      ),
                      const Gap(2),
                      CustomTextMedium(
                        controller.chatIntakeFormController.astrologerName.toString(),
                        fontSize: Dimensions.fontSizeExtraLarge,
                      ),
                      const Gap(2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [CustomTextRegular("Ringing...")],
                      ),
                      const Gap(2),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CustomTextRegular(
                          "Please wait, Astrologer will join within 3 minutes. The session will start when the astrologer joins\n\nकृपया प्रतीक्षा करें, ज्योतिषी 3 मिनट के भीतर शामिल होंगे। सत्र ज्योतिषी के शामिल होते ही शुरू होगा।",
                          fontSize: Dimensions.fontSizeDefault,
                          color: ColorResources.colorSecondary,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Gap(10),
                          _controlButton(
                            icon: controller.muted.value
                                ? Icons.mic_off
                                : Icons.mic_off,
                            color: controller.muted.value
                                ? Colors.white
                                : ColorResources.black6,
                            iconColor: controller.muted.value
                                ? ColorResources.colorPrimaryMedium
                                : Colors.white,
                            onPressed: controller.onToggleMute,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                controller.endCall();
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorResources.red,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.call_end,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                        ],
                      ),
                      const Gap(20),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
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
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(
            child: Icon(
              icon,
              size: 30,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
