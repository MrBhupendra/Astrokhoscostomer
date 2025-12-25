import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import '../../view/widget/custom_text_regular.dart';

class CustomDrawerItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;
  final bool visible;

  const CustomDrawerItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
    this.visible = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox();

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: Dimensions.gapDrawerDefault),
        child: Row(
          children: [
            const Gap(Dimensions.gapLarge),
            Image.asset(
              iconPath,
              height: Dimensions.drawerIconSize,
              color: ColorResources.black2,
            ),
            const Gap(Dimensions.gapMedium),
            Expanded(
              child: CustomTextRegular(
                title,
                color: ColorResources.black1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
