import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_text_medium.dart';
import '../../splash/controller/config_controller.dart';

class HoroscopeTabScreen extends StatelessWidget {
   HoroscopeTabScreen({super.key});

  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {

    String? activeKundliApi = configController.config.data?.activeKundliApi.toString();


    if (activeKundliApi == AppConstants.jyotisham) {
      return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: AppStrings.horoscope.tr),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,horizontal: Dimensions.paddingSizeExtraSmall),
              child: Column(
                children: [
                  // const Gap(Dimensions.paddingSizeSmall),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed("/horoscopeDailyScreen");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              // offset: const Offset(0,2),
                            ),
                          ]
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMediumSmall,horizontal: Dimensions.paddingSizeSmall),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.borderRadiusRounded),
                                color: ColorResources.colorPrimaryLight,
                              ),
                              child: Image.asset(Images.dailyHoroscope,width:30,height: 30,),
                            ),
                            const Gap(10),
                            Expanded(
                              child: CustomTextMedium(AppStrings.dailyHoroscope.tr,fontSize: Dimensions.fontSizeLarge,color: ColorResources.colorText),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: Image.asset(Images.arrowNext,height: 22,color: ColorResources.colorPrimaryDark),
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed("/horoscopeWeeklyScreen");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              // offset: const Offset(0,2),
                            ),
                          ]
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMediumSmall,horizontal: Dimensions.paddingSizeSmall),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.borderRadiusRounded),
                                color: ColorResources.colorPrimaryLight,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                child: Image.asset(Images.weeklyHoroscope,width:30,height: 30,),
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: CustomTextMedium(AppStrings.weeklyHoroscope.tr,fontSize: Dimensions.fontSizeLarge,color: ColorResources.colorText),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: Image.asset(Images.arrowNext,height: 22,color: ColorResources.colorPrimaryDark),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed("/horoscopeMonthlyScreen");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              // offset: const Offset(0,2),
                            ),
                          ]
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMediumSmall,horizontal: Dimensions.paddingSizeSmall),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.borderRadiusRounded),
                                color: ColorResources.colorPrimaryLight,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                child: Image.asset(Images.monthalyHoroscope,width:30,height:30,),
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: CustomTextMedium(AppStrings.monthlyHoroscope.tr,fontSize: Dimensions.fontSizeLarge,color: ColorResources.colorText),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: Image.asset(Images.arrowNext,height: 22,color: ColorResources.colorPrimaryDark),
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed("/horoscopeYearlyScreen");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              // offset: const Offset(0,2),
                            ),
                          ]
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMediumSmall,horizontal: Dimensions.paddingSizeSmall),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.borderRadiusRounded),
                                color: ColorResources.colorPrimaryLight,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                child: Image.asset(Images.yearlyHoroscope,width:30,height:30,),
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: CustomTextMedium(AppStrings.yearlyHoroscope.tr,fontSize: Dimensions.fontSizeLarge,color: ColorResources.colorText),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: Image.asset(Images.arrowNext,height: 22,color: ColorResources.colorPrimaryDark),
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else if (activeKundliApi == AppConstants.vedicastro) {
      return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: AppStrings.horoscope.tr),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,horizontal: Dimensions.paddingSizeExtraSmall),
              child: Column(
                children: [
                  // const Gap(Dimensions.paddingSizeSmall),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed("/horoscopeDailyScreen");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              // offset: const Offset(0,2),
                            ),
                          ]
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMediumSmall,horizontal: Dimensions.paddingSizeSmall),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.borderRadiusRounded),
                                color: ColorResources.colorPrimaryLight,
                              ),
                              child: Image.asset(Images.dailyHoroscope,width:30,height: 30,),
                            ),
                            const Gap(10),
                            Expanded(
                              child: CustomTextMedium(AppStrings.dailyHoroscope.tr,fontSize: Dimensions.fontSizeLarge,color: ColorResources.colorText),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: Image.asset(Images.arrowNext,height: 22,color: ColorResources.colorPrimaryDark),
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed("/horoscopeWeeklyScreen");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              // offset: const Offset(0,2),
                            ),
                          ]
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMediumSmall,horizontal: Dimensions.paddingSizeSmall),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.borderRadiusRounded),
                                color: ColorResources.colorPrimaryLight,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                child: Image.asset(Images.weeklyHoroscope,width:30,height: 30,),
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: CustomTextMedium(AppStrings.weeklyHoroscope.tr,fontSize: Dimensions.fontSizeLarge,color: ColorResources.colorText),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: Image.asset(Images.arrowNext,height: 22,color: ColorResources.colorPrimaryDark),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed("/horoscopeYearlyScreen");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              // offset: const Offset(0,2),
                            ),
                          ]
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMediumSmall,horizontal: Dimensions.paddingSizeSmall),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.borderRadiusRounded),
                                color: ColorResources.colorPrimaryLight,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                child: Image.asset(Images.yearlyHoroscope,width:30,height:30,),
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: CustomTextMedium(AppStrings.yearlyHoroscope.tr,fontSize: Dimensions.fontSizeLarge,color: ColorResources.colorText),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: Image.asset(Images.arrowNext,height: 22,color: ColorResources.colorPrimaryDark),
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    // Fallback Widget
    return const Center(
      child: Text('No valid API configuration found.'),
    );


  }
}
