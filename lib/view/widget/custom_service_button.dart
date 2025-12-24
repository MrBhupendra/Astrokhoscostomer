import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utill/app_strings.dart';
import '../../utill/color_resources.dart';
import '../screen/splash/controller/config_controller.dart';

class CustomServiceButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? service;
  final String? servicePrice;
  final String? serviceImage;
  final IconData? serviceIcon;

  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;

  const CustomServiceButton({
    super.key,
    required this.onTap,
    this.service,
    this.servicePrice,
    this.serviceImage,
    this.serviceIcon,

    this.backgroundColor,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    final EdgeInsets padding = servicePrice == null
        ? const EdgeInsets.symmetric(vertical: 10.0,horizontal: 2)
        : const EdgeInsets.all(2.0);
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(55, 25),
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.zero,
      ),

      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const Gap(2),
            if (serviceImage != null)
              Image.asset(
                serviceImage.toString(),
                height: 14,
                color: ColorResources.white,
              )
            else if (serviceIcon != null)
              Icon(
                serviceIcon,
                size: 14,
                color: iconColor,
              ),
            if (service != null)
              Text(
                service.toString(),
                style: TextStyle(color: textColor),
              ),
            if (servicePrice != null && servicePrice != "FREE")
              Text(
                '${configController.currencySymbol}$servicePrice/min',
                style: TextStyle(color: textColor, fontSize: 11),
              ),
            if (servicePrice != null && servicePrice == "FREE")
              Text(
                servicePrice.toString(),
                style: TextStyle(color: textColor, fontSize: 11),
              ),
          ],
        ),
      ),
    );
  }
}
