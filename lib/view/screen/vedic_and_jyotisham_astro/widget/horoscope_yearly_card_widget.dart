import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';

class HoroscopeYearlyCardWidget extends StatelessWidget {
  // final List<String> values;

  final String title;
  final String data;
  final String image;
  final String score;

  const HoroscopeYearlyCardWidget(
      {
        super.key, required this.title,
        required this.data,
        required this.image,
        required this.score,
      });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(1),
      child: Card(
        child: Column(
          children: [
            Container(

              decoration: const BoxDecoration(
                color: ColorResources.colorPrimary,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.borderRadiusDefault),
                    topLeft: Radius.circular(Dimensions.borderRadiusDefault)),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(top:Dimensions.paddingSizeExtraSmall,bottom: Dimensions.paddingSizeExtraSmall,right:Dimensions.paddingSizeSmall ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Gap(Dimensions.gapDefault),
                      Image.asset(image,width: Dimensions.iconSizeMedium,color: ColorResources.toolbarText),
                      const Gap(Dimensions.gapDefault),
                      Expanded(
                        child: CustomTextMedium(
                          title,
                          fontSize: Dimensions.fontSizeLarge,
                          color: ColorResources.toolbarText,
                        ),
                      ),
                      CustomTextMedium(
                        score,
                        fontSize: Dimensions.fontSizeLarge,
                        color: ColorResources.toolbarText,
                      ),
                    ],
                  )
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeMediumSmall),
                  child: CustomTextRegular(data,
                    fontSize:Dimensions.fontSizeSmall,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}