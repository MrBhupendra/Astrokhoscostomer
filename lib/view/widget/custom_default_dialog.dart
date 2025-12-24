import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utill/app_strings.dart';
import '../../utill/color_resources.dart';

class CustomDefaultDialog {
  static void showDialog(String title, String message, VoidCallback onConfirm, VoidCallback onCancel) {
    Get.defaultDialog(
        title: title,
        middleText: message,
        backgroundColor: ColorResources.white,
        // titleStyle: const TextStyle(color: ColorResources.green),
        // middleTextStyle: const TextStyle(color: Colors.black),
        textConfirm: AppStrings.yes.tr,
        textCancel: AppStrings.no.tr,
        // cancelTextColor: Colors.black,
        confirmTextColor: ColorResources.toolbarText,
        buttonColor: ColorResources.colorPrimary,
        barrierDismissible: false,
        radius: 10,
        onConfirm: onConfirm,
        onCancel: onCancel
    );
  }

  static void showOkDialog(String title, String message, Function onOkPressed) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      backgroundColor: ColorResources.white,
      titleStyle: const TextStyle(color: ColorResources.green),
      middleTextStyle: const TextStyle(color: Colors.black),
      textConfirm: "Ok",
      cancelTextColor: Colors.white,
      confirmTextColor: ColorResources.toolbarText,
      buttonColor: ColorResources.green,
      barrierDismissible: false,
      radius: 10,
      onConfirm: () {
        onOkPressed();
      },
    );
  }

  static void showAlertDialog(String title, String message, Function onOkPressed) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      backgroundColor: ColorResources.white,
      titleStyle: const TextStyle(color: ColorResources.red),
      middleTextStyle: const TextStyle(color: Colors.black),
      textConfirm: "Ok",
      cancelTextColor: Colors.white,
      confirmTextColor: ColorResources.toolbarText,
      buttonColor: ColorResources.green,
      radius: 10,
      onConfirm: () {
        onOkPressed();
      },
    );
  }
}
