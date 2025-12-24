
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_text_regular.dart';

class HoroscopeLuckyDetailsWidget extends StatelessWidget {

  final String date;
  final String luckyColorCode;
  final String number;
  final String image;
  final String nakshatra;
  final String colorName;

  const HoroscopeLuckyDetailsWidget(
      {super.key,
        required this.date,
        required this.luckyColorCode,
        required this.number,
        required this.image,
        required this.nakshatra ,
        required this.colorName
      }
      );

  @override
  Widget build(BuildContext context) {
    Color parseColor(String colorString) {
      if (colorString.startsWith('#')) {
        colorString = colorString.substring(1);
      }
      return Color(int.parse(colorString, radix: 16));
    }

    return Center(
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage(Images.horoscopeBgCard),
            fit: BoxFit.cover,
          ),
         borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)
        ),
        child: Padding(
          padding: const EdgeInsets.only(top:Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeSmall,bottom:Dimensions.paddingSizeSmall),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextRegular(date, color: ColorResources.white,  fontSize: Dimensions.fontSizeSmall),
              const Gap(Dimensions.gapExtraSmall),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                child: Row(
                  children: [
                    Expanded(child: CustomTextRegular(AppStrings.horoscopeIsReady.tr,color: ColorResources.white,textAlign: TextAlign.start)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CustomTextRegular(AppStrings.horoscopeIsReady.tr,color: ColorResources.white),

                          // const Gap(Dimensions.gapDefault),
                          CustomTextRegular(AppStrings.luckyColor.tr,color: ColorResources.white),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusRounded),
                                  color: Color(int.parse(luckyColorCode.replaceAll('#', '0xFF'))),
                                ),
                              ),
                              const Gap(5),
                              CustomTextRegular("($colorName)",
                                  color: ColorResources.white,
                                  fontSize: Dimensions.fontSizeSmall)
                            ],
                          ),

                          const Gap(Dimensions.gapDefault),
                          CustomTextRegular(AppStrings.luckyNumber.tr,color: ColorResources.white),
                          CustomTextRegular(number, color: ColorResources.white, fontSize: Dimensions.fontSizeSmall),

                          const Gap(Dimensions.gapDefault),
                          CustomTextRegular(AppStrings.zodiac.tr,color: ColorResources.white,),
                          CustomTextRegular(
                              nakshatra,
                              color: ColorResources.white,
                              fontSize: Dimensions.fontSizeSmall
                          ),

                        ],
                      ),
                      const Gap(Dimensions.gapSizeFifty),
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset(image,width: Dimensions.imageHeightExtraLarge,),
                          ],
                        ),
                      )
                    ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
