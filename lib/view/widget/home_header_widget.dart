import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/view/widget/custom_button.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utill/app_strings.dart';
import '../../utill/color_resources.dart';

class HomeHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const HomeHeaderWidget({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomTextMedium(
              title,
              maxLines: 1,
              fontSize: Dimensions.fontSizeLarge,
            ),
          ),
          CustomButton(
            AppStrings.viewAll.tr,
            onPressed: onPressed,
            color: ColorResources.toolbarText,
            fontSize: Dimensions.fontSizeExtraSmall,
            minimumSize: const Size(35, 25),
          ),
        ],
      ),
    );
  }
}