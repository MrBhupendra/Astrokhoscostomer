import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/screen/splash/controller/config_controller.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../model/astrologer_model.dart';
import '../../utill/app_constants.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';
import 'custom_round_network_image.dart';
import 'custom_text_medium.dart';

class AstrologerProfileCard extends StatelessWidget {

  AstrologerData astrologer;
  final Function? onActionPressed;

  AstrologerProfileCard(this.astrologer, {this.onActionPressed, super.key});
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
          height: 210,
          // padding: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(right: 8.0,left: 8,top: 8,bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              _topRow(),
              const Gap(2),
              _avatar(),
              const Gap(6),
              _name(),
              const Gap(2),
              // _rating(),

              // _price(chatRate),

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

              const Gap(2),
              const Spacer(),
              _callButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔴 Online + Verified
  Widget _topRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 4,
              backgroundColor: _statusColor(astrologer),
            ),
            const SizedBox(width: 4),
            Text(
              _statusText(astrologer),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: _statusColor(astrologer),
              ),
            ),
          ],
        ),
        // Row(
        //   children: [
        //     CircleAvatar(
        //         radius: 4,
        //         // backgroundColor: Colors.green,
        //       backgroundColor: astrologer.onlineStatus == 1 &&
        //           astrologer.busyStatus == 1
        //           ? Colors.yellow
        //           : astrologer.onlineStatus == 1
        //           ? Colors.green
        //           : Colors.red,
        //     ),
        //     const SizedBox(width: 4),
        // Text(
        //   astrologer.onlineStatus == 1 && astrologer.busyStatus == 1
        //       ? 'Busy'
        //       : astrologer.onlineStatus == 1
        //       ? 'Online'
        //       : 'Offline',
        //   style: TextStyle(
        //     fontSize: 10,
        //     fontWeight: FontWeight.bold,
        //     color: astrologer.onlineStatus == 1 && astrologer.busyStatus == 1
        //         ? Colors.yellow
        //         : astrologer.onlineStatus == 1
        //         ? Colors.green
        //         : Colors.red,
        //   ),
        // )

        //   ],
        // ),
        // if(astrologer.isVerified == 1)
        const Icon(
          Icons.verified,
          size: 18,
          color: Colors.green,
        ),
      ],
    );
  }

  Color _statusColor(AstrologerData astrologer) {
    if (astrologer.onlineStatus == 1 && astrologer.busyStatus == 1) {
      return Colors.yellow;
    } else if (astrologer.onlineStatus == 1) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  String _statusText(AstrologerData astrologer) {
    if (astrologer.onlineStatus == 1 && astrologer.busyStatus == 1) {
      return 'Busy';
    } else if (astrologer.onlineStatus == 1) {
      return 'Online';
    } else {
      return 'Offline';
    }
  }


  /// 👤 Avatar
  Widget _avatar() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: ColorResources.colorPrimary,
          width: 1.5,
        ),
      ),
      child: CustomRoundNetworkImage(
          imageUrl: astrologer.astroImg.toString(),
          height: 64,
          width: 64
      ),
    );
  }

  /// 👨 Name
  Widget _name() {
    return CustomTextMedium(
      astrologer.displayName.toString(),
      maxLines: 1,
      textAlign: TextAlign.center,
    );
  }

  /// 📞 Call Button
  Widget _callButton() {
    return Container(
      height: 34,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorResources.colorPrimary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: CustomTextRegular(AppStrings.conNect.tr, color: Colors.white,fontSize: 13,),
      ),
    );
  }
}
