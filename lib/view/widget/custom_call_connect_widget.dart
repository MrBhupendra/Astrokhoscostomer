import 'package:astro_brahmand/view/widget/custom_round_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';

class CustomCallConnectDialog extends StatelessWidget {
  final String cusImage;
  final String astroImage;
  final String cusName;
  final String astroName;
  final String title;
  final String description;
  final String iconImage;
  final VoidCallback onOkPressed;

  const CustomCallConnectDialog({
    super.key,
    required this.cusImage,
    required this.astroImage,
    required this.cusName,
    required this.astroName,
    required this.title,
    required this.onOkPressed,
    required this.description,
    required this.iconImage
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
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextMedium(title,fontSize: Dimensions.fontSizeLarge),
                const Gap(Dimensions.gapMedium),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomRoundNetworkImage(imageUrl: cusImage, height: 85, width: 85),
                        const Gap(Dimensions.gapDefault),
                        CustomRoundNetworkImage(imageUrl: astroImage, height: 85, width: 85),
                      ],
                    ),
                    Center(
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: ColorResources.colorPrimary,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(iconImage,height: 18,width: 18,color: ColorResources.toolbarText)
                        )
                    ),
                  ],
                ),
                const Gap(5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: CustomTextMedium(cusName,textAlign: TextAlign.center,maxLines: 2,)),
                      const Gap(Dimensions.gapDefault),
                      Expanded(child: CustomTextMedium(astroName,textAlign: TextAlign.center,maxLines: 2)),
                    ],
                  ),
                ),
                const Gap(10),
                CustomTextRegular(
                  description,
                  textAlign: TextAlign.center,
                  color: ColorResources.black2,
                ),
                const Gap(15),
                GestureDetector(
                  onTap: onOkPressed,
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeSmall,
                        vertical: Dimensions.paddingSizeSmall
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                      color: ColorResources.colorPrimary,
                    ),
                    child: CustomTextRegular(
                      "Ok",
                      textAlign: TextAlign.center,
                      // fontSize: Dimensions.fontSizeSmall,
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
