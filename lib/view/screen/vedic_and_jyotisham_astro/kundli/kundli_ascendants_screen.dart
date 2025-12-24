import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';

import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';

import '../controller/kundli_controller.dart';
import '../model/kundli_ascendants_model.dart';
import '../model/vedic_data.dart';
import '../widget/custom_table_two_row_widget.dart';

class KundliAscendantsScreen extends StatelessWidget {
  final KundliData data;
  KundliAscendantsScreen(this.data, {super.key});

  final KundliController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getAscendants(data);
    return  Obx(
          () {
        if (controller.isAscendantsLoading.value) {
          return  ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const SimmerListView();
            },
          );
        } else if (controller.ascendantsModel.status == 200) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextMedium(AppStrings.ascendantDetails.tr,fontSize: Dimensions.fontSizeLarge,),
                    ],
                  ),
                  const Gap(Dimensions.gapDefault),
                  Container(
                    decoration:  BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        // Assuming ascendantsModel.response is a list, iterate through it
                        for (KundliAscendantResponse item in controller.ascendantsModel.response!)
                          CustomTableTwoRowWidget(
                            title: AppStrings.ascendant.tr,
                            data: "${item.ascendant}",
                            color: ColorResources.colorPrimaryLight,
                          ),
                        for (KundliAscendantResponse item in controller.ascendantsModel.response!)
                          CustomTableTwoRowWidget(
                            title: AppStrings.ascendantLord.tr,
                            data: "${item.ascendantLord}",
                            color: ColorResources.colorTableRow,
                          ),
                        for (KundliAscendantResponse item in controller.ascendantsModel.response!)
                          CustomTableTwoRowWidget(
                            title: AppStrings.ascendantLocation.tr,
                            data: "${item.ascendantLordLocation}",
                            color: ColorResources.colorPrimaryLight,
                          ),
                        for (KundliAscendantResponse item in controller.ascendantsModel.response!)
                          CustomTableTwoRowWidget(
                            title: AppStrings.ascendantHomeLocation.tr,
                            data: "${item.ascendantLordHouseLocation}",
                            color: ColorResources.colorTableRow,
                          ),
                        for (KundliAscendantResponse item in controller.ascendantsModel.response!)
                          CustomTableTwoRowWidget(
                            title: AppStrings.generalPrediction.tr,
                            data: "${item.generalPrediction}",
                            color: ColorResources.colorPrimaryLight,
                          ),
                        for (KundliAscendantResponse item in controller.ascendantsModel.response!)
                          CustomTableTwoRowWidget(
                            title: AppStrings.personalisedPrediction.tr,
                            data: "${item.personalisedPrediction}",
                            color: ColorResources.colorTableRow,
                          ),
                        for (KundliAscendantResponse item in controller.ascendantsModel.response!)
                          CustomTableTwoRowWidget(
                            title: AppStrings.verbalLocation.tr,
                            data: "${item.verbalLocation}",
                            color: ColorResources.colorPrimaryLight,
                          ),
                        for (KundliAscendantResponse item in controller.ascendantsModel.response!)
                          CustomTableTwoRowWidget(
                            title: AppStrings.ascendantStrength.tr,
                            data: "${item.ascendantLordStrength}",
                            color: ColorResources.colorTableRow,
                          ),
                        for (KundliAscendantResponse item in controller.ascendantsModel.response!)
                          CustomTableTwoRowWidget(
                            title: AppStrings.symbol.tr,
                            data: "${item.symbol}",
                            color: ColorResources.colorPrimaryLight,
                          ),
                        for (KundliAscendantResponse item in controller.ascendantsModel.response!)
                          CustomTableTwoRowWidget(
                            title: AppStrings.zodiacCharacteristics.tr,
                            data: "${item.zodiacCharacteristics}",
                            color: ColorResources.colorTableRow,
                          ),
                        for (KundliAscendantResponse item in controller.ascendantsModel.response!)
                          CustomTableTwoRowWidget(
                            title: AppStrings.luckyGem.tr,
                            data: "${item.luckyGem}",
                            color: ColorResources.colorPrimaryLight,
                          ),
                        for (KundliAscendantResponse item in controller.ascendantsModel.response!)
                          CustomTableTwoRowWidget(
                            title: AppStrings.badQualities.tr,
                            data: "${item.badQualities}",
                            color: ColorResources.colorTableRow,
                          ),
                        for (KundliAscendantResponse item in controller.ascendantsModel.response!)
                          CustomTableTwoRowWidget(
                            title: AppStrings.dayForFasting.tr,
                            data: "${item.dayForFasting}",
                            color: ColorResources.colorPrimaryLight,
                          ),
                        for (KundliAscendantResponse item in controller.ascendantsModel.response!)
                          CustomTableTwoRowWidget(
                            title: AppStrings.gayatriMantra.tr,
                            data: "${item.gayatriMantra}",
                            color: ColorResources.colorTableRow,
                          ),
                        for (KundliAscendantResponse item in controller.ascendantsModel.response!)
                          CustomTableTwoRowWidget(
                            title: AppStrings.flagshipQualities.tr,
                            data: "${item.flagshipQualities}",
                            color: ColorResources.colorPrimaryLight,
                          ),
                        for (KundliAscendantResponse item in controller.ascendantsModel.response!)
                          CustomTableTwoRowWidget(
                            title: AppStrings.spiritualityAdvice.tr,
                            data: "${item.spiritualityAdvice}",
                            color: ColorResources.colorTableRow,
                          ),
                        for (KundliAscendantResponse item in controller.ascendantsModel.response!)
                          CustomTableTwoRowWidget(
                            title: AppStrings.goodQualities.tr,
                            data: "${item.goodQualities}",
                            color: ColorResources.colorPrimaryLight,
                          ),
                      ],
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                ],
              ),
            ),
          );
        } else {
          return const EmptyScreen();
        }
      },
    );
  }
}