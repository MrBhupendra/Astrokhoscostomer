import 'package:astro_brahmand/utill/app_features.dart';
import 'package:astro_brahmand/view/screen/ask_question/controller/ask_question_controller.dart';
import 'package:astro_brahmand/view/screen/ask_question/controller/predefined_message_controller.dart';
import 'package:astro_brahmand/view/screen/ask_question/widget/question_profile_widget.dart';
import 'package:astro_brahmand/view/screen/ask_question/widget/question_svg_widget.dart';
import 'package:astro_brahmand/view/screen/ask_question/widget/question_text_widget.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../model/home_menu_model.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_default_indicator.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_progress_indicator.dart';
import '../../widget/custom_round_network_image.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../../widget/free_service_widget.dart';
import '../dashboard/controller/dashboard_controller.dart';
import '../splash/controller/config_controller.dart';
import 'model/question_history_list_model.dart';

class AskQuestionScreenNew extends GetView<AskQuestionController> {
  AskQuestionScreenNew({super.key});

  final PredefinedMessageController predefinedMessageController = Get.put(PredefinedMessageController());
  final DashboardController dashboardController = Get.put<DashboardController>(DashboardController());

  RxDouble questionLeft = 0.0.obs;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    predefinedMessageController.getCategory();
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
                GestureDetector(
                  onTap: (){
                    Get.offNamed('/ask_question_profile_screen',arguments: {
                      "price": controller.perQuestionPrice,
                      "uniId": controller.userUniId,
                      "type" : "add",
                      "id" : ""
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Column(
                      children: [
                        Container(
                            width: 35,
                            height: 35,
                            padding: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorResources.colorPrimary,),
                              borderRadius: BorderRadius.circular(50),
                              color: ColorResources.colorPrimaryLight,
                            ),
                            child: const Center(child: Icon(Icons.add))
                        ),
                        SizedBox(
                          width: 55,
                          child: CustomTextMedium(
                            "Add",
                            textAlign: TextAlign.center,
                            color: ColorResources.toolbarText,
                            fontSize: Dimensions.fontSizeSmall,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                      () {
                    if (controller.isProfileListSuccess.isTrue) {
                      selectedIndex = controller.aiProfileListData.indexWhere((item) => item.isSelected?.value == 1);
                      return  Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.aiProfileListData.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () async {
                                    if(selectedIndex != index){
                                      controller.askingForName.value = controller.aiProfileListData[index].isSelfProfile == 1 ? "Yourself" : controller.aiProfileListData[index].name.toString();
                                      selectedIndex = index;
                                      controller.selectProfiles(controller.aiProfileListData[index].id.toString());
                                      toggleSelection(index);
                                    }
                                  },
                                  child: QuestionProfileWidget(item: controller.aiProfileListData[index],
                                    onEditSelected:(){
                                      Get.offNamed('/ask_question_profile_screen',arguments: {
                                        "price": controller.perQuestionPrice,
                                        "uniId": controller.userUniId,
                                        "type" : "edit",
                                        "id" : controller.aiProfileListData[index].id.toString()
                                      });
                                    },
                                  ));
                            },
                          ),
                        ),
                      );
                    } else if (controller.isProfileListLoading.isTrue) {
                      return const CustomProgressIndicator();
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
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
              Container(
                  width: Get.width,
                  color: ColorResources.colorPrimaryLight,
                  child: Obx(() => CustomTextRegular("Asking for ${controller.askingForName.value}",textAlign: TextAlign.center,))),
              Obx(() => Visibility(
                  visible: controller.isChatHistoryLoading.isTrue,
                  child: const Text("Loading.."))),
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
                                  return QuestionTextWidget(message, controller.userUniId,isLastMessage: index == 0,);
                                } else if (message.message != null && message.message.toString().isNotEmpty && message.message.toString() != "" && message.message.toString() != "{\"message\": \"Internal server error\"}" && message.message.toString() != '{"status":402,"response":"out of api calls - renew subscription"}' && message.messageType == AppConstants.questionTypeSvg ) {
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
                          right: 0,
                          left: 0,
                          top: 10,
                          child: GestureDetector(
                            onTap: () {
                              predefinedMessageController.showPredefinedMessagesBottomSheet(context, onItemSelected: (int index){
                                controller.questionPurchase(predefinedMessageController.predefinedMessageList[index].message.toString());
                                // controller.getCalculation(
                                //     predefinedMessageController.predefinedMessageList[index].message.toString(),
                                //     1, "Open"
                                // );
                              });

                            },

                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    color: ColorResources.colorSecondaryDark,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Row(
                                    children: [
                                      CustomTextMedium(
                                        AppStrings.suggestions.tr,
                                        color: ColorResources.toolbarText,
                                      ),
                                      const Gap(5),
                                      Image.asset(Images.icWrite,height: 25,width: 25),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10,right: 10),
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    color: ColorResources.grey,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: [
                    Expanded(child:Obx(() {
                      if (dashboardController.isBalanceSuccess.value && controller.isCalculationSuccess.value) {
                        questionLeft.value = dashboardController.walletBalance / double.parse(controller.perQuestionPrice.toString());
                        return Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(color: questionLeft.value.toInt() > 1  ? ColorResources.green : ColorResources.red,width: 4),
                                shape: BoxShape.circle
                              ),
                              child: const Text(""),
                            ),
                            const Gap(5),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextMedium("${questionLeft.toInt()} Question left"),
                                if (controller.questionCalculation.data!.openAiPredictionActualPrice! > 0) ...[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomTextMedium("${configController.currencySymbol} ${controller.questionCalculation.data!.openAiPredictionActualPrice.toString()} Per Question" ,fontSize: Dimensions.fontSizeSmall,color: ColorResources.black2,lineThrough: true,),
                                      if(controller.questionCalculation.data!.openAiPredictionPrice! > 0)
                                        CustomTextMedium("${configController.currencySymbol} ${controller.questionCalculation.data!.openAiPredictionPrice.toString()} Per Question",fontSize: Dimensions.fontSizeSmall,color: Colors.red,),

                                      if(controller.questionCalculation.data!.openAiPredictionPrice == 0)
                                        CustomTextMedium("FREE (${controller.questionCalculation.data!.remainingOfferCount} Question Left)",fontSize: Dimensions.fontSizeSmall,color: Colors.red,),
                                    ],
                                  )
                                ] else ...[
                                  CustomTextMedium("${configController.currencySymbol} ${controller.questionCalculation.data!.openAiPredictionPrice.toString()} Per Question",fontSize: Dimensions.fontSizeSmall,color: ColorResources.black2,),
                                ],
                              ],
                            ),
                          ],
                        );
                      } else {
                        return const Text('Loading...', style: TextStyle(fontSize: 14,color: ColorResources.black3));
                      }
                    }),),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed("/wallet");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                            color: ColorResources.colorPrimaryMedium,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: CustomTextMedium("Buy More Questions",color: ColorResources.toolbarText,),
                      ),
                    )
                  ],
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
                      const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          const Gap(12),
                          Flexible(
                              child: TextField(
                                controller: controller.messageController,
                                maxLength: 250,
                                maxLines: 3,
                                minLines: 1,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: ColorResources.black),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Ask your question..'),
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                if (controller.messageController.text.isNotEmpty) {
                                  controller.questionPurchase(controller.messageController.text.toString());
                                 // controller.getCalculation(controller.messageController.text.toString(), 1, "Open");
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

  void toggleSelection(int index) {
    for (var i = 0; i < controller.aiProfileListData.length; i++) {
      controller.aiProfileListData[i].isSelected?.value = (i == index) ? 1 : 0;
    }
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
