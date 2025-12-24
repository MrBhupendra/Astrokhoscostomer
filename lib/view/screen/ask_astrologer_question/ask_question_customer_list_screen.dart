import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_round_network_image.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../../widget/simmer_widget/simmer_list_view.dart';
import 'controller/ask_astrologer_question_controller.dart';

class AskQuestionCustomerListScreen extends GetView<AskAstrologerQuestionController> {
  const AskQuestionCustomerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getAskQuestionCustomerList(controller.offsetCount);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.askQuestionOrders.tr),
        body: Obx(
              () {
            if (controller.isQueListSuccess.isTrue) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 0),
                child: Column(
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await controller.getAskQuestionCustomerList(controller.offsetCount);
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                          itemCount: controller.askQuestionCustomerListData.length,
                          controller: controller.scrollController,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomRoundNetworkImage(
                                            imageUrl: controller.askQuestionCustomerListData[index].astroImg.toString(),
                                            height: 35,
                                            width: 35
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomTextMedium(
                                                controller.askQuestionCustomerListData[index].astrologerName.toString(),
                                                // color: ColorResources.black,
                                              ),
                                              CustomTextMedium(
                                                "Question: ${controller.askQuestionCustomerListData[index].question.toString()}",
                                                color: ColorResources.colorPrimaryDark,
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  CustomTextMedium("Answer: "),
                                                  const SizedBox(width: 10),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if(controller.askQuestionCustomerListData[index].answerStatus == 1){
                                                        controller.toggleExpanded(index); // Toggle the expanded state
                                                      }else{
                                                        CustomSnackBar.showBottom("Your answer is currently being processed and will be provided soon.\nआपका उत्तर वर्तमान में संसाधित किया जा रहा है और जल्द ही प्रदान किया जाएगा।");
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                                      decoration: BoxDecoration(
                                                        color: ColorResources.colorPrimary,
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Obx(() => CustomTextRegular(
                                                        controller.isExpanded(index)
                                                            ? "Hide"
                                                            : "Show",
                                                        color: ColorResources.toolbarText,
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Obx(
                                          () => controller.isExpanded(index)
                                          ? Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(width: 45), // Alignment with question text
                                            Expanded(
                                              child: CustomTextRegular(
                                                controller.askQuestionCustomerListData[index].answer.toString(),
                                                color: ColorResources.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                          : const SizedBox.shrink(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // const Gap(8),
                    Obx(
                          () => Visibility(
                        visible: controller.isQueListLoading.isTrue,
                        child: CustomTextRegular('Loading...'),
                      ),
                    )
                  ],
                ),
              );
            } else if (controller.isQueListLoading.isTrue) {
              return ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
    );
  }
}
