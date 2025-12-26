
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';

class CurrentMahadasha extends StatelessWidget {
  final String name;
  final String start;
  final String end;
  final bool isForward;

  const CurrentMahadasha(
      {super.key, required this.name, required this.start, required this.end,required this.isForward});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
          width: 1.0,
        ),
        color: ColorResources.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.borderRadiusDefault),
        ),
      ),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          child: Row(
            children: [
              CustomTextMedium(name),
              const Gap(Dimensions.gapExtraOverLarge),
              Expanded(
                child: Column(
                  children: [
                    CustomTextRegular(start),
                    CustomTextRegular(end),
                  ],
                ),
              ),
              if(isForward)
                const Icon(Icons.arrow_circle_right_sharp,color:ColorResources.colorPrimaryDark,)
            ],
          ),
        ));
  }
}