import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../../splash/controller/config_controller.dart';
import '../controller/kundli_controller.dart';
import '../model/vedic_data.dart';

class KundliRudrakshSuggestionScreen extends StatelessWidget {
  final KundliData data;
  KundliRudrakshSuggestionScreen(this.data,{super.key});

  final KundliController controller = Get.find();
  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getRudrakshSuggestion(data);

    String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

    if (activeKundliApi == AppConstants.jyotisham) {
      return Obx(() {
        if (controller.isRudrakshaSuggestionsSuccess.isTrue) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeDefault),
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
                  color: ColorResources.white,
                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault), // Adjust the radius as needed
                  border: Border.all(
                    color: ColorResources.colorPrimaryVariant,
                    width: 1, // Adjust the border width as needed
                  ),
                ),
                child:Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: ColorResources.colorPrimaryLight,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: Get.width * 0.5,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),topLeft: Radius.circular(10)),
                                      color: ColorResources.colorPrimary
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: CustomTextMedium("Purification",fontSize: Dimensions.fontSizeLarge,color: ColorResources.toolbarText,textAlign: TextAlign.center,),
                                  )
                              ),
                            ],
                          ),
                          const Gap(Dimensions.gapDefault),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: CustomTextRegular("${controller.rudrakshaSuggestionsModel.response?.purification}",),
                          ),
                        ],
                      )
                      ,
                    ),
                    const Gap(Dimensions.gapExtraLarge),
                    Container(
                      decoration: const BoxDecoration(
                        color: ColorResources.colorPrimaryLight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all( 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextMedium("Rudraksh - "),
                            const Gap(Dimensions.gapExtraSmall),
                            ListView.builder(
                                itemCount: controller.rudrakshaSuggestionsModel.response?.rudraksh?.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return CustomTextRegular(controller.rudrakshaSuggestionsModel.response!.rudraksh![index].toString());
                                }

                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(Dimensions.gapDefault),
                    Container(
                      decoration: const BoxDecoration(
                        color: ColorResources.colorPrimaryLight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextMedium("Name - "),
                            const Gap(Dimensions.gapExtraSmall),
                            ListView.builder(
                                itemCount: controller.rudrakshaSuggestionsModel.response?.name?.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return CustomTextRegular(controller.rudrakshaSuggestionsModel.response!.name![index].toString());
                                }

                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(Dimensions.gapDefault),
                    Container(
                      decoration: const BoxDecoration(
                        color: ColorResources.colorPrimaryLight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextMedium("Qualities - "),
                            const Gap(Dimensions.gapExtraSmall),
                            ListView.builder(
                                itemCount: controller.rudrakshaSuggestionsModel.response?.qualities?.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return CustomTextRegular(controller.rudrakshaSuggestionsModel.response!.qualities![index].toString());
                                }

                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(Dimensions.gapDefault),
                    Container(
                      decoration: const BoxDecoration(
                        color: ColorResources.colorPrimaryLight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextMedium("Mantra - "),
                            const Gap(Dimensions.gapExtraSmall),
                            ListView.builder(
                                itemCount: controller.rudrakshaSuggestionsModel.response?.mantra?.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return CustomTextRegular(controller.rudrakshaSuggestionsModel.response!.mantra![index].toString());
                                }

                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(Dimensions.gapDefault),
                    Container(
                      width: Get.width,
                      decoration: const BoxDecoration(
                        color: ColorResources.colorPrimaryLight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextMedium("How to wear - "),
                            const Gap(Dimensions.gapExtraSmall),
                            CustomTextRegular("${controller.rudrakshaSuggestionsModel.response?.howToWear}"),
                            const Gap(Dimensions.gapLarge),
                            CustomTextMedium("Time to wear - "),
                            const Gap(Dimensions.gapExtraSmall),
                            CustomTextRegular("${controller.rudrakshaSuggestionsModel.response?.timeToWear}"),
                          ],
                        ),
                      ),
                    ),
                    const Gap(Dimensions.gapExtraLarge),
                    Container(
                      decoration:  BoxDecoration(
                        color: ColorResources.colorPrimaryLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: CustomTextRegular("${controller.rudrakshaSuggestionsModel.response?.personalizedResponse}"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (controller.isRudrakshaSuggestionsLoading.isTrue) {
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
      });
    } else if (activeKundliApi == AppConstants.vedicastro) {
      return Obx(() {
        if (controller.isRudrakshaSuggestionsSuccess.isTrue) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeDefault),
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
                      color: ColorResources.white,
                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault), // Adjust the radius as needed
                      border: Border.all(
                        color: ColorResources.colorPrimaryVariant,
                        width: 1, // Adjust the border width as needed
                      ),
                    ),
                    child:Column(
                      children: [
                        const Gap(Dimensions.gapDefault),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child:
                            CustomTextMedium("${controller.kundliRudrakshaSuggestionsVedicAstroModel.response?.name}",fontSize: Dimensions.fontSizeExtraLarge,color: ColorResources.colorPrimary,textAlign: TextAlign.center,)
                            )
                          ],
                        ),
                        const Gap(Dimensions.gapExtraLarge),
                        Container(
                          decoration: const BoxDecoration(
                              color: ColorResources.colorPrimaryLight
                          ),
                          child: Column(
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: Get.width * 0.5,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(15)),
                                          color: ColorResources.colorPrimary
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        child: CustomTextMedium(AppStrings.mukhiDescription.tr,fontSize: Dimensions.fontSizeLarge,color: ColorResources.toolbarText,textAlign: TextAlign.center,),
                                      )
                                  ),
                                ],
                              ),
                              const Gap(Dimensions.gapDefault),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: CustomTextRegular("${controller.kundliRudrakshaSuggestionsVedicAstroModel.response?.mukhiDescription}",),
                              ),
                            ],
                          )
                          ,
                        ),
                        const Gap(Dimensions.gapExtraLarge),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                    color: ColorResources.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      CustomTextMedium(AppStrings.mukhiForDisease.tr),
                                      const Gap(Dimensions.gapDefault),
                                      CustomTextRegular("${controller.kundliRudrakshaSuggestionsVedicAstroModel.response?.mukhiForDiseaseCure}"),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(Dimensions.gapDefault),
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
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      CustomTextMedium(AppStrings.mukhiMoney.tr),
                                      const Gap(Dimensions.gapDefault),
                                      CustomTextRegular("${controller.kundliRudrakshaSuggestionsVedicAstroModel.response?.mukhiForMoney}"),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(Dimensions.gapExtraLarge),
                        Container(
                          decoration:  BoxDecoration(
                            color: ColorResources.colorPrimaryLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                            child: CustomTextRegular("${controller.kundliRudrakshaSuggestionsVedicAstroModel.response?.botResponse}"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (controller.isRudrakshaSuggestionsLoading.isTrue) {
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
      });
    }
    // Fallback Widget
    return const Center(
      child: Text('No valid API configuration found.'),
    );
  }

}
