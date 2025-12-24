import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utill/color_resources.dart';

class CustomSnackBar {
  static void showBottom(String msg) {
    Get.snackbar(
      AppStrings.alert.tr,
      // icon: const Icon(Icons.error_outline,color: ColorResources.red,),
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorResources.black.withOpacity(0.8),
      colorText: ColorResources.white,
    );
  }

  static void showTop(String msg) {
    Get.snackbar(
      AppStrings.title.tr,
      msg,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      colorText: Colors.black,
    );
  }

  // static void showBottomTwo(String msg,BuildContext context){
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(msg)
  //   ));
  // }
}
