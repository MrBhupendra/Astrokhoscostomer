import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_network_image.dart';
import '../../../widget/custom_round_network_image.dart';
import '../../../widget/custom_text_regular.dart';
import '../../ask_question/controller/typing_controller.dart';
import '../controller/chat_intake_form_controller.dart';
import '../model/chat_message_model.dart';
import 'message_status_icon.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessageModel message;
  final String? userUniId;
  final bool isLastMessage;
  ChatMessageWidget(this.message, this.userUniId, {required this.isLastMessage,super.key});
  final TypingController typingController = Get.put(TypingController());
  final ChatIntakeFormController chatIntakeFormController = Get.put(ChatIntakeFormController());
  @override
  Widget build(BuildContext context) {
    if(chatIntakeFormController.isVirtualAstrologer == 1 && typingController.isTyping.isTrue && isLastMessage && message.senderUniId != userUniId){
      typingController.startTypingEffect(message.text.toString());
    }
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
                        visible: message.selectedText.toString().isNotEmpty && message.selectedType == AppConstants.text,
                        // Set the visibility condition here
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 6),
                          decoration: BoxDecoration(
                            color: ColorResources.black7,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          constraints: const BoxConstraints(maxWidth: 250.0),
                          child: CustomTextRegular(
                            message.selectedText.toString(),
                          ),
                        ),
                      ), //Text Selected
                      Visibility(
                        visible: message.selectedText.toString().isNotEmpty && message.selectedType == AppConstants.image,
                        // Set the visibility condition here
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 6),
                          decoration: BoxDecoration(
                            color: ColorResources.black7,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          constraints: const BoxConstraints(maxWidth: 250.0),
                          child: GestureDetector(
                            onTap: () {
                              showPreviewDialog(message.selectedText.toString());
                            },
                            child: CustomNetworkImage(
                                imageUrl: message.selectedText.toString(),
                                height: 100,
                                width: 100),
                          ),
                        ),
                      ), //Image Selected
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 6),
                          decoration: BoxDecoration(
                            color: ColorResources.lightYellow,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          constraints: const BoxConstraints(maxWidth: 250.0),
                          child: CustomTextRegular(
                            message.text.toString(),
                            fontSize: 14,
                          )
                      ),
                      const Gap(2),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextRegular(
                            CommonMethods().formatDateTimeOutput(message.date.toString()),
                            fontSize: 10.0,
                            color: ColorResources.black4,
                          ),
                          const Gap(4),
                          buildMessageStatusIcon(message, userUniId),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 5.0),
                  CustomRoundNetworkImage(
                      imageUrl: message.profileImageUrl.toString(),
                      height:
                      30,
                      width:
                      30
                  ),
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
                      height:
                      30,
                      width:
                      30
                  ),
                  const SizedBox(width: 5.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: message.selectedText.toString().isNotEmpty && message.selectedType == AppConstants.text,
                        // Set the visibility condition here
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 6),
                          decoration: BoxDecoration(
                            color: ColorResources.black7,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          constraints: const BoxConstraints(maxWidth: 250.0),
                          child: CustomTextRegular(
                            message.selectedText.toString(),
                          ),
                        ),
                      ),//Text Selected
                      Visibility(
                        visible: message.selectedText.toString().isNotEmpty && message.selectedType == AppConstants.image,
                        // Set the visibility condition here
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 6),
                          decoration: BoxDecoration(
                            color: ColorResources.black7,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          constraints: const BoxConstraints(maxWidth: 250.0),
                          child: GestureDetector(
                            onTap: () {
                              showPreviewDialog(message.selectedText.toString());
                            },
                            child: CustomNetworkImage(
                                imageUrl: message.selectedText.toString(),
                                height: 100,
                                width: 100),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 6),
                        decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        constraints: const BoxConstraints(maxWidth: 250.0),
                        child:  typingController.isTyping.isTrue  && isLastMessage && chatIntakeFormController.isVirtualAstrologer == 1 ? Obx(
                              () => Text(
                            typingController.displayedMessage.value,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                        ) : Text(
                          CommonMethods().maskMobileNumber(message.text.toString()) ,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      // CustomTextRegular(
                      //   message.name!,
                      // ),
                      const Gap(2),
                      Text(
                        CommonMethods().formatDateTimeOutput(message.date.toString()),
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
}
