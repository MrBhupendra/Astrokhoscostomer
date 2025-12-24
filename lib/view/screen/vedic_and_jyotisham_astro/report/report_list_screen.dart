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
import '../../../widget/custom_text_regular.dart';

class ReportListScreen extends StatelessWidget {
  const ReportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.report.tr),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeExtraSmall,
                horizontal: Dimensions.paddingSizeExtraSmall),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/report_order_list");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                      border: Border.all(color: ColorResources.colorPrimary),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeMediumSmall,
                          horizontal: Dimensions.paddingSizeSmall),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextMedium("My Report",
                              fontSize: Dimensions.fontSizeLarge,
                              color: ColorResources.colorPrimaryDark),
                        ],
                      ),
                    ),
                  ),
                ),
                const Gap(Dimensions.paddingSizeSmall),
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/horo_report_submit");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorResources.white,
                      borderRadius:
                          BorderRadius.circular(Dimensions.borderRadiusSmall),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeMediumSmall,
                          horizontal: Dimensions.paddingSizeSmall),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeSmall),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.borderRadiusRounded),
                              color: ColorResources.colorPrimaryLight,
                            ),
                            child: Image.asset(Images.dashKundali,
                                width: 30, height: 30),
                          ),
                          const Gap(10),
                          Expanded(
                            child: CustomTextMedium(
                                AppConstants.horoscopePdf.tr,
                                fontSize: Dimensions.fontSizeLarge,
                                color: ColorResources.colorText),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.green),
                            ),
                            child: CustomTextRegular(
                                AppStrings.pay.tr,
                                // "${AppStrings.pay.tr} ${AppStrings.rupeeSign}${controller.horoscopePrice}",
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Gap(Dimensions.gapDefault),
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/matching_report_submit");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorResources.white,
                      borderRadius:
                          BorderRadius.circular(Dimensions.borderRadiusSmall),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeMediumSmall,
                          horizontal: Dimensions.paddingSizeSmall),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeSmall),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.borderRadiusRounded),
                              color: ColorResources.colorPrimaryLight,
                            ),
                            child: Image.asset(Images.dashMatchMaking,
                                width: 30, height: 30),
                          ),
                          const Gap(10),
                          Expanded(
                            child: CustomTextMedium(AppConstants.matchingPdf.tr,
                                fontSize: Dimensions.fontSizeLarge,
                                color: ColorResources.colorText),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.green),
                            ),
                            child: CustomTextRegular(
                                AppStrings.pay.tr,
                                // "${AppStrings.pay.tr} ${AppStrings.rupeeSign}${controller.matchingPrice.toString()}",
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     Get.toNamed("/matching_report_submit");
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: ColorResources.white,
                //       borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.2),
                //           spreadRadius: 1,
                //           blurRadius: 2,
                //         ),
                //       ],
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMediumSmall, horizontal: Dimensions.paddingSizeSmall),
                //       child: Row(
                //         children: [
                //           Container(
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(Dimensions.borderRadiusRounded),
                //               color: ColorResources.colorPrimaryLight,
                //             ),
                //             child: Padding(
                //               padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                //               child: Image.asset(Images.dashMatchMaking, width: 30, height: 30),
                //             ),
                //           ),
                //           const Gap(10),
                //           Expanded(
                //             child: CustomTextMedium(AppConstants.matchingPdf.tr, fontSize: Dimensions.fontSizeLarge, color: ColorResources.colorText),
                //           ),
                //           Container(
                //             padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(5.0),
                //               border: Border.all(color: Colors.green),
                //             ),
                //             child: CustomTextRegular(AppStrings.pay.tr, color: Colors.green),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
