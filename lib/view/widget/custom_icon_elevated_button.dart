import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../utill/color_resources.dart';

class CustomIconElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderRadius? borderRadius;
  final IconData icon;

  const CustomIconElevatedButton({
    super.key,
    required this.text,
    required this.icon,
    this.onPressed,
    this.textColor,
    this.backgroundColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      color: textColor ?? ColorResources.black1,
      fontSize: 14,
      letterSpacing: 1,
    );

    return SizedBox(
      width: Get.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? ColorResources.black8,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor,size: 18),
            const Gap(6),
            Text(
              text,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
