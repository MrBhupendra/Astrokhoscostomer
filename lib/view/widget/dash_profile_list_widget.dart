import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import 'custom_text_regular.dart';

class DashProfileListWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  final String title;

  const DashProfileListWidget({
    super.key,
    required this.onTap,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeExtraOverSmall,
        ),
        child: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: ColorResources.colorPrimaryLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                image,
                color: ColorResources.colorPrimaryDark,
              ),
            ),
            const Gap(Dimensions.gapMedium),
            Expanded(
              child: CustomTextRegular(
                title,
                color: ColorResources.black1,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: ColorResources.colorPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
