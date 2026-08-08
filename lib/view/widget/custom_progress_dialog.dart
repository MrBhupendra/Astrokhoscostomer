import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:astro_brahmand/utill/app_logger.dart';

class CustomProgressDialog {
  static void showDialog() {
    AppLogger.d("Show Dialog ${Get.isDialogOpen} ");
    if (Get.isDialogOpen == false) {
      Get.dialog(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Lottie.asset(
            //   Images.animProcessLoader,
            //   width: 300,
            //   height: 400,
            //   // fit: BoxFit.contain,
            // ),
            Container(
                height: 75,
                width: 75,
                padding: EdgeInsets.all(22),
                color: Colors.white,
                child: CircularProgressIndicator(color: ColorResources.colorPrimary)
            )
            // Lottie.asset(
            //   Images.animProcessLoader0,
            //   width: 150,
            //   height: 150,
            //   // fit: BoxFit.contain,
            // ),
          ],
        ),
        barrierDismissible: false,
      );
    }
  }

  static void dismissDialog() {
    AppLogger.d("Hide Dialog ${Get.isDialogOpen} ");
    if (Get.isDialogOpen == true) {
      Get.back();
    }

  }
}
