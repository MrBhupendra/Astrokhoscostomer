import 'package:astro_brahmand/view/widget/custom_text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/widget/custom_rating_icons.dart';
import 'package:astro_brahmand/view/widget/custom_round_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:get/get.dart';
import '../../utill/app_strings.dart';
import '../../utill/common_methods.dart';
import '../../utill/dimensions.dart';
import '../screen/astro_service/model/service_astrologer_list_model.dart';
import '../screen/splash/controller/config_controller.dart';

class ServiceAstrologerWidget extends StatelessWidget {
  final ServiceAstrologerData astrologer;
  final Function? onPressed;
  final Function? onSelect;

  const ServiceAstrologerWidget(this.astrologer, {this.onPressed,this.onSelect, super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: ColorResources.colorPrimaryVariant, width: 0.6),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(18),
                    CustomRoundNetworkImage(
                      imageUrl: astrologer.astrologer!.astroImg.toString(),
                      height: Dimensions.profileImageHeightSmall,
                      width: Dimensions.profileImageHeightSmall,
                    ),
                    const Gap(8),
                    CustomRatingIcons(
                      rating: double.parse(astrologer.user!.avgRating.toString()),
                    ),
                  ],
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextMedium(
                        astrologer.astrologer!.displayName.toString(),
                        maxLines: 2,
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                      const Gap(2),
                      CustomTextRegular(
                        astrologer.astrologer!.categoriesList.toString(),
                        color: ColorResources.colorSecondaryDark,
                        maxLines: 1,
                        fontSize: Dimensions.fontSizeSmall,
                      ),
                      const Gap(2),
                      CustomTextRegular(
                        astrologer.astrologer!.languagesList.toString(),
                        maxLines: 2,
                        color: ColorResources.black2,
                        fontSize: Dimensions.fontSizeSmall,
                      ),
                      const Gap(2),
                      CustomTextRegular(
                        "Exp: ${astrologer.astrologer!.experience.toString()}+ years",
                        maxLines: 2,
                        color: ColorResources.black2,
                        fontSize: Dimensions.fontSizeSmall,
                      ),
                      const Gap(2),
                      CustomTextMedium(
                        "Duration: ${CommonMethods().getFormattedTimeFromMin(int.parse(astrologer.duration.toString()))}",
                        maxLines: 1,
                        color: Colors.green,
                        fontSize: Dimensions.fontSizeDefault,
                      ),
                      const Gap(2),
                      CustomTextMedium(
                        "Price: ${configController.currencySymbol}${astrologer.price.toString()}",
                        maxLines: 1,
                        color: Colors.green,
                        fontSize: Dimensions.fontSizeDefault,
                      ),
                      const Gap(5),
                      GestureDetector(
                        onTap: () {
                          if (onSelect != null) {
                            onSelect!();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0, bottom: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: ColorResources.colorPrimary),
                                  ),
                                  child: CustomTextPoppins(
                                    AppStrings.bookNow.tr,
                                    color: ColorResources.colorPrimary,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}

