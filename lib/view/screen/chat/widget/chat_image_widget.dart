import 'package:astro_brahmand/utill/images.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/color_resources.dart';
import '../../../widget/custom_round_network_image.dart';
import '../../../widget/custom_text_regular.dart';
import '../model/chat_message_model.dart';

class ChatImageWidget extends StatelessWidget {
  final ChatMessageModel message;
  final String? userUniId;

  const ChatImageWidget(this.message, this.userUniId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          //Me
          if (message.senderUniId == userUniId) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: message.selectedText.toString().isNotEmpty,
                        // Set the visibility condition here
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 6),
                          decoration: BoxDecoration(
                            color: ColorResources.black7,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          constraints: const BoxConstraints(maxWidth: 250.0),
                          child: CustomTextRegular(
                            message.selectedText.toString(),
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 2),
                          decoration: BoxDecoration(
                            color: ColorResources.lightYellow,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          constraints: const BoxConstraints(maxWidth: 250.0),
                          child: GestureDetector(
                            onTap: () {
                              showPreviewDialog(message.fileUrl.toString());
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CustomNetworkImage(
                                  imageUrl: message.fileUrl.toString(),
                                  height: 140,
                                  width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                      // CustomTextRegular(
                      //   message.name!,
                      // ),
                      const Gap(2),
                      CustomTextRegular(
                        message.date.toString(),
                        fontSize: 10.0,
                        color: ColorResources.black4,
                      ),
                    ],
                  ),
                  const SizedBox(width: 5.0),
                  CustomRoundNetworkImage(
                      imageUrl: message.profileImageUrl.toString(),
                      height: 30,
                      width: 30),
                ],
              ),
            ),
          ] else ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomRoundNetworkImage(
                      imageUrl: message.profileImageUrl.toString(),
                      height: 30,
                      width: 30),
                  const SizedBox(width: 5.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: message.selectedText.toString().isNotEmpty,
                        // Set the visibility condition here
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 6),
                          decoration: BoxDecoration(
                            color: ColorResources.black7,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          constraints: const BoxConstraints(maxWidth: 250.0),
                          child: CustomTextRegular(
                            message.selectedText.toString(),
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 6),
                          decoration: BoxDecoration(
                            color: ColorResources.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          constraints: const BoxConstraints(maxWidth: 250.0),
                          child: GestureDetector(
                            onTap: () {
                              showPreviewDialog(message.fileUrl.toString());
                            },
                            child: CustomNetworkImage(
                                imageUrl: message.fileUrl.toString(),
                              height: 140,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          )),
                      // CustomTextRegular(
                      //   message.name!,
                      // ),
                      const Gap(2),
                      Text(
                        message.date.toString(),
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }


  void showPreviewDialog(String imageUrl) async {
    Get.dialog(
      useSafeArea: true,
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        content: Stack(
          children: <Widget>[
            CustomNetworkImage(
              imageUrl: imageUrl,
              height: Get.height * 0.7,
              width: Get.width * 0.8,
              fit: BoxFit.contain,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    Images.crossFill,
                    height: 26,
                    color: ColorResources.colorPrimaryDark,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void dismissDialog() {
    Get.back();
  }
}
