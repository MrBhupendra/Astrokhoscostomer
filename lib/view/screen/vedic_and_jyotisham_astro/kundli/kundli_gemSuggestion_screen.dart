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
import '../controller/kundli_controller.dart';
import '../model/vedic_data.dart';

class KundliGemsuggestionScreen extends StatelessWidget {
  final KundliData data;
   KundliGemsuggestionScreen(this.data,{super.key});

  final KundliController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getGemSuggestion(data);

    return  SingleChildScrollView(
      child: Obx((){
        if(controller.isGemSuggestionsLoading.isTrue){
          return ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const SimmerListView();
            },
          );
        }else if(controller.isGemSuggestionsSuccess.isTrue){
          return  Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
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
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextMedium(AppStrings.name.tr),
                              CustomTextRegular("${controller.gemSuggestionsModel.response?.name}",color: ColorResources.black3,fontSize:13,),
                              const Gap(Dimensions.gapMedium),
                              CustomTextMedium(AppStrings.gem.tr),
                              CustomTextRegular("${controller.gemSuggestionsModel.response?.gem}",color: ColorResources.black3,fontSize: 13),

                            ],
                          ),
                        ) ,
                      ),
                    ),
                    Gap(Dimensions.gapExtraLarge),
                    Expanded(
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
                          color: ColorResources.black9,
                          borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault), // Adjust the radius as needed
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextMedium(AppStrings.planet.tr,color: ColorResources.white,),
                              CustomTextRegular("${controller.gemSuggestionsModel.response?.planet}",color:ColorResources.white,fontSize: 13,),
                              const Gap(Dimensions.gapMedium),
                              CustomTextMedium(AppStrings.ortherName.tr,color: ColorResources.white),
                              CustomTextRegular("${controller.gemSuggestionsModel.response?.otherName}",color: ColorResources.white,fontSize:13,),
                            ],
                          ),
                        ) ,
                      ),
                    ),
                  ],
                ),
                const Gap(Dimensions.gapLarge),
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
                    color: ColorResources.white,
                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault), // Adjust the radius as needed
                    // border: Border.all(
                    //   color: ColorResources.colorPrimaryVariant,
                    //   width: 1, // Adjust the border width as needed
                    // ),
                  ),
                  child: Container(
                    decoration:  BoxDecoration(
                        color: ColorResources.colorPrimaryLight,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                width: Get.width * 0.5,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),topLeft: Radius.circular(10)),
                                    color: ColorResources.colorPrimary
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: CustomTextMedium(AppStrings.description.tr,fontSize: Dimensions.fontSizeLarge,color: ColorResources.toolbarText,textAlign: TextAlign.center,),
                                )
                            ),
                          ],
                        ),
                        const Gap(Dimensions.gapDefault),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomTextRegular("${controller.gemSuggestionsModel.response?.description}",),
                        ),
                      ],
                    )
                    ,
                  ),
                ),
                // Container(
                //  decoration: BoxDecoration(
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.5),
                //         spreadRadius: 1,
                //         blurRadius: 2,
                //         offset: const Offset(0, 2),
                //       )
                //     ],
                //     color: ColorResources.white,
                //     borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault), // Adjust the radius as needed
                //     border: Border.all(
                //       color: ColorResources.colorPrimaryVariant,
                //       width: 1, // Adjust the border width as needed
                //     ),
                //   ),
                //   child: Container(
                //     decoration:  BoxDecoration(
                //         color: ColorResources.colorPrimaryLight,
                //         borderRadius: BorderRadius.circular(10)
                //     ),
                //     child: Column(
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.all(10),
                //           child: CustomTextRegular("${controller.gemSuggestionsModel.response?.goodResults}",),
                //         ),
                //       ],
                //     )
                //     ,
                //   ),
                // ),
                const Gap(Dimensions.gapLarge),
                Container(
                  width: Get.width,
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
                    // border: Border.all(
                    //   color: ColorResources.colorPrimaryVariant,
                    //   width: 1, // Adjust the border width as needed
                    // ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextMedium(AppStrings.finger.tr),
                            const Gap(Dimensions.gapDefault),
                            CustomTextMedium(AppStrings.weight.tr),
                            const Gap(Dimensions.gapDefault),
                            CustomTextMedium("${AppStrings.day.tr} -",),
                            const Gap(Dimensions.gapDefault),
                            CustomTextMedium(AppStrings.metal.tr,),
                            const Gap(Dimensions.gapDefault),
                            CustomTextMedium(AppStrings.key.tr,),
                            const Gap(Dimensions.gapDefault),
                            CustomTextMedium(AppStrings.mantra.tr,),
                            const Gap(Dimensions.gapDefault),
                          ],
                        ),
                        const Gap(Dimensions.gapDefault),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextRegular("${controller.gemSuggestionsModel.response?.finger}",),
                              const Gap(Dimensions.gapDefault),
                              CustomTextRegular("${controller.gemSuggestionsModel.response?.weight}",),
                              const Gap(Dimensions.gapDefault),
                              CustomTextRegular("${controller.gemSuggestionsModel.response?.day}",),
                              const Gap(Dimensions.gapDefault),
                              CustomTextRegular("${controller.gemSuggestionsModel.response?.metal}",),
                              const Gap(Dimensions.gapDefault),
                              CustomTextRegular("${controller.gemSuggestionsModel.response?.key}",),
                              const Gap(Dimensions.gapDefault),
                              CustomTextRegular("${controller.gemSuggestionsModel.response?.mantra}",),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(Dimensions.gapLarge),
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
                    color: ColorResources.white,

                    // border: Border.all(
                    //   color: ColorResources.colorPrimaryVariant,
                    //   width: 1, // Adjust the border width as needed
                    // ),
                  ),
                  child: ListView.builder(
                      itemCount: controller.gemSuggestionsModel.response?.flawResults?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              width: Get.width,
                              color: ColorResources.colorPrimaryLight,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextMedium(AppStrings.flawType.tr),
                                    CustomTextRegular(controller.gemSuggestionsModel.response!.flawResults![index].flawType.toString()),
                                    const Gap(Dimensions.gapExtraSmall),
                                    CustomTextMedium(AppStrings.flawEffects.tr),
                                    CustomTextRegular(controller.gemSuggestionsModel.response!.flawResults![index].flawEffects.toString()),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(Dimensions.gapExtraExtraLarge)
                          ],
                        );
                      }
                      ),
                ),
                const Gap(Dimensions.gapLarge),
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
                    color: ColorResources.white,
                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault), // Adjust the radius as needed
                    // border: Border.all(
                    //   color: ColorResources.colorPrimaryVariant,
                    //   width: 1, // Adjust the border width as needed
                    // ),
                  ),
                  child: Container(
                    decoration:  BoxDecoration(
                        color: ColorResources.colorPrimaryLight,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                width: Get.width * 0.5,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),topLeft: Radius.circular(10)),
                                    color: ColorResources.colorPrimary
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: CustomTextMedium(AppStrings.timeToWear.tr,fontSize: Dimensions.fontSizeLarge,color: ColorResources.toolbarText,textAlign: TextAlign.center,),
                                )
                            ),
                          ],
                        ),
                        const Gap(Dimensions.gapDefault),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomTextRegular("${controller.gemSuggestionsModel.response?.timeToWear}",),
                        ),
                      ],
                    )
                    ,
                  ),
                ),
                const Gap(Dimensions.gapLarge),
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
                    color: ColorResources.white,
                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault), // Adjust the radius as needed
                    // border: Border.all(
                    //   color: ColorResources.colorPrimaryVariant,
                    //   width: 1, // Adjust the border width as needed
                    // ),
                  ),
                  child: Container(
                    decoration:  BoxDecoration(
                        color: ColorResources.colorPrimaryLight,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                width: Get.width * 0.5,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),topLeft: Radius.circular(10)),
                                    color: ColorResources.colorPrimary
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: CustomTextMedium(AppStrings.methods.tr,fontSize: Dimensions.fontSizeLarge,color: ColorResources.toolbarText,textAlign: TextAlign.center,),
                                )
                            ),
                          ],
                        ),
                        const Gap(Dimensions.gapDefault),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomTextRegular("${controller.gemSuggestionsModel.response?.methods}",),
                        ),
                      ],
                    )
                    ,
                  ),
                ),

              ],
            ),
          );
        }else{
          return const EmptyScreen();
        }
      }),
    );
  }
}

