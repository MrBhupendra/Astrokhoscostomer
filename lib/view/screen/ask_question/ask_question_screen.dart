import 'package:astro_brahmand/utill/app_features.dart';
import 'package:astro_brahmand/view/screen/ask_question/controller/ask_question_controller.dart';
import 'package:astro_brahmand/view/screen/ask_question/controller/predefined_message_controller.dart';
import 'package:astro_brahmand/view/screen/ask_question/widget/question_svg_widget.dart';
import 'package:astro_brahmand/view/screen/ask_question/widget/question_text_widget.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_default_indicator.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_round_network_image.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../splash/controller/config_controller.dart';
import 'model/question_history_list_model.dart';

class AskQuestionScreen extends GetView<AskQuestionController> {
  AskQuestionScreen({super.key});

  final PredefinedMessageController predefinedMessageController = Get.put(PredefinedMessageController());

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    predefinedMessageController.getPredefinedMessages(AppConstants.preTypeAiChat,offset: 0,createdBy: AppConstants.createdByAdmin);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.colorPrimary,
          automaticallyImplyLeading: false,
          title: Row(
            // mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 22,
                      color: ColorResources.toolbarText,
                    ),
                    onPressed: () {
                     Get.back();
                    }),
                const Gap(2),
                FutureBuilder<String?>(
                  future: getProfileImage(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return  CustomRoundNetworkImage(
                          imageUrl: snapshot.data.toString(),
                          height: 40,
                          width: 40);
                    }
                  },
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() =>  CustomTextMedium(controller.isChatHistorySuccess.isTrue ?  controller.questionHistoryListModel.openAIProfile!.name.toString() : AppConstants.appName,
                          fontSize: 16,
                          color: ColorResources.toolbarText)),
                     CustomTextRegular(
                          "There is a fee of ${configController.currencySymbol} ${controller.perQuestionPrice.toString()} per question",
                          color: ColorResources.toolbarText,
                          fontSize: Dimensions.fontSizeSmall),
                    ],
                  ),
                ),
                IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                      color: ColorResources.colorPrimaryDark,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        Images.language,
                        height: 18,
                        color: ColorResources.white,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.offNamed('/ask_question_profile_screen',arguments: {
                      "price": controller.perQuestionPrice,
                      "uniId": controller.userUniId,
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0, right: 5),
                  child: IconButton(
                    icon: Container(
                      decoration: BoxDecoration(
                        color: ColorResources.colorPrimaryDark,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          Images.myProfile,
                          height: 18,
                          color: ColorResources.white,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Get.offNamed('/ask_question_profile_screen',arguments: {
                      "price": controller.perQuestionPrice,
                      "uniId": controller.userUniId,
                      });
                    },
                  ),
                ),
              ]),
          titleSpacing: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.chatBackground),
                  fit: BoxFit.fill
              )
          ),
          child: Column(
            children: [
              Obx(() => Visibility(
                  visible: controller.isChatHistoryLoading.isTrue,
                  child: const Text("Loading.."))),
              // Expanded(
              //   child: Obx(
              //         () => ListView.builder(
              //       itemCount: controller.questionHistoryList.length,
              //       controller: controller.scrollController,
              //       reverse: true,
              //       shrinkWrap: true,
              //       itemBuilder: (context, index) {
              //         QuestionHistoryData message = controller.questionHistoryList[index];
              //         if (message.messageType == AppConstants.questionTypeText) {
              //           return QuestionTextWidget(message, controller.userUniId);
              //         } else if (message.messageType == AppConstants.questionTypeSvg && message.message.toString().isNotEmpty && message.message.toString() != "" && message.message.toString() != "{\"message\": \"Internal server error\"}") {
              //           return QuestionSvgWidget(message, controller.userUniId);
              //         }
              //         return const SizedBox();
              //       },
              //     ),
              //   ),
              // ),
              Expanded(
                child: Obx(
                      () => Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.questionHistoryList.length,
                              controller: controller.scrollController,
                              reverse: true,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                QuestionHistoryData message = controller.questionHistoryList[index];
                                if (message.messageType == AppConstants.questionTypeText) {
                                  return QuestionTextWidget(message, controller.userUniId,isLastMessage: index == 0);
                                } else if (message.messageType == AppConstants.questionTypeSvg && message.message.toString().isNotEmpty && message.message.toString() != "" && message.message.toString() != "{\"message\": \"Internal server error\"}") {
                                  return QuestionSvgWidget(message, controller.userUniId);
                                }
                                return const SizedBox();
                              },
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: AppFeatures.askAiQuePredefinedMsg,
                        child: Positioned(
                          right: 10,
                          top: 10,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierColor: Colors.transparent,
                                // Fully transparent background behind the dialog
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: Colors.black.withOpacity(0.3),
                                    // Makes the dialog itself fully transparent
                                    child: SizedBox(
                                      height: 400,
                                      width: 400,
                                      child: Obx(
                                            () {
                                          if (predefinedMessageController.isMessageSuccess.isTrue) {
                                            return ListView.builder(
                                              padding: const EdgeInsets.all(8),
                                              itemCount: predefinedMessageController.predefinedMessageList.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () async {
                                                    controller.getCalculation(
                                                        predefinedMessageController.predefinedMessageList[index].message.toString(),
                                                        1, "Open"
                                                    );
                                                    // predefinedMessageController.predefinedMessageList[index].message.toString()
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets.symmetric(vertical: 4), // Adds space between list items
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      // Background color for individual list items
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: ListTile(
                                                      title: CustomTextMedium(predefinedMessageController.predefinedMessageList[index].message.toString()),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          } else if (predefinedMessageController.isMessageLoading.isTrue) {
                                            return const CustomDefaultProgressIndicator();
                                          } else {
                                            return const EmptyScreen();
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: ColorResources.colorSecondaryDark,
                                  shape: BoxShape.circle),
                              child: Image.asset(
                                Images.message,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(5.0),
              Container(
                decoration: const BoxDecoration(
                    color: ColorResources.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        children: [
                          const Gap(12),
                          Flexible(
                              child: TextField(
                                controller: controller.messageController,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: ColorResources.black),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter your question..'),
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                if (controller.messageController.text.isNotEmpty) {
                                  controller.getCalculation(controller.messageController.text.toString(), 1, "Open");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  backgroundColor:
                                  ColorResources.colorPrimary),
                              child: const Icon(
                                Icons.send,
                                color: ColorResources.white,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> getProfileImage() async {
    String? profile = await SharedPreferencesHelper.getData(AppConstants.profileImage);
    return profile;
  }

  void showLanguageDialog(){
    Get.defaultDialog(
      title: 'Choose Language',
      content: Column(
        children: [
          ListTile(
            title: const Text('English'),
            onTap: () async {
              Get.back();
              CustomSnackBar.showBottom("Language Changed To English");
            },
          ),
          ListTile(
            title: const Text('हिन्दी'),
            onTap: () async {
              Get.back();
              CustomSnackBar.showBottom("Language Changed To Hindi");
            },
          ),
        ],
      )
    );
  }
}
