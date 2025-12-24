import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../utill/color_resources.dart';
import '../../../widget/custom_round_network_image.dart';
import '../../../widget/custom_text_regular.dart';
import '../controller/typing_controller.dart';
import '../model/question_history_list_model.dart';

class QuestionTextWidget extends StatelessWidget {
  QuestionHistoryData message;
  final String? userUniId;
  final bool isLastMessage;

  QuestionTextWidget(this.message, this.userUniId, {required this.isLastMessage, super.key});
  final TypingController typingController = Get.put(TypingController());

  @override
  Widget build(BuildContext context) {
    if(typingController.isTyping.isTrue && isLastMessage && message.userUniId != userUniId){
      typingController.startTypingEffect(message.message.toString());
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          // Me
          if (message.userUniId == userUniId) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 6),
                        decoration: BoxDecoration(
                          color: ColorResources.lightYellow,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        constraints: const BoxConstraints(maxWidth: 250.0),
                        child: CustomTextRegular(
                          message.message.toString(),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 5.0),
                  CustomRoundNetworkImage(
                      imageUrl: message.userImageUrl.toString(),
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
                      imageUrl: message.userImageUrl.toString(),
                      height: 30,
                      width: 30),
                  const SizedBox(width: 5.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 6),
                        decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        constraints: const BoxConstraints(maxWidth: 250.0),
                        child:  typingController.isTyping.isTrue  && isLastMessage ? Obx(
                              () => Text(
                               typingController.displayedMessage.value,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                          ),
                        ) : Text(
                          message.message.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                          ),
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
}
