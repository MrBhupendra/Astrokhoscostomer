import 'package:flutter/material.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';

class CustomMatchingScore extends StatelessWidget {

  final String score ;

  const CustomMatchingScore({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(color: ColorResources.colorPrimaryLight,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2),
          )
        ],
        border: Border.all(
          color: ColorResources.colorPrimaryVariant,
          width: 3.0,
        ),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding:
        const EdgeInsets.all(Dimensions.paddingSizeThirtyFive),
        child: Center(
          child: Text(
            score,
            style: const TextStyle(
                color: ColorResources.black,
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.fontSizeLarge),
          ),
        ),
      ),
    );
  }
}
