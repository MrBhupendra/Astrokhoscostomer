import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';

class CustomDialogWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final VoidCallback onYesPressed;
  final VoidCallback? onNoPressed;
  final Color? imageColor;
  final Color? textColor;
  final Color? btnColor;
  final String? yesText;
  final String? noText;

  const CustomDialogWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onYesPressed,
    required this.description,
    this.onNoPressed,
    this.imageColor,
    this.textColor,
    this.btnColor,
    this.yesText,
    this.noText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: Get.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10,top: 20,bottom: 6),
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
                    height: 65,
                    width: 65,
                    color: imageColor ?? ColorResources.colorPrimary,
                  ),
                ],
              ),
              const Gap(15),
              CustomTextMedium(
                title,
                fontSize: Dimensions.fontSizeOverLarge,
                textAlign: TextAlign.center,
              ),
              const Gap(8),
              CustomTextRegular(
                description,
                textAlign: TextAlign.center,
                color: ColorResources.black4,
              ),
              const Gap(8),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: onNoPressed ?? () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall,
                              vertical: Dimensions.paddingSizeExtraSmall
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                            border: Border.all(color: ColorResources.colorPrimary), // Replace with your primary color
                          ),
                          child: CustomTextRegular(
                              noText ?? "No",
                              textAlign: TextAlign.center,
                              color: ColorResources.colorPrimary // Replace with your primary color
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: GestureDetector(
                        onTap: onYesPressed,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall,
                              vertical: Dimensions.paddingSizeExtraSmall
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                            color: btnColor ?? ColorResources.colorPrimary, // Replace with your primary color
                            border: Border.all(color: btnColor ?? ColorResources.colorPrimary),
                          ),
                          child: CustomTextRegular(
                            yesText ?? "Yes",
                            textAlign: TextAlign.center,
                            // fontSize: Dimensions.fontSizeSmall,
                            color: textColor ?? ColorResources.toolbarText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
