import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';

class HoroscopYearlyBoxWidget extends StatelessWidget {
  // final List<String> values;

  final String title;
  final String data;
  final String prashent;
  final String image;

  const HoroscopYearlyBoxWidget(
      {
        super.key,
        required this.title,
        required this.data,
        required this.image,
        required this.prashent,
      });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, left: Dimensions.paddingSizeExtraSmall, right: Dimensions.paddingSizeExtraSmall),
      child: Container(
        decoration: BoxDecoration(
          color: ColorResources.white,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault), // Adjust the radius as needed
          border: Border.all(
            color: ColorResources.colorPrimaryVariant,
            width: 1, // Adjust the border width as needed
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(image,width: Dimensions.iconSizeDefault,),
                    const Gap(Dimensions.gapSmall),
                    Expanded(
                      child: CustomTextMedium(title,
                          fontSize: Dimensions.fontSizeLarge,
                          color: ColorResources.colorText
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:Dimensions.paddingSizeOverSmall,left: Dimensions.paddingSizeExtraOverSmall),
                      child: Column(
                        children: [
                          CustomTextRegular(prashent, fontSize: Dimensions.fontSizeSmall,)
                        ],
                      ),
                    ),

                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    Expanded(child: CustomTextRegular(data,
                      color: ColorResources.black1,
                      fontSize: Dimensions.fontSizeSmall,
                    ),
                    ),
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