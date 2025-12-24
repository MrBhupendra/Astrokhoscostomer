
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
      // Set the width as needed
      // Set the height as needed
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorResources.colorPrimary,
            width: 1.0,
          ),
          color: ColorResources.colorPrimaryLight, // Background color
          borderRadius: const BorderRadius.all(
            Radius.circular(
                Dimensions.borderRadiusDefault), // Adjust the radius as needed
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