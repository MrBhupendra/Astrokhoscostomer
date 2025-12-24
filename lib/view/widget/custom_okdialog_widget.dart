import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';

class CustomOkdialogWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String? btnText;
  final VoidCallback onPressed;
  final Color? imageColor;

  const CustomOkdialogWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    this.btnText,
    required this.onPressed,
    this.imageColor,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10,top: 10,bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      imagePath, // Image
                      height: 75,
                      width: 85,
                      color: imageColor,
                    ),
                  ],
                ),
                const Gap(8),
                CustomTextMedium(
                  title,
                  fontSize: Dimensions.fontSizeOverLarge,
                  textAlign: TextAlign.center,
                ),
                const Gap(2),
                CustomTextRegular(
                  description,
                  textAlign: TextAlign.center,
                  color: ColorResources.black4,
                ),
                const Gap(12),
                GestureDetector(
                  onTap: onPressed,
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeExtraLarge,
                        vertical: Dimensions.paddingSizeExtraSmall
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        )
                      ],
                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                      color: ColorResources.colorPrimary,
                    ),
                    child: CustomTextRegular(
                      btnText ?? "Ok",
                      textAlign: TextAlign.center,
                      color: ColorResources.toolbarText,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
