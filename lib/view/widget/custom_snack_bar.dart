import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utill/color_resources.dart';

class CustomSnackBar {
  static void showBottom(String msg) {
    Get.closeAllSnackbars();

    Get.snackbar(
      AppStrings.alert.tr,
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorResources.black.withOpacity(0.8),
      colorText: ColorResources.white,
      duration: const Duration(seconds: 2),
    );
  }

  static void showTop(String msg) {
    Get.closeAllSnackbars();

    Get.snackbar(
      AppStrings.title.tr,
      msg,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      colorText: Colors.black,
      duration: const Duration(seconds: 2),
    );
  }
}