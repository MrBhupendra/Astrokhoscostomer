import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/view/screen/subscription/controller/subscription_controller.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:astro_brahmand/view/widget/custom_text_bold.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../widget/custom_empty_screen.dart';

import '../../widget/simmer_widget/simmer_subscription_container.dart';

class SubscriptionPurchaseListScreen extends GetView<SubscriptionController> {
  const SubscriptionPurchaseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getSubscriptionPurchaseList();
    dynamic arguments = Get.arguments;
    String type = '';

    if (arguments is Map<String, dynamic>) {
      type = arguments['type'] ?? '';
    }


    return PopScope(
        onPopInvoked: (bool isPopGesture) {
          if (!isPopGesture) {
            if (Get.key.currentState?.canPop() ?? false) {
              Get.back();
            } else {
              Get.offAllNamed('/dashboard');
            }
          }
        },

        canPop: false,
        child:  SafeArea(
          child: Scaffold(
            appBar: CustomAppBar(title: "Subscription Purchase List" ,onBackPressed: (){
              if (type == "payScreen") {
                print("payScreen => $type");
                Get.offAllNamed('/dashboard');
              } else {
                Get.back();
              }
            }),
            body: Obx((){
              if(controller.isSubscriptionPurchaseListSuccess.isTrue){
                return ListView.builder(
                  itemCount: controller.subscriptionPurchaseModel.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color:ColorResources.colorChart,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 3.0,
                                spreadRadius: 1,
                                offset: const Offset(0, 2),
                              ),
                            ]
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: ColorResources.colorPrimaryLight,
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomLeft: Radius.circular(10))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomTextMedium("${controller.subscriptionPurchaseModel.data![index].subscriptionStatus}"),
                                  ),
                                )
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  CustomTextBold("${controller.subscriptionPurchaseModel.data?[index].title.toString()}",
                                    color: ColorResources.colorPrimary,
                                    fontSize: 16,
                                  ),
                                  const Gap(Dimensions.gapDefault),
                                  Row(
                                    children: [
                                      Expanded(child: CustomTextMedium("Validity",fontSize: 16,)),
                                      CustomTextMedium("${controller.subscriptionPurchaseModel.data![index].validityInDays.toString()} Days"),
                                    ],
                                  ),
                                  const Gap(Dimensions.gapDefault),
                                  const Divider(
                                    color: ColorResources.black,
                                    thickness: 0.5,
                                  ),
                                  const Gap(Dimensions.gapDefault),
                                  Row(
                                    children: [
                                      Expanded(child: CustomTextMedium("Start Date",fontSize: 16,)),
                                      CustomTextMedium(controller.subscriptionPurchaseModel.data![index].startDateTime.toString()),
                                    ],
                                  ),
                                  const Gap(Dimensions.gapExtraSmall),
                                  Row(
                                    children: [
                                      Expanded(child: CustomTextMedium("End Date",fontSize: 16,)),
                                      CustomTextMedium(controller.subscriptionPurchaseModel.data![index].endDateTime.toString()),
                                    ],
                                  ),
                                  const Gap(Dimensions.gapDefault),
                                  const Divider(
                                    color: ColorResources.black,
                                    thickness: 0.5,
                                  ),
                                  const Gap(Dimensions.gapDefault),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(child: CustomTextMedium("Video Call",fontSize: 16,)),
                                      CustomTextMedium("${controller.subscriptionPurchaseModel.data![index].videoCallDuration}/",fontSize: 17,),
                                      CustomTextMedium("${controller.subscriptionPurchaseModel.data![index].remainVideoCallDuration} min",color: ColorResources.red,),
                                    ],
                                  ),
                                  const Gap(Dimensions.gapExtraSmall),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(child: CustomTextMedium("Voice Call",fontSize: 16,)),
                                      CustomTextMedium("${controller.subscriptionPurchaseModel.data![index].voiceCallDuration}/",fontSize: 17,),
                                      CustomTextMedium("${controller.subscriptionPurchaseModel.data![index].remainVoiceCallDuration} min",color: ColorResources.red,),
                                    ],
                                  ),
                                  const Gap(Dimensions.gapExtraSmall),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(child: CustomTextMedium("Chat",fontSize: 16,)),
                                      CustomTextMedium("${controller.subscriptionPurchaseModel.data![index].chatDuration}/",fontSize: 17,),
                                      CustomTextMedium("${controller.subscriptionPurchaseModel.data?[index].remainChatDuration} min",color: ColorResources.red,),
                                    ],
                                  ),
                                  const Gap(Dimensions.gapDefault),

                                  const Divider(
                                    color: ColorResources.black,
                                    thickness: 0.5,
                                  ),
                                  const Gap(Dimensions.gapDefault),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(child: CustomTextMedium("Product Order",fontSize: 16,)),
                                      CustomTextMedium("${controller.subscriptionPurchaseModel.data![index].productOrderCount}/",fontSize: 17,),
                                      CustomTextMedium("${controller.subscriptionPurchaseModel.data![index].remainProductOrderCount} Order",color: ColorResources.red,),
                                    ],
                                  ),
                                  const Gap(Dimensions.gapExtraSmall),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(child: CustomTextMedium("Product Order Discount",fontSize: 16,)),
                                      CustomTextMedium("${controller.subscriptionPurchaseModel.data![index].productOrderDiscount}%",fontSize: 17,),
                                      // CustomTextMedium("${controller.subscriptionPurchaseModel.data![index].remainProductOrderDiscount}",color: ColorResources.red,),
                                    ],
                                  ),



                                  const Divider(
                                    color: ColorResources.black,
                                    thickness: 1.5,
                                  ),
                                  const Gap(Dimensions.gapExtraSmall),
                                  Row(
                                    children: [
                                      Expanded(child: CustomTextBold("Total",fontSize: 20,)),
                                      CustomTextBold("${AppConstants.defaultCurrencySymbol}${controller.subscriptionPurchaseModel.data![index].price}",
                                        fontSize: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },

                );
              } else if(controller.isSubscriptionPurchaseListLoading.isTrue){
                return const SimmerSubscriptionContainer();
              } else{
                return const EmptyScreen();
              }
            }),
          ),
        )
    );
  }
}
