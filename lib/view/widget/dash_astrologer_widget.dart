import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:astro_brahmand/view/widget/custom_round_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_bold.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:get/get.dart';

import '../../model/astrologer_model.dart';
import '../../utill/app_constants.dart';
import '../../utill/app_strings.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import '../screen/splash/controller/config_controller.dart';
import 'custom_text_medium.dart';

class DashAstrologerWidget extends StatelessWidget {
  AstrologerData astrologer;
  final Function? onActionPressed;

  DashAstrologerWidget(this.astrologer, {this.onActionPressed, super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    String chatRate = '**', callRate = '**', videoRate = '**';
    astrologer.prices?.forEach((priceItem) {
      String type = priceItem.type.toString();
      switch (type) {
        case AppConstants.chat:
          chatRate = priceItem.price.toString();
          break;
        case AppConstants.call:
          callRate = priceItem.price.toString();
          break;
        case AppConstants.video:
          videoRate = priceItem.price.toString();
          break;
      }
    });

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          if (onActionPressed != null) {
            onActionPressed!();
          }
        },
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: ColorResources.colorPrimaryLight,
            borderRadius: BorderRadius.circular(Dimensions.borderRadiusLarge),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6),
            child: Column(
              children: [
                // const Gap(Dimensions.gapSmall),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CustomRoundNetworkImage(
                      imageUrl: astrologer.astroImg.toString(),
                      height: Dimensions.profileImageHeightSmall,
                      width: Dimensions.profileImageHeightSmall
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: astrologer.onlineStatus == 1 &&
                                  astrologer.busyStatus == 1
                              ? Colors.yellow
                              : astrologer.onlineStatus == 1
                                  ? Colors.green
                                  : Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Text(
                          ' ',
                          style: TextStyle(
                              fontSize: 10, color: ColorResources.red),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(Dimensions.gapDefault),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CustomTextMedium(astrologer.displayName.toString(),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      fontSize: Dimensions.fontSizeLarge),
                ),
                CustomTextRegular("Exp: ${astrologer.experience} Years",
                    fontSize: Dimensions.fontSizeExtraSmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextRegular(astrologer.user!.avgRating.toString(),
                        fontSize: Dimensions.fontSizeExtraSmall),
                    const Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: ColorResources.colorRatingIcon,
                    ),
                  ],
                ),
                CustomTextBold(
                  "${configController.currencySymbol}$chatRate/Min.",
                  fontSize: Dimensions.fontSizeSmall,
                  maxLines: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
