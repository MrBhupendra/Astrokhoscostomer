import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';

class NumerologyWidget extends StatelessWidget {


  final String title;

  final String number;
  final String image;
  final String meaning;
  final String description;

  const NumerologyWidget(
      {
        super.key,
        required this.title,

        required this.image,
        required this.number,
        required this.meaning,
        required this.description,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault), // Adjust the radius as needed
        border: Border.all(
          color: ColorResources.colorPrimaryVariant,
          width: 1, // Adjust the border width as needed
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Column(
            children: [
              Row(

                children: [
                  Image.asset(image,width: 28,),
                  const Gap(Dimensions.gapExtraSmall),
                  Expanded(
                    child: CustomTextMedium(title,fontSize:Dimensions.fontSizeLarge),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.borderRadiusRounded),
                          color: ColorResources.colorPrimaryLight,
                        border: Border.all(
                          width: 0.5,
                          color: ColorResources.colorPrimary
                        )
                      ),
                      child: Center(child: Text(number,)),
                    ),
                  )
                ],
              ),
              const Gap(Dimensions.gapDefault),
              Row(
                children: [
                  Expanded(child: CustomTextRegular(meaning,color: ColorResources.colorText)),
                ],
              ),
              const Gap(Dimensions.gapExtraSmall),
              Row(
                children: [
                  Expanded(child: CustomTextRegular(description,color: ColorResources.black10,)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}