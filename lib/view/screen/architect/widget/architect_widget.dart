import 'package:astro_brahmand/utill/app_fonts.dart';
import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/widget/custom_box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/widget/custom_rating_icons.dart';
import 'package:astro_brahmand/view/widget/custom_round_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:get/get.dart';

import '../../../../model/astrologer_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/dimensions.dart';

class ArchitectWidget extends StatelessWidget {
  final AstrologerData astrologer;
  final Function? onPressed;

  const ArchitectWidget(this.astrologer, {this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    String homeComplete = '**', officeComplete = '**', industryComplete = '**', homeLayout = '**', officeLayout = '**', industryLayout = '**';
    String homeOld = '**', officeOld = '**', industryOld = '**';

    astrologer.prices?.forEach((priceItem) {
      String type = priceItem.type.toString();
      switch (type) {
        case AppConstants.homeComplete:
          homeComplete = priceItem.price.toString();
          break;
        case AppConstants.officeComplete:
          officeComplete = priceItem.price.toString();
          break;
        case AppConstants.industryComplete:
          industryComplete = priceItem.price.toString();
          break;
        case AppConstants.homeLayout:
          homeLayout = priceItem.price.toString();
          break;
        case AppConstants.officeLayout:
          officeLayout = priceItem.price.toString();
          break;
        case AppConstants.industryLayout:
          industryLayout = priceItem.price.toString();
          break;

        case AppConstants.homeOld:
          homeOld = priceItem.price.toString();
          break;
        case AppConstants.officeOld:
          officeOld = priceItem.price.toString();
          break;
        case AppConstants.industryOld:
          industryOld = priceItem.price.toString();
          break;
      }
    });

    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
        child: Container(
          decoration: CustomBoxDecoration.getDecoration(),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 6, top: 8, bottom: 8),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // const Gap(18),
                        CustomRoundNetworkImage(
                          imageUrl: astrologer.astroImg.toString(),
                          height: 70,
                          width: 70,
                        ),
                        const Gap(8),
                        CustomTextRegular(
                          astrologer.onlineStatus == 1 && astrologer.busyStatus == 1
                              ? "BUSY"
                              : astrologer.onlineStatus == 1
                              ? "ONLINE"
                              : "OFFLINE",
                          fontSize: Dimensions.fontSizeSmall,
                          color: astrologer.onlineStatus == 1 && astrologer.busyStatus == 1
                              ? ColorResources.orange
                              : astrologer.onlineStatus == 1
                              ? ColorResources.green
                              : ColorResources.red,
                        ),
                        const Gap(4),
                        CustomRatingIcons(
                          iconSize: Dimensions.iconSizeOverSmall,
                          rating: double.parse(astrologer.user!.avgRating.toString()),
                        ),
                      ],
                    ),
                    const Gap(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextMedium(
                            astrologer.displayName.toString(),
                            maxLines: 1,
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                          const Gap(2),
                          CustomTextRegular(
                            astrologer.categoryNames.toString(),
                            color: ColorResources.colorSecondaryDark,
                            fontSize: Dimensions.fontSizeSmall,
                          ),
                          const Gap(2),
                          CustomTextRegular(
                            astrologer.languageName.toString(),
                            maxLines: 2,
                            color: ColorResources.black2,
                            fontSize: Dimensions.fontSizeSmall,
                          ),
                          const Gap(2),
                          CustomTextRegular(
                            "Exp: ${astrologer.experience.toString()}+ years",
                            maxLines: 2,
                            color: ColorResources.black2,
                            fontSize: Dimensions.fontSizeSmall,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0,bottom: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: ColorResources.colorPrimary)
                                    // color: Colors.white,
                                  ),
                                  // child: CustomTextMedium(AppStrings.connect.tr, color: ColorResources.colorPrimary),
                                  child: Text(
                                    AppStrings.connect.tr,
                                    style: const TextStyle(
                                        color: ColorResources.colorPrimary,
                                    fontFamily: AppFonts.poppins,
                                    fontFamilyFallback: AppFonts.fallback,
                                  )),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
