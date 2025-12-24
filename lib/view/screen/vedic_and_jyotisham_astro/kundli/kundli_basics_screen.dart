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
import '../model/vedic_data.dart';
import '../widget/custom_table_two_row_widget.dart';

class KundliBasicsScreen extends StatelessWidget {
  final KundliData data;
  KundliBasicsScreen(this.data, {super.key});

  final KundliController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getAvakhada(data);
    return Obx(
          () {
        if (controller.isBasicsDetailsLoading.value) {
          return   ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const SimmerListView();
            },
          );
        } else if (controller.basicsDetailsModel.status == 200) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextMedium(AppStrings.kundliBasics.tr,color: ColorResources.black1,fontSize: Dimensions.fontSizeLarge,),
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
                        CustomTableTwoRowWidget(
                            title: "Name",
                            data: data.name,
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: "D.O.B",
                            data: data.dob,
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: "T.O.B",
                            data: data.tob,
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: "P.O.B",
                            data: data.place,
                            color: ColorResources.colorTableRow
                        ),
                      ],
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextMedium(AppStrings.kundliDetails.tr,color: ColorResources.black1,fontSize: Dimensions.fontSizeLarge,),
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
                        CustomTableTwoRowWidget(
                            title: AppStrings.nakshatraPada.tr,
                            data: "${controller.basicsDetailsModel.response?.nakshatraPada}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.gana.tr,
                            data: "${controller.basicsDetailsModel.response?.gana}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.nadi.tr,
                            data: "${controller.basicsDetailsModel.response?.nadi}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.nakshatra.tr,
                            data: "${controller.basicsDetailsModel.response?.nakshatra}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.nakshatraLord.tr,
                            data: "${controller.basicsDetailsModel.response?.nakshatraLord}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.singLord.tr,
                            data: "${controller.basicsDetailsModel.response?.rasiLord}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.tithi.tr,
                            data: "${controller.basicsDetailsModel.response?.tithi}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.varna.tr,
                            data: "${controller.basicsDetailsModel.response?.varna}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.vashya.tr,
                            data: "${controller.basicsDetailsModel.response?.vasya}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.yog.tr,
                            data: "${controller.basicsDetailsModel.response?.yoga}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.yoni.tr,
                            data: "${controller.basicsDetailsModel.response?.yoni}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.ascendants.tr,
                            data: "${controller.basicsDetailsModel.response?.ascendantSign}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.nameAlphabet.tr,
                            data: "${controller.basicsDetailsModel.response?.nameStart}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.paya.tr,
                            data: "${controller.basicsDetailsModel.response?.paya}",
                            color:ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.sunSing.tr,
                            data: "${controller.basicsDetailsModel.response?.sunSign}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.tatva.tr,
                            data: "${controller.basicsDetailsModel.response?.tatva}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.fortuneStone.tr,
                            data: "${controller.basicsDetailsModel.response?.fortuneStone}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.ascendantNakshatra.tr,
                            data: "${controller.basicsDetailsModel.response?.ascendantNakshatra}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.rasi.tr,
                            data: "${controller.basicsDetailsModel.response?.rasi}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.karana.tr,
                            data: "${controller.basicsDetailsModel.response?.karana}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.lifeStone.tr,
                            data: "${controller.basicsDetailsModel.response?.lifeStone}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.luckyStone.tr,
                            data: "${controller.basicsDetailsModel.response?.luckyStone}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.rasiLoard.tr,
                            data: "${controller.basicsDetailsModel.response?.rasiLord}",
                            color: ColorResources.colorPrimaryLight
                        ),

                      ],
                    ),
                  ),
                  const Gap(Dimensions.gapExtraSmall)
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