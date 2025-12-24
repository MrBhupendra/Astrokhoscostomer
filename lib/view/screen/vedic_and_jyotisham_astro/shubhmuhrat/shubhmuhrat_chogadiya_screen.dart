import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../controller/shubhmuhrat_conttroller.dart';

class ChogadiyaScreen extends StatelessWidget {
   ChogadiyaScreen({super.key});

 final ShubhmuhratController controller = Get.put(ShubhmuhratController());

  @override
  Widget build(BuildContext context) {
    controller.getChoghadiya();
    return  Scaffold(
      body: SingleChildScrollView(
        child: Obx(
              () {
            if (controller.isChoghadiyaSuccess.isTrue) {
              return  Column(
                children: [
                  const Gap(Dimensions.gapDefault),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                          color: ColorResources.colorPrimary
                        ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraLarge,top: Dimensions.paddingSizeExtraSmall,bottom: Dimensions.paddingSizeExtraSmall,right: Dimensions.paddingSizeOverLarge),
                            child: CustomTextMedium(AppStrings.day.tr,color: ColorResources.toolbarText,fontSize: Dimensions.fontSizeLarge,),
                          )
                      ),
                    ],
                  ),
                   const Gap(Dimensions.gapDefault),
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: ListView.builder(
                      itemCount: controller.choghadiyaModel.response?.day?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              color: ColorResources.colorPrimaryLight,
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault), // Adjust the radius as needed
                              border: Border.all(
                                color: ColorResources.colorPrimary,
                                width: 1, // Adjust the border width as needed
                              ),
                            ),
                            child:  Padding(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: CustomTextMedium(controller.choghadiyaModel.response!.day![index].muhurat.toString(),fontSize: Dimensions.fontSizeExtraLarge,color: ColorResources.colorPrimaryDark)),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: ColorResources.colorPrimaryVariant,
                                          borderRadius: BorderRadius.circular(Dimensions.borderRadiusLarge), // Adjust the radius as needed
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(top:Dimensions.paddingSizeOverSmall,bottom: Dimensions.paddingSizeOverSmall,right: Dimensions.paddingSizeSmall,left:Dimensions.paddingSizeOverSmall),
                                          child: CustomTextMedium(controller.choghadiyaModel.response!.day![index].type.toString(),color: ColorResources.toolbarText,),
                                        ),
                                      )

                                    ],
                                  ),
                                  const Gap(Dimensions.gapDefault),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomTextMedium(AppStrings.startDate.tr,color: ColorResources.colorPrimary,),
                                            CustomTextRegular(controller.choghadiyaModel.response!.day![index].start.toString(),fontSize: Dimensions.fontSizeSmall),

                                          ],
                                        ),
                                      ),
                                      const Gap(Dimensions.gapDefault),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomTextMedium(AppStrings.endDate.tr,color: ColorResources.colorPrimary),
                                            CustomTextRegular(controller.choghadiyaModel.response!.day![index].end.toString(),fontSize: Dimensions.fontSizeSmall),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                              color: ColorResources.colorPrimary
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraLarge,top: Dimensions.paddingSizeExtraSmall,bottom: Dimensions.paddingSizeExtraSmall,right: Dimensions.paddingSizeOverLarge),
                            child: CustomTextMedium(AppStrings.night.tr,color: ColorResources.toolbarText,fontSize: Dimensions.fontSizeLarge,),
                          )
                      ),                    ],
                  ),
                  const Gap(Dimensions.gapDefault),
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: ListView.builder(
                        itemCount: controller.choghadiyaModel.response?.night?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: const Offset(0, 2),
                                        )
                                      ],
                                      color: ColorResources.colorPrimaryLight,
                                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault), // Adjust the radius as needed
                                      border: Border.all(
                                        color: ColorResources.colorPrimaryVariant,
                                        width: 1, // Adjust the border width as needed
                                      ),
                                    ),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(child: CustomTextMedium(controller.choghadiyaModel.response!.night![index].muhurat.toString(),fontSize: Dimensions.fontSizeLarge,color: ColorResources.colorPrimaryDark,)),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: ColorResources.colorPrimaryVariant,
                                                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusLarge), // Adjust the radius as needed
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top:Dimensions.paddingSizeOverSmall,bottom: Dimensions.paddingSizeOverSmall,right: Dimensions.paddingSizeSmall,left:Dimensions.paddingSizeOverSmall),
                                                  child: CustomTextMedium(controller.choghadiyaModel.response!.night![index].type.toString(),color: ColorResources.toolbarText,),
                                                ),
                                              )
                                            ],
                                          ),
                                          const Gap(Dimensions.gapDefault),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    CustomTextMedium(AppStrings.startDate.tr,color: ColorResources.colorPrimary),
                                                    CustomTextRegular(controller.choghadiyaModel.response!.night![index].start.toString(),fontSize: Dimensions.fontSizeSmall),

                                                  ],
                                                ),
                                              ),
                                              const Gap(Dimensions.gapDefault),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    CustomTextMedium(AppStrings.endDate.tr,color: ColorResources.colorPrimary,),
                                                    CustomTextRegular(controller.choghadiyaModel.response!.night![index].end.toString(),fontSize: Dimensions.fontSizeSmall),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const Gap(Dimensions.gapLarge),
                            ],
                          );
                        }
                    ),
                  ),
                ],
              );
            } else if (controller.isChoghadiyaLoading.isTrue) {
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
