import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/view/screen/subscription/controller/subscription_controller.dart';
import 'package:astro_brahmand/view/widget/custom_text_bold.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/simmer_widget/simmer_subscription_container.dart';


class SubscriptionListScreen extends GetView<SubscriptionController> {
  const SubscriptionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getSubscriptionList("","");
    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: AppStrings.subscriptionList,icon: Icons.history,onActionPressed:(){
            Get.toNamed("/subscription_purchase_list");
          },),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorResources.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 3.0,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (value) {
                      controller.searchSubscription(value);
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Search Subscription',
                      // hintStyle: TextStyle(color: ColorResources.colorPrimary),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          Images.search,
                          width: 18,
                          height: 18,
                          color: ColorResources.colorPrimary,
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx((){
                  if(controller.isSubscriptionSuccess.isTrue){
                    return ListView.builder(
                      itemCount: controller.subscriptionListModel.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorResources.colorChart,
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
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: CustomTextBold("${controller.subscriptionListModel.data?[index].title}",
                                          color: ColorResources.colorPrimary,
                                          fontSize: Dimensions.fontSizeOverLarge,
                                        ),
                                      ),
                                      CustomTextMedium("${AppConstants.defaultCurrencySymbol}${controller.subscriptionListModel.data?[index].price}",
                                        fontSize: Dimensions.fontSizeOverLarge,
                                      ),
                                    ],
                                  ),
                                  const Gap(Dimensions.gapDefault),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomTextBold("Subscription Duration"),
                                            CustomTextMedium("${controller.subscriptionListModel.data?[index].validityInDays} Days",
                                              color: ColorResources.colorPrimary,
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap:() async {
                                          bool isLogin = await SharedPreferencesHelper.getIsLogin();
                                          if (isLogin) {
                                            controller.getSubscriptionCalculation("${controller.subscriptionListModel.data?[index].id}","Open");
                                          } else {
                                            Get.toNamed('/login');
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: ColorResources.colorPrimary,
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
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal:12),
                                            child: CustomTextMedium("Get It Now",color: ColorResources.toolbarText,fontSize: 18,),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Gap(Dimensions.gapDefault),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomTextBold("Features",fontSize: 16,),
                                    ],
                                  ),
                                  const Gap(Dimensions.gapDefault),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: ColorResources.white,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.3),
                                                blurRadius: 3.0,
                                                spreadRadius: 1,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                CustomTextBold("Chat Duration", color: ColorResources.black,
                                                    fontSize: 9),
                                                CustomTextMedium("${controller.subscriptionListModel.data?[index].chatDuration} min",
                                                  color: ColorResources.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Gap(Dimensions.gapDefault),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: ColorResources.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              blurRadius: 3.0,
                                              spreadRadius: 1,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              CustomTextBold("Voice Call Duration",
                                                  color: ColorResources.black,
                                                  fontSize: 9),
                                              CustomTextMedium("${controller.subscriptionListModel.data?[index].voiceCallDuration} min",
                                                color: ColorResources.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Gap(Dimensions.gapDefault),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: ColorResources.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              blurRadius: 3.0,
                                              spreadRadius: 1,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              CustomTextBold("Video Call Duration",
                                                color: ColorResources.black,
                                                fontSize: 9,),
                                              CustomTextMedium("${controller.subscriptionListModel.data?[index].videoCallDuration} min",
                                                color: ColorResources.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(Dimensions.gapDefault),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: ColorResources.white,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.3),
                                                blurRadius: 3.0,
                                                spreadRadius: 1,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    CustomTextBold("Product Detail",
                                                      color: ColorResources.black,
                                                      fontSize: 13,),
                                                  ],
                                                ),
                                                const Gap(2),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        CustomTextBold("Product order count",
                                                          color: ColorResources.black5,
                                                          fontSize: 12,),
                                                        CustomTextBold("${controller.subscriptionListModel.data?[index].productOrderCount}",
                                                          color: ColorResources.colorPrimaryDark,
                                                          fontSize: 12,),
                                                      ],
                                                    ),
                                                    const Gap(30),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          CustomTextBold("Product order discount",
                                                            color: ColorResources.black5,
                                                            fontSize: 12,),
                                                          CustomTextBold("${controller.subscriptionListModel.data?[index].productOrderDiscount}%",
                                                            color: ColorResources.colorPrimaryDark,
                                                            fontSize: 12,),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(Dimensions.gapDefault),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if(controller.isSubscriptionLoading.isTrue){
                    return const SimmerSubscriptionContainer();
                  } else{
                    return const EmptyScreen();
                  }
                }),
              )
            ],
          ) ,
        )
    );
  }
}
