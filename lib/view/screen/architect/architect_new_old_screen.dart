import 'package:astro_brahmand/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_service_button.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import 'controller/architect_controller.dart';

class ArchitectNewOldScreen extends GetView<ArchitectController> {
  const ArchitectNewOldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: AppStrings.vastuArchitect.tr),
          body: Column(
            children: [
              Expanded(child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          Images.architectBgBanner,
                          height: 160,
                          width: Get.width,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const Gap(20),
                      CustomTextMedium(
                        AppStrings.whoIsArchitect.tr,
                        maxLines: 1,
                        fontSize: Dimensions.fontSizeExtraLarge,
                      ),
                      const Gap(5),
                      CustomTextRegular(AppStrings.whoIsArchitectAns.tr,fontSize: Dimensions.fontSizeDefault,color: ColorResources.black2,),
                      const Gap(12),

                      CustomTextMedium(
                        AppStrings.whatIsNewMap.tr,
                        maxLines: 1,
                        fontSize: Dimensions.fontSizeExtraLarge,
                      ),
                      const Gap(5),
                      CustomTextRegular(AppStrings.whatIsNewMapAns.tr,fontSize: Dimensions.fontSizeDefault,color: ColorResources.black2,),
                      const Gap(12),

                      CustomTextMedium(
                        AppStrings.whatIsOldMap.tr,
                        maxLines: 1,
                        fontSize: Dimensions.fontSizeExtraLarge,
                      ),
                      const Gap(5),
                      CustomTextRegular(AppStrings.whatIsOldMapAns.tr,fontSize: Dimensions.fontSizeDefault,color: ColorResources.black2,),
                      const Gap(10),
                    ],
                  ),
                ),
              )),
              Container(
                color: ColorResources.white,
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeOverSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: CustomServiceButton(
                            onTap: () {
                              Get.toNamed('/architect_list_screen',arguments: {
                                "type" : "new"
                              });
                            },
                            service: 'New Map',
                            backgroundColor: ColorResources.colorPrimary,
                            textColor: ColorResources.toolbarText,
                          ),
                        ),
                      ),
                      const Gap(5),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0),
                          child: CustomServiceButton(
                            onTap: (){
                              showOldActionBottomSheet();
                            },
                            service: 'Old Map',
                            // servicePrice: callRate,
                            backgroundColor:
                            ColorResources.colorPrimary,
                            textColor: ColorResources.toolbarText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void showOldActionBottomSheet() {
    Get.bottomSheet(
      enableDrag: true,
        SafeArea(
          child: Container(
            color: ColorResources.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: CustomTextRegular("Analyze is your house following Vastu principles?",
                                fontSize: Dimensions.fontSizeLarge),
                          ),
                          const Gap(Dimensions.gapExtraSmall),
                          GestureDetector(
                            onTap: (){
                              Get.back(); //Close dialog
                              Get.toNamed("/zonal_chart");
                            },
                            child: Container(
                              width: Get.width,
                              padding: const EdgeInsets.only(top: 15, bottom: 15),
                              decoration: BoxDecoration(
                                color: ColorResources.colorPrimary, // Container color
                                borderRadius: BorderRadius.circular(8.0), // Radius value
                              ),
                              child: Column(
                                children: [
                                  CustomTextRegular(
                                    "Check Vastu Report",
                                    color: ColorResources.white,
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                                ],
                              ),),
                          ),
                          const Gap(Dimensions.gapExtraSmall),
                          const Divider(thickness: 1),
          
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: CustomTextRegular("Get expert architectural advice",
                                fontSize: Dimensions.fontSizeLarge),
                          ),
                          const Gap(Dimensions.gapExtraSmall),
                          GestureDetector(
                            onTap: (){
                              Get.back(); //Close dialog
                              Get.toNamed('/architect_list_screen',arguments: {
                                "type" : "old"
                              });
                            },
                            child: Container(
                              width: Get.width,
                              padding: const EdgeInsets.only(top: 15, bottom: 15),
                              decoration: BoxDecoration(
                                color: ColorResources.colorPrimary, // Container color
                                borderRadius: BorderRadius.circular(8.0), // Radius value
                              ),
                              child: Column(
                                children: [
                                  CustomTextRegular(
                                    "Proceed with Architect",
                                    color: ColorResources.white,
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                                ],
                              ),),
                          ),
                          const Gap(Dimensions.gapLarge),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
