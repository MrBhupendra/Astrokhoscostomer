import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';

class AggregateData extends StatelessWidget {
  final String title;
  final String boy ;
  final String boydata;
  final String girl;
  final String girldata;
  final String ortherdata;

  const AggregateData(
      {super.key,
        required this.title,
        required this.boy,
        required this.boydata,
        required this.girl,
        required this.girldata,
        required this.ortherdata}
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color:ColorResources.colorPrimaryDark ),
        color: ColorResources.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          const Gap(Dimensions.gapDefault),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextMedium(title,fontSize: Dimensions.fontSizeLarge,),
            ],
          ),
          const Gap(Dimensions.gapSmall),
          Padding(
            padding: const EdgeInsets.only(left:Dimensions.paddingSizeLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: ColorResources.colorPrimaryLight ,
                  child: Padding(
                    padding: const EdgeInsets.only(top:Dimensions.gapSmall,bottom: Dimensions.gapSmall,left: Dimensions.paddingSizeLarge,right: Dimensions.paddingSizeLarge),
                    child: Row(
                      children: [
                        CustomTextRegular(boy),
                        CustomTextRegular(boydata,fontSize: Dimensions.fontSizeSmall ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: ColorResources.colorPrimaryLight ,
                  child: Padding(
                    padding: const EdgeInsets.only(top:Dimensions.gapSmall,bottom: Dimensions.gapSmall,left: Dimensions.paddingSizeLarge,right: Dimensions.paddingSizeLarge),
                    child: Row(
                      children: [
                        CustomTextRegular(girl),
                        CustomTextRegular(girldata,fontSize:Dimensions.fontSizeSmall),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Center(child: CustomTextRegular(ortherdata,textAlign: TextAlign.center,fontSize: Dimensions.fontSizeSmall),)
          ),
          const Gap(Dimensions.gapExtraSmall)
        ],
      ),
    );
  }
}