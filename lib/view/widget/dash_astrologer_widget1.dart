import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/view/widget/custom_round_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';

import '../../model/astrologer_model.dart';
import '../../utill/app_constants.dart';
import '../../utill/app_strings.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import '../screen/splash/controller/config_controller.dart';
import 'custom_text_medium.dart';
import 'custom_box_decoration.dart';

class DashAstrologerWidget1 extends StatelessWidget {
  AstrologerData astrologer;
  final Function? onActionPressed;

  DashAstrologerWidget1(this.astrologer, {this.onActionPressed, super.key});
  ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    String chatRate = '**', callRate = '**', videoRate = '**';

    astrologer.prices?.forEach((priceItem) {
      String type = priceItem.type.toString();
      String actualPrice = priceItem.actualPrice?.toString() ?? "";
      switch (type) {
        case AppConstants.chat:
          chatRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty
              ? "FREE"
              : actualPrice.isNotEmpty && double.tryParse(actualPrice) != null && double.parse(actualPrice) > 0
              ? "${configController.currencySymbol}$actualPrice${AppStrings.min} (${configController.currencySymbol}${priceItem.price.toString()}${AppStrings.min})".tr
              : "${configController.currencySymbol}${priceItem.price.toString()}${AppStrings.min}".tr;
          break;
        case AppConstants.call:
          callRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty
              ? "FREE"
              : actualPrice.isNotEmpty && double.tryParse(actualPrice) != null && double.parse(actualPrice) > 0
              ? "${configController.currencySymbol}$actualPrice${AppStrings.min} (${configController.currencySymbol}${priceItem.price.toString()}${AppStrings.min})".tr
              : "${configController.currencySymbol}${priceItem.price.toString()}${AppStrings.min}".tr;
          break;
        case AppConstants.video:
          videoRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty
              ? "FREE"
              : actualPrice.isNotEmpty && double.tryParse(actualPrice) != null && double.parse(actualPrice) > 0
              ? "${configController.currencySymbol}$actualPrice${AppStrings.min} (${configController.currencySymbol}${priceItem.price.toString()}${AppStrings.min})".tr
              : "${configController.currencySymbol}${priceItem.price.toString()}${AppStrings.min}".tr;
          break;
      }
    });

    /*astrologer.prices?.forEach((priceItem) {
      String type = priceItem.type.toString();
      switch (type) {
        case AppConstants.chat:
          chatRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty ? "FREE" : priceItem.price.toString();
          break;
        case AppConstants.call:
          callRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty ? "FREE" : priceItem.price.toString();
          break;
        case AppConstants.video:
          videoRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty ? "FREE" : priceItem.price.toString();
          break;
      }
    });*/ //Old code commented out due to Added Parameter Actual Price

    return Padding(
      padding: const EdgeInsets.only(right: 6.0,left: 4,top: 4,bottom: 4),
      child: GestureDetector(
        onTap: () {
          if (onActionPressed != null) {
            onActionPressed!();
          }
        },
        child: Container(
          width: 150,
          // decoration: BoxDecoration(
          //     color: ColorResources.white,
          //     borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
          //     border: Border.all(color: ColorResources.colorPrimary)),
          decoration: CustomBoxDecoration.getDecoration(),

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Gap(Dimensions.gapSmall),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: ColorResources.colorPrimary,width: Dimensions.profileBorderWidth),
                      ),
                      child: CustomRoundNetworkImage(
                        imageUrl: astrologer.astroImg.toString(),
                        height: 75,
                        width: 75
                      ),
                    ),
                    Positioned(
                      right: 6,
                      bottom: 2,
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
                // const Gap(Dimensions.gapDefault),

                const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 2.0, vertical: 2.0),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 2.0, vertical: 2.0),
                  child: CustomTextMedium(astrologer.displayName.toString(),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      fontSize: Dimensions.fontSizeSmall),
                ),
                if (chatRate != "FREE")
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (chatRate.contains("(")) ...[
                        Text(
                          chatRate.split(' ')[0],
                          style: TextStyle(
                            color: ColorResources.black,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: ColorResources.black,
                            fontSize: 11,
                          ),
                        ),

                        CustomTextMedium(
                          chatRate.split(' ')[1],
                          fontSize: Dimensions.fontSizeSmall,
                          maxLines: 1,
                        ),
                      ] else
                        CustomTextMedium(
                          chatRate,
                          fontSize: Dimensions.fontSizeSmall,
                          maxLines: 1,
                        ),
                    ],
                  ),
                /*CustomTextMedium(
                  "${configController.currencySymbol}$chatRate${AppStrings.min}".tr,
                  fontSize: Dimensions.fontSizeSmall,
                  maxLines: 1,
                ),*/ //Old code commented out due to Added Parameter Actual Price
                if (chatRate == "FREE")
                  CustomTextMedium(
                    chatRate.toString(),
                    fontSize: Dimensions.fontSizeSmall,
                    maxLines: 1,
                    color: Colors.red,
                  ),
                const Gap(Dimensions.gapExtraExtraSmall),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.green,
              ),
              child: CustomTextRegular(AppStrings.connect.tr, color: ColorResources.toolbarText,textAlign: TextAlign.center),
            )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
