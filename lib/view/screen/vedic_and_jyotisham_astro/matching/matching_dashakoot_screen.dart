import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../controller/matching_controller.dart';
import '../model/vedic_data.dart';
import '../widget/custom_matching_score.dart';
import '../widget/custom_table_row.dart';

class MatchingDashakootScreen extends StatelessWidget {
  KundliMatchData data;
  MatchingDashakootScreen(this.data ,{super.key});

  MatchingController  controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getDashakoot(data);
    return Obx(
      () {
        if (controller.isDashakootSuccess.isTrue) {
          return ListView(
            children:  [
              Padding(
                padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall,top:Dimensions.paddingSizeDefault),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomTextMedium(AppStrings.dashakootMatchingPoint.tr,fontSize: Dimensions.fontSizeLarge,),
                  ],
                ),
              ),
              const Gap(Dimensions.gapExtraExtraLarge),
              CustomMatchingScore(score: '${controller.dashakootModel.response?.score}/${AppConstants.dashakootscore}'),
              Padding(
                padding: const EdgeInsets.only(left: Dimensions.fontSizeSmall,right:Dimensions.fontSizeExtraSmall,top:Dimensions.fontSizeExtraSmall),
                child: CustomTextRegular('${controller.dashakootModel.response?.botResponse}',fontSize: Dimensions.fontSizeSmall,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: Dimensions.fontSizeFifteen,right:Dimensions.paddingSizeOverLarge),
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorResources.colorPrimaryVariant,// Set your desired background color
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.borderRadiusRounded),
                      bottomRight: Radius.circular(Dimensions.borderRadiusRounded),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: Dimensions.fontSizeSmall,bottom: Dimensions.fontSizeSmall,left:Dimensions.paddingSizeThirtyFive),
                    child: CustomTextMedium(
                        AppStrings.astroDetails.tr,
                        fontSize: Dimensions.fontSizeLarge,
                      color: ColorResources.toolbarText,
                    ),
                  ),

                ),
              ),
              Padding (
                padding: const EdgeInsets.only(top: Dimensions.fontSizeFifteen,left:Dimensions.fontSizeSmall,right:Dimensions.fontSizeFifteen),
                child: Column(
                  children: [
                    CustomTableRowRadius(
                        title: AppStrings.name.tr,
                        boy: data.boyName,
                        girl: data.girlName,
                        color: ColorResources.colorPrimary
                    ),
                    CustomTableRow(
                        title: AppStrings.gana.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.gana}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.gana}",
                        color: ColorResources.colorPrimaryLight
                    ),
                    CustomTableRow(
                        title: AppStrings.yoni.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.yoni}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.yoni}",
                        color: ColorResources.colorTableRow
                    ),
                    CustomTableRow(
                        title: AppStrings.vasya.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.vasya}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.vasya}",
                        color: ColorResources.colorPrimaryLight
                    ),
                    CustomTableRow(
                        title: AppStrings.nadi.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.nadi}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.nadi}",
                        color: ColorResources.colorTableRow
                    ),
                    CustomTableRow(
                        title: AppStrings.varna.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.varna}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.varna}",
                        color: ColorResources.colorPrimaryLight
                    ),
                    CustomTableRow(
                        title: AppStrings.paya.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.paya}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.paya}",
                        color: ColorResources.colorTableRow
                    ),
                    CustomTableRow(
                        title: AppStrings.tatva.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.tatva}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.tatva}",
                        color: ColorResources.colorPrimaryLight
                    ),
                    CustomTableRow(
                        title: AppStrings.birthDasha.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.birthDasa}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.birthDasa}",
                        color: ColorResources.colorTableRow
                    ),
                    CustomTableRow(
                        title: AppStrings.currentDasa.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.currentDasa}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.currentDasa}",
                        color: ColorResources.colorPrimaryLight
                    ),
                    CustomTableRow(
                        title: AppStrings.rasi.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.rasi}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.rasi}",
                        color: ColorResources.colorTableRow
                    ),
                    CustomTableRow(
                        title: AppStrings.birthDasaTime.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.birthDasaTime}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.birthDasaTime}",
                        color: ColorResources.colorPrimaryLight
                    ),
                    CustomTableRow(
                        title:AppStrings.currentDasaTime.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.currentDasaTime}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.currentDasaTime}",
                        color: ColorResources.colorTableRow
                    ),
                    CustomTableRow(
                        title:AppStrings.luckyGem.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.luckyGem}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.luckyGem}",
                        color: ColorResources.colorPrimaryLight
                    ),
                    CustomTableRow(
                        title: AppStrings.luckyNumber.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.luckyNum}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.luckyNum}",
                        color: ColorResources.colorTableRow
                    ),
                    CustomTableRow(
                        title: AppStrings.luckyColor.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.luckyColors}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.luckyColors}",
                        color: ColorResources.colorPrimaryLight
                    ),
                    CustomTableRow(
                        title:AppStrings.luckyLetter.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.luckyLetters}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.luckyLetters}",
                        color: ColorResources.colorTableRow
                    ),
                    CustomTableRow(
                        title: AppStrings.luckyNameStart.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.luckyNameStart}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.luckyNameStart}",
                        color: ColorResources.colorPrimaryLight
                    ),
                    CustomTableRow(
                        title: AppStrings.nakshatraPada.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.nakshatraPada}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.nakshatraPada}",
                        color: ColorResources.colorTableRow
                    ),
                    CustomTableRow(
                        title: AppStrings.ascendantSign.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.ascendantSign}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.ascendantSign}",
                        color: ColorResources.colorPrimaryLight
                    ),
                    CustomTableRowBottum(
                        title: AppStrings.nakshatra.tr,
                        boy: "${controller.dashakootModel.response?.boyAstroDetails?.nakshatra}",
                        girl: "${controller.dashakootModel.response?.girlAstroDetails?.nakshatra}",
                        color:ColorResources.colorTableRow
                    ),


                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:Dimensions.fontSizeFifteen,right:Dimensions.paddingSizeOverLarge),
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorResources.colorPrimaryVariant, // Set your desired background color
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.borderRadiusRounded),
                      bottomRight: Radius.circular(Dimensions.borderRadiusRounded),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top:Dimensions.paddingSizeSmall,bottom: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeThirtyFive),
                    child: CustomTextMedium(
                        AppStrings.gunaMilan.tr,
                        fontSize: Dimensions.fontSizeLarge,
                      color: ColorResources.toolbarText,
                    ),
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault,left:Dimensions.paddingSizeSmall,right: Dimensions.paddingSizeDefault),
                child: Column(
                  children: [
                    CustomTableRowRadius(
                        title: AppStrings.guna.tr,
                        boy: AppStrings.points.tr,
                        girl:AppStrings.description.tr,
                        color: ColorResources.colorPrimary
                    ),
                    CustomTableRow(
                        title: "${controller.dashakootModel.response?.dina?.name}",
                        boy: "${controller.dashakootModel.response?.dina?.dina}/${controller.dashakootModel.response?.dina?.fullScore}",
                        girl: "${controller.dashakootModel.response?.dina?.description}",
                        color: ColorResources.colorPrimaryLight
                    ),
                    CustomTableRow(
                        title: "${controller.dashakootModel.response?.gana?.name}",
                        boy: "${controller.dashakootModel.response?.gana?.gana}/${controller.dashakootModel.response?.gana?.fullScore}",
                        girl: "${controller.dashakootModel.response?.gana?.description}",
                        color: ColorResources.colorTableRow
                    ),
                    CustomTableRow(
                        title: "${controller.dashakootModel.response?.mahendra?.name}",
                        boy: "${controller.dashakootModel.response?.mahendra?.mahendra}/${controller.dashakootModel.response?.mahendra?.fullScore}",
                        girl: "${controller.dashakootModel.response?.mahendra?.description}",
                        color: ColorResources.colorPrimaryLight
                    ),
                    CustomTableRow(
                        title: "${controller.dashakootModel.response?.sthree?.name}",
                        boy: "${controller.dashakootModel.response?.sthree?.sthree}/${controller.dashakootModel.response?.sthree?.fullScore}",
                        girl: "${controller.dashakootModel.response?.sthree?.description}",
                        color: ColorResources.colorTableRow
                    ),
                    CustomTableRow(
                        title: "${controller.dashakootModel.response?.yoni?.name}",
                        boy: "${controller.dashakootModel.response?.yoni?.yoni}/${controller.dashakootModel.response?.yoni?.fullScore}",
                        girl: "${controller.dashakootModel.response?.yoni?.description}",
                        color:ColorResources.colorPrimaryLight
                    ),
                    CustomTableRow(
                        title: "${controller.dashakootModel.response?.rasi?.name}",
                        boy: "${controller.dashakootModel.response?.rasi?.rasi}/${controller.dashakootModel.response?.rasi?.fullScore}",
                        girl: "${controller.dashakootModel.response?.rasi?.description}",
                        color: ColorResources.colorTableRow
                    ),
                    CustomTableRow(
                        title: "${controller.dashakootModel.response?.rasiathi?.name}",
                        boy: "${controller.dashakootModel.response?.rasiathi?.rasiathi}/${controller.dashakootModel.response?.rasiathi?.fullScore}",
                        girl: "${controller.dashakootModel.response?.rasiathi?.description}",
                        color: ColorResources.colorPrimaryLight
                    ),
                    CustomTableRow(
                        title: "${controller.dashakootModel.response?.vasya?.name}",
                        boy: "${controller.dashakootModel.response?.vasya?.vasya}/${controller.dashakootModel.response?.vasya?.fullScore}",
                        girl: "${controller.dashakootModel.response?.vasya?.description}",
                        color: ColorResources.colorTableRow
                    ),
                    CustomTableRow(
                        title: "${controller.dashakootModel.response?.rajju?.name}",
                        boy: "${controller.dashakootModel.response?.rajju?.rajju}/${controller.dashakootModel.response?.rajju?.fullScore}",
                        girl: "${controller.dashakootModel.response?.rajju?.description}",
                        color: ColorResources.colorPrimaryLight
                    ),
                    CustomTableRowBottum(
                        title: "${controller.dashakootModel.response?.vedha?.name}",
                        boy: "${controller.dashakootModel.response?.vedha?.vedha}/${controller.dashakootModel.response?.vedha?.fullScore}",
                        girl: "${controller.dashakootModel.response?.vedha?.description}",
                        color: ColorResources.colorTableRow
                    ),
                  ],
                ),
              ),
              const Gap(10)
            ],
          );
        } else if (controller.isDashakootLoading.isTrue) {
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
    );
  }
}
