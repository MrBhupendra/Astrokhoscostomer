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
  KundliGemsuggestionScreen(this.data, {super.key});

  final KundliController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getGemSuggestion(data);

    return SingleChildScrollView(
      child: Obx(() {
        if (controller.isGemSuggestionsLoading.isTrue) {
          return ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const SimmerListView();
            },
          );
        } else if (controller.isGemSuggestionsSuccess.isTrue) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: Dimensions.paddingSizeDefault),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            )
                          ],
                          color: ColorResources.colorTableRowEven,
                          borderRadius: BorderRadius.circular(
                              Dimensions.borderRadiusDefault),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.paddingSizeDefault),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextMedium(
                                AppStrings.name.tr,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                              const Gap(Dimensions.gapSmall),
                              CustomTextRegular(
                                "${controller.gemSuggestionsModel.response?.name}",
                                color: ColorResources.black2,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                              const Gap(Dimensions.gapDefault),
                              CustomTextMedium(
                                AppStrings.gem.tr,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                              const Gap(Dimensions.gapSmall),
                              CustomTextRegular(
                                "${controller.gemSuggestionsModel.response?.gem}",
                                color: ColorResources.black2,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(Dimensions.gapDefault),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            )
                          ],
                          color: ColorResources.colorPrimaryVariant,
                          borderRadius: BorderRadius.circular(
                              Dimensions.borderRadiusDefault),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.paddingSizeDefault),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextMedium(
                                AppStrings.planet.tr,
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                              const Gap(Dimensions.gapSmall),
                              CustomTextRegular(
                                "${controller.gemSuggestionsModel.response?.planet}",
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                              const Gap(Dimensions.gapDefault),
                              CustomTextMedium(
                                AppStrings.ortherName.tr,
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                              const Gap(Dimensions.gapSmall),
                              CustomTextRegular(
                                "${controller.gemSuggestionsModel.response?.otherName}",
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(Dimensions.gapLarge),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                    color: ColorResources.white,
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadiusDefault),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(Dimensions.borderRadiusDefault),
                            topRight:
                                Radius.circular(Dimensions.borderRadiusDefault),
                          ),
                          color: ColorResources.colorPrimary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.paddingSizeSmall,
                            horizontal: Dimensions.paddingSizeDefault,
                          ),
                          child: CustomTextMedium(
                            AppStrings.description.tr,
                            fontSize: Dimensions.fontSizeLarge,
                            color: ColorResources.toolbarText,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: CustomTextRegular(
                          "${controller.gemSuggestionsModel.response?.description}",
                          fontSize: Dimensions.fontSizeDefault,
                          color: ColorResources.black2,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(Dimensions.gapLarge),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                    color: ColorResources.white,
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadiusDefault),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextMedium(
                                AppStrings.finger.tr,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                              const Gap(Dimensions.gapDefault),
                              CustomTextMedium(
                                AppStrings.weight.tr,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                              const Gap(Dimensions.gapDefault),
                              CustomTextMedium(
                                "${AppStrings.day.tr}:",
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                              const Gap(Dimensions.gapDefault),
                              CustomTextMedium(
                                AppStrings.metal.tr,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                              const Gap(Dimensions.gapDefault),
                              CustomTextMedium(
                                AppStrings.key.tr,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                              const Gap(Dimensions.gapDefault),
                              CustomTextMedium(
                                AppStrings.mantra.tr,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                            ],
                          ),
                        ),
                        const Gap(Dimensions.gapDefault),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextRegular(
                                "${controller.gemSuggestionsModel.response?.finger}",
                                fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.black2,
                              ),
                              const Gap(Dimensions.gapDefault),
                              CustomTextRegular(
                                "${controller.gemSuggestionsModel.response?.weight}",
                                fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.black2,
                              ),
                              const Gap(Dimensions.gapDefault),
                              CustomTextRegular(
                                "${controller.gemSuggestionsModel.response?.day}",
                                fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.black2,
                              ),
                              const Gap(Dimensions.gapDefault),
                              CustomTextRegular(
                                "${controller.gemSuggestionsModel.response?.metal}",
                                fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.black2,
                              ),
                              const Gap(Dimensions.gapDefault),
                              CustomTextRegular(
                                "${controller.gemSuggestionsModel.response?.key}",
                                fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.black2,
                              ),
                              const Gap(Dimensions.gapDefault),
                              CustomTextRegular(
                                "${controller.gemSuggestionsModel.response?.mantra}",
                                fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.black2,
                              ),
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
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                    color: ColorResources.white,
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadiusDefault),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: controller.gemSuggestionsModel.response
                            ?.flawResults?.length ??
                        0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                          bottom: index ==
                                  (controller.gemSuggestionsModel.response
                                              ?.flawResults?.length ??
                                          1) -
                                      1
                              ? 0
                              : Dimensions.gapDefault,
                        ),
                        decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? ColorResources.colorTableRowEven
                              : ColorResources.colorTableRowOdd,
                          borderRadius: BorderRadius.circular(
                              Dimensions.borderRadiusSmall),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.paddingSizeDefault),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextMedium(
                                AppStrings.flawType.tr,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                              const Gap(Dimensions.gapSmall),
                              CustomTextRegular(
                                controller.gemSuggestionsModel.response!
                                    .flawResults![index].flawType
                                    .toString(),
                                fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.black2,
                              ),
                              const Gap(Dimensions.gapDefault),
                              CustomTextMedium(
                                AppStrings.flawEffects.tr,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                              const Gap(Dimensions.gapSmall),
                              CustomTextRegular(
                                controller.gemSuggestionsModel.response!
                                    .flawResults![index].flawEffects
                                    .toString(),
                                fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.black2,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Gap(Dimensions.gapLarge),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                    color: ColorResources.white,
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadiusDefault),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(Dimensions.borderRadiusDefault),
                            topRight:
                                Radius.circular(Dimensions.borderRadiusDefault),
                          ),
                          color: ColorResources.colorPrimary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.paddingSizeSmall,
                            horizontal: Dimensions.paddingSizeDefault,
                          ),
                          child: CustomTextMedium(
                            AppStrings.timeToWear.tr,
                            fontSize: Dimensions.fontSizeLarge,
                            color: ColorResources.toolbarText,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: CustomTextRegular(
                          "${controller.gemSuggestionsModel.response?.timeToWear}",
                          fontSize: Dimensions.fontSizeDefault,
                          color: ColorResources.black2,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(Dimensions.gapLarge),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                    color: ColorResources.white,
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadiusDefault),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(Dimensions.borderRadiusDefault),
                            topRight:
                                Radius.circular(Dimensions.borderRadiusDefault),
                          ),
                          color: ColorResources.colorPrimary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.paddingSizeSmall,
                            horizontal: Dimensions.paddingSizeDefault,
                          ),
                          child: CustomTextMedium(
                            AppStrings.methods.tr,
                            fontSize: Dimensions.fontSizeLarge,
                            color: ColorResources.toolbarText,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: CustomTextRegular(
                          "${controller.gemSuggestionsModel.response?.methods}",
                          fontSize: Dimensions.fontSizeDefault,
                          color: ColorResources.black2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const EmptyScreen();
        }
      }),
    );
  }
}
