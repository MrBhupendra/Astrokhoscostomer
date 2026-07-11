import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:astro_brahmand/view/screen/agora/videocall/controller/video_call_controller.dart';
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
import '../../wallet/controller/wallet_controller.dart';

class VideoCallScreen extends StatelessWidget {
  VideoCallScreen({super.key});
  final VideoCallController controller = Get.put(VideoCallController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool isPopGesture) {
        if (!isPopGesture) {
          // Same cleanup as hang-up so orphaned call request doesn't break next chat
          controller.endCall();
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
                   Center(child: _remoteVideo()),
                   Align(
                     alignment: Alignment.topLeft,
                     child: SizedBox(
                       width: 100,
                       height: 150,
                       child: Center(
                         child: controller.mutedVideo.value ? Container(
                           width: double.infinity,
                           color: Colors.black,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Image.asset(
                                 Images.logo,
                                 width: 50,
                                 height: 50,
                               ),
                               const Text("Video Muted", style: TextStyle(color: ColorResources.white),)
                             ],
                           ),
                         ) : controller.localUserJoined.value
                             ? AgoraVideoView(
                           controller: VideoViewController(
                             rtcEngine: controller.engine,
                             canvas: const VideoCanvas(uid: 0),
                           ),
                         )
                             : const CircularProgressIndicator(),
                       ),
                     ),
                   ),
                   Positioned(
                     bottom: 10,
                     left: 10,
                     right: 10,
                     child: Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Obx(() => controller.remoteUid.value != 0 && controller.isChatAccepted.isTrue
                                 ? Container(
                               color: const Color.fromRGBO(
                                   0, 0, 0, 0.5),
                               padding: const EdgeInsets.all(4.0),
                               child: CustomTextRegular(
                                 controller.getFormattedTime(),
                                 color: ColorResources.toolbarText,
                                 fontSize: Dimensions.fontSizeDefault,
                               ),
                             )
                                 : Container(
                               color: const Color.fromRGBO(
                                   0, 0, 0, 0.5), // Black with 50% opacity
                               child: CustomTextRegular("Processing..",
                                 color: ColorResources.toolbarText,
                                 fontSize: Dimensions.fontSizeDefault,
                               ),
                             )),
                           ],
                         ),
                         const Gap(Dimensions.gapLarge),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             const Gap(10),
                             _controlButton(
                               icon: Icons.flip_camera_ios,
                               onPressed: controller.onSwitchCamera,
                               color:ColorResources.black6,
                               iconColor: Colors.white,
                             ),
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
                             _controlButton(
                               icon:
                               controller.mutedVideo.value ? Icons.videocam_off : Icons.videocam_off,
                               color: controller.mutedVideo.value
                                   ? Colors.white
                                   : ColorResources.black6,
                               iconColor: controller.mutedVideo.value
                                   ? ColorResources.colorPrimaryMedium
                                   : Colors.white,
                               onPressed: controller.onVideoOff,
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
                   Positioned(
                     top: 20,
                     right: 0,
                     child: //QuickRecharge Button
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
                   ),
                 ],
               );
             } else {
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
                           icon: Icons.flip_camera_ios,
                           onPressed: controller.onSwitchCamera,
                           color:ColorResources.black6,
                           iconColor: Colors.white,
                         ),
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
                         _controlButton(
                           icon:
                           controller.mutedVideo.value ? Icons.videocam_off : Icons.videocam_off,
                           color: controller.mutedVideo.value
                               ? Colors.white
                               : ColorResources.black6,
                           iconColor: controller.mutedVideo.value
                               ? ColorResources.colorPrimaryMedium
                               : Colors.white,
                           onPressed: controller.onVideoOff,
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

  Widget _remoteVideo() {
    if (controller.remoteUid.value != 0 && controller.isChatAccepted.isTrue) {
      return Stack(
        children: [
          controller.isRemoteVideoMuted.value
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
                    'Video muted by ${controller.chatIntakeFormController.astrologerName}',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          )
              : AgoraVideoView(
            controller: VideoViewController.remote(
              rtcEngine: controller.engine,
              canvas: VideoCanvas(uid: controller.remoteUid.value),
              connection: RtcConnection(channelId: controller.uniqueId),
            ),
          ),
          if (controller.isRemoteUserMuted.value)
            Positioned(
              bottom: 130,
              left: 10,
              right: 10,
              child: Container(
                color: Colors.red.withOpacity(0.7),
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  '${controller.chatIntakeFormController.astrologerName} has muted their audio',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }


  /* Widget _remoteVideo() {
    if (controller.remoteUid.value != 0 && controller.isChatAccepted.isTrue) {

      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: controller.engine,
          canvas: VideoCanvas(uid: controller.remoteUid.value),
          connection: RtcConnection(channelId: controller.uniqueId),
        ),
      );
    }
    else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }*/

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
