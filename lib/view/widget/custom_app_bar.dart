import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final IconData? icon;
  final double? iconSize;
  final Function? onActionPressed;
  final Function? onBackPressed;
  final Widget? badgeIcon;
  final Widget? isClearFilterButton;
  final Function? onClearFilterPressed;
  
  const CustomAppBar({
    super.key,
    required this.title,
    this.isBackButtonExist = true,
    this.icon,
    this.iconSize,
    this.onActionPressed,
    this.onBackPressed,
    this.badgeIcon,
    this.isClearFilterButton,
    this.onClearFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorResources.colorPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Container(
        height: preferredSize.height,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Row(
            children: [
              isBackButtonExist
                  ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: iconSize ?? Dimensions.iconSizeMediumSmall,
                  color: ColorResources.toolbarText,
                ),
                onPressed: () => onBackPressed != null
                    ? onBackPressed!()
                    : Get.back(),
              )
                  : const SizedBox.shrink(),
              const Gap(Dimensions.gapExtraSmall),
              Expanded(
                child: CustomTextRegular(
                    title.toString(),
                  fontSize: Dimensions.fontSizeLarge,
                  color: ColorResources.toolbarText,
                  maxLines: 1,
                )
              ),

              isClearFilterButton != null
                  ? GestureDetector(
                    onTap: () => onClearFilterPressed?.call(),
                    child: isClearFilterButton!,
                  ) : const SizedBox.shrink(),
              
              icon != null
                  ? IconButton(
                icon: Icon(
                  icon,
                  size: 24,
                  color: ColorResources.toolbarText,
                ),
                onPressed: onActionPressed as void Function()?,
              )
                  : const SizedBox.shrink(),

              badgeIcon != null
                  ? Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  onTap: () => onActionPressed?.call(),
                  child: badgeIcon!,
                ),
              ) : const SizedBox.shrink(),
              
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
