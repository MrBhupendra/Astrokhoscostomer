import 'package:astro_brahmand/utill/app_fonts.dart';
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
import '../widget/custom_table_row.dart';

class MatchingAsthakootScreen extends StatelessWidget {
  final KundliMatchData data;

  const MatchingAsthakootScreen(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final MatchingController controller = Get.find();
    // Load data - controller will check if data has changed internally
    controller.getAsthakoot(data);

    return Obx(
      () {
        if (controller.isAsthakootSuccess.isTrue) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.paddingSizeSmall,
                    top: Dimensions.paddingSizeDefault),
                child: CustomTextMedium(
                  AppStrings.ashtakootMatchingPoint.tr,
                  fontSize: Dimensions.fontSizeLarge,
                  textAlign: TextAlign.left,
                ),
              ),
              const Gap(Dimensions.gapExtraExtraLarge),
              // Middle Section: Score with Circular Progress
              Column(
                children: [
                  // Circular Progress with Score
                  SizedBox(
                    width: 130,
                    height: 130,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background Circle
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            value: (controller.asthakootModel.response?.score ??
                                    0) /
                                AppConstants.ashtakootescore,
                            strokeWidth: 12,
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              ColorResources.colorPrimary,
                            ),
                          ),
                        ),
                        // Score Text
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${controller.asthakootModel.response?.score ?? 0}',
                              style: TextStyle(
                                fontSize: 48,
                                color: ColorResources.black2,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.euclidMedium,
                                fontFamilyFallback: AppFonts.fallback,
                              ),
                            ),
                            CustomTextRegular(
                              'Out of ${AppConstants.ashtakootescore}',
                              fontSize: Dimensions.fontSizeSmall,
                              color: ColorResources.black2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(Dimensions.gapMedium),
                ],
              ),
              const Gap(Dimensions.gapLarge),
              // Bottom Section: Astrologer's Verdict Card
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                ),
                child: Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title with Icon
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: ColorResources.colorPrimary,
                            size: 24,
                          ),
                          const Gap(8),
                          Text(
                            "Astrologer's Verdict",
                            style: TextStyle(
                              fontSize: Dimensions.fontSizeLarge,
                              color: ColorResources.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppFonts.euclidMedium,
                              fontFamilyFallback: AppFonts.fallback,
                            ),
                          ),
                        ],
                      ),
                      const Gap(Dimensions.gapSmall),
                      // Divider
                      Divider(
                        color: Colors.grey.withOpacity(0.5),
                        thickness: 1,
                      ),
                      const Gap(Dimensions.gapSmall),
                      // Verdict Text
                      CustomTextRegular(
                        controller.asthakootModel.response?.botResponse ?? '',
                        fontSize: Dimensions.fontSizeDefault,
                        color: ColorResources.black2,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimensions.paddingSizeDefault,
                    right: Dimensions.paddingSizeOverLarge),
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorResources.colorPrimaryVariant,
                    // Set your desired background color
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.borderRadiusRounded),
                      bottomRight:
                          Radius.circular(Dimensions.borderRadiusRounded),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: Dimensions.paddingSizeSmall,
                        bottom: Dimensions.paddingSizeSmall,
                        left: Dimensions.marginSizeOverLarge),
                    child: CustomTextMedium(
                      AppStrings.astroDetails.tr,
                      textAlign: TextAlign.start,
                      fontSize: Dimensions.fontSizeLarge,
                      color: ColorResources.toolbarText,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimensions.paddingSizeDefault,
                    left: Dimensions.paddingSizeSmall,
                    right: Dimensions.paddingSizeSmall),
                child: Column(
                  children: [
                    CustomTableRowRadius(
                        title: AppStrings.name.tr,
                        boy: data.boyName,
                        girl: data.girlName,
                        color: ColorResources.colorPrimary),
                    CustomTableRow(
                        title: AppStrings.gana.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.gana}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.gana}",
                        color: ColorResources.colorTableRowEven),
                    CustomTableRow(
                        title: AppStrings.yoni.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.yoni}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.yoni}",
                        color: ColorResources.colorTableRowOdd),
                    CustomTableRow(
                        title: AppStrings.vasya.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.vasya}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.vasya}",
                        color: ColorResources.colorTableRowEven),
                    CustomTableRow(
                        title: AppStrings.nadi.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.nadi}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.nadi}",
                        color: ColorResources.colorTableRowOdd),
                    CustomTableRow(
                        title: AppStrings.varna.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.varna}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.varna}",
                        color: ColorResources.colorTableRowEven),
                    CustomTableRow(
                        title: AppStrings.paya.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.paya}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.paya}",
                        color: ColorResources.colorTableRowOdd),
                    CustomTableRow(
                        title: AppStrings.tatva.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.tatva}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.tatva}",
                        color: ColorResources.colorTableRowEven),
                    CustomTableRow(
                        title: AppStrings.birthDasha.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.birthDasa}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.birthDasa}",
                        color: ColorResources.colorTableRowOdd),
                    CustomTableRow(
                        title: AppStrings.currentDasa.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.currentDasa}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.currentDasa}",
                        color: ColorResources.colorTableRowEven),
                    CustomTableRow(
                        title: AppStrings.rasi.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.rasi}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.rasi}",
                        color: ColorResources.colorTableRowOdd),
                    CustomTableRow(
                        title: AppStrings.birthDasaTime.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.birthDasaTime}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.birthDasaTime}",
                        color: ColorResources.colorTableRowEven),
                    CustomTableRow(
                        title: AppStrings.currentDasaTime.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.currentDasaTime}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.currentDasaTime}",
                        color: ColorResources.colorTableRowOdd),
                    CustomTableRow(
                        title: AppStrings.luckyGem.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.luckyGem}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.luckyGem}",
                        color: ColorResources.colorTableRowEven),
                    CustomTableRow(
                        title: AppStrings.luckyNumber.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.luckyNum}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.luckyNum}",
                        color: ColorResources.colorTableRowOdd),
                    CustomTableRow(
                        title: AppStrings.luckyColor.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.luckyColors}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.luckyColors}",
                        color: ColorResources.colorTableRowEven),
                    CustomTableRow(
                        title: AppStrings.luckyLetter.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.luckyLetters}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.luckyLetters}",
                        color: ColorResources.colorTableRowOdd),
                    CustomTableRow(
                        title: AppStrings.luckyNameStart.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.luckyNameStart}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.luckyNameStart}",
                        color: ColorResources.colorTableRowEven),
                    CustomTableRow(
                        title: AppStrings.nakshatraPada.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.nakshatraPada}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.nakshatraPada}",
                        color: ColorResources.colorTableRowOdd),
                    CustomTableRow(
                        title: AppStrings.ascendantSign.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.ascendantSign}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.ascendantSign}",
                        color: ColorResources.colorTableRowEven),
                    CustomTableRowBottum(
                        title: AppStrings.nakshatra.tr,
                        boy:
                            "${controller.asthakootModel.response?.boyAstroDetails?.nakshatra}",
                        girl:
                            "${controller.asthakootModel.response?.girlAstroDetails?.nakshatra}",
                        color: ColorResources.colorTableRowOdd),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                    top: Dimensions.paddingSizeSmall,
                    right: Dimensions.marginSizeAuth),
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorResources.colorPrimaryVariant,
                    // Set your desired background color
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.borderRadiusRounded),
                      bottomRight:
                          Radius.circular(Dimensions.borderRadiusRounded),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: Dimensions.paddingSizeSmall,
                        bottom: Dimensions.paddingSizeSmall,
                        left: Dimensions.marginSizeOverLarge),
                    child: CustomTextMedium(
                      AppStrings.gunaMilan.tr,
                      fontSize: Dimensions.fontSizeLarge,
                      color: ColorResources.toolbarText,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimensions.paddingSizeDefault,
                    left: Dimensions.paddingSizeDefault,
                    right: Dimensions.paddingSizeDefault),
                child: Column(
                  children: [
                    CustomTableRowRadius(
                        title: AppStrings.guna.tr,
                        boy: AppStrings.points.tr,
                        girl: AppStrings.description.tr,
                        color: ColorResources.colorPrimary),
                    CustomTableRow(
                        title:
                            "${controller.asthakootModel.response?.varna?.name}",
                        boy:
                            "${controller.asthakootModel.response?.varna?.varna}/${controller.asthakootModel.response?.varna?.fullScore}",
                        girl:
                            "${controller.asthakootModel.response?.varna?.description}",
                        color: ColorResources.colorTableRowEven),
                    CustomTableRow(
                        title:
                            "${controller.asthakootModel.response?.vasya?.name}",
                        boy:
                            "${controller.asthakootModel.response?.vasya?.vasya}/${controller.asthakootModel.response?.vasya?.fullScore}",
                        girl:
                            "${controller.asthakootModel.response?.vasya?.description}",
                        color: ColorResources.colorTableRowOdd),
                    CustomTableRow(
                        title:
                            "${controller.asthakootModel.response?.tara?.name}",
                        boy:
                            "${controller.asthakootModel.response?.tara?.tara}/${controller.asthakootModel.response?.tara?.fullScore}",
                        girl:
                            "${controller.asthakootModel.response?.tara?.description}",
                        color: ColorResources.colorTableRowEven),
                    CustomTableRow(
                        title:
                            "${controller.asthakootModel.response?.yoni?.name}",
                        boy:
                            "${controller.asthakootModel.response?.yoni?.yoni}/${controller.asthakootModel.response?.yoni?.fullScore}",
                        girl:
                            "${controller.asthakootModel.response?.yoni?.description}",
                        color: ColorResources.colorTableRowOdd),
                    CustomTableRow(
                        title:
                            "${controller.asthakootModel.response?.grahamaitri?.name}",
                        boy:
                            "${controller.asthakootModel.response?.grahamaitri?.grahamaitri}/${controller.asthakootModel.response?.grahamaitri?.fullScore}",
                        girl:
                            "${controller.asthakootModel.response?.grahamaitri?.description}",
                        color: ColorResources.colorTableRowEven),
                    CustomTableRow(
                        title:
                            "${controller.asthakootModel.response?.gana?.name}",
                        boy:
                            "${controller.asthakootModel.response?.gana?.gana}/6",
                        girl:
                            "${controller.asthakootModel.response?.gana?.description}",
                        color: ColorResources.colorTableRowOdd),
                    CustomTableRow(
                        title:
                            "${controller.asthakootModel.response?.bhakoot?.name}",
                        boy:
                            "${controller.asthakootModel.response?.bhakoot?.bhakoot}/${controller.asthakootModel.response?.bhakoot?.fullScore}",
                        girl:
                            "${controller.asthakootModel.response?.bhakoot?.description}",
                        color: ColorResources.colorTableRowEven),
                    CustomTableRowBottum(
                        title:
                            "${controller.asthakootModel.response?.nadi?.name}",
                        boy:
                            "${controller.asthakootModel.response?.nadi?.nadi}/${controller.asthakootModel.response?.nadi?.fullScore}",
                        girl:
                            "${controller.asthakootModel.response?.nadi?.description}",
                        color: ColorResources.colorTableRowOdd),
                  ],
                ),
              ),
              const Gap(10),
            ],
          );
        } else if (controller.isAsthakootLoading.isTrue) {
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
