import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';

class CustomPaymentDialogWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;
  final String title;
  final String description;
  final String btnText;
  final Color? textColor;
  final Color? borderColor;

  const CustomPaymentDialogWidget({
    super.key,
    required this.imagePath,
    required this.onPressed,
    required this.title,
    required this.description,
    required this.btnText,
    this.textColor,
    this.borderColor
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          // height: Get.height*0.4,
          width: Get.width*0.7,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(imagePath, height: 70,width: 70),
                  ],
                ),
                const Gap(30),
                CustomTextMedium(title,fontSize: Dimensions.fontSizeExtraLarge,),
                const Gap(8),
                CustomTextRegular(
                  description,
                  textAlign: TextAlign.center,
                  color: ColorResources.black4,
                ),
                const Gap(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: onPressed,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeLarge,
                            vertical: Dimensions.paddingSizeExtraSmall
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: borderColor ?? ColorResources.green)
                          // color: ColorResources.colorPrimary,
                        ),
                        child: CustomTextRegular(
                          btnText,
                          textAlign: TextAlign.center,
                          fontSize: Dimensions.fontSizeSmall,
                          color: textColor ?? ColorResources.green,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}