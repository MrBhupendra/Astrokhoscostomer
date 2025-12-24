import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_bold.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';

import '../../model/astrologer_model.dart';
import '../../utill/app_constants.dart';
import '../../utill/dimensions.dart';

class LiveAstrologerWidget extends StatelessWidget {
  final AstrologerData astrologer;
  final Function? onPressed;
  const LiveAstrologerWidget(this.astrologer, {this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CustomNetworkImage(
                      imageUrl: astrologer.astroImg.toString(),
                      height: 100,
                      width: 85
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorResources.red,
                              ),
                              child: CustomTextRegular(
                                "LIVE",
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeExtraSmall,
                              ),
                            ),
                          ],
                        ),
                        CustomTextRegular(
                          astrologer.displayName.toString(),
                          maxLines: 1,
                          fontSize: Dimensions.fontSizeDefault,
                          color: ColorResources.black,
                        ),
                        CustomTextBold(
                          astrologer.liveTopic.toString(),
                          maxLines: 2,
                          color: ColorResources.black1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorResources.colorPrimary,
                              ),
                              child: CustomTextRegular(
                                "Join Now",
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
