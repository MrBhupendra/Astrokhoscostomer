import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class AppUpdateController extends GetxController {
  Rx<AppUpdateInfo?> updateInfo = Rx<AppUpdateInfo?>(null);
  RxBool flexibleUpdateAvailable = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkForUpdate();
  }

  Future<void> checkForUpdate() async {
    try {
      AppUpdateInfo info = await InAppUpdate.checkForUpdate();
      updateInfo.value = info;
      if (updateInfo.value?.updateAvailability == UpdateAvailability.updateAvailable) {
        performImmediateUpdate();
        //startFlexibleUpdate();
      }
    } catch (e) {
      AppLogger.d("checkForUpdate [Error] ${e.toString()}");
      // Get.snackbar('Error', e.toString());
    }
  }

  void performImmediateUpdate() async {
    try {
      await InAppUpdate.performImmediateUpdate();
    } catch (e) {
      AppLogger.d("performImmediateUpdate [Error] ${e.toString()}");
    }
  }

  void startFlexibleUpdate() async {
    try {
      await InAppUpdate.startFlexibleUpdate();
      flexibleUpdateAvailable.value = true;
      completeFlexibleUpdate();
    } catch (e) {
      AppLogger.d("startFlexibleUpdate [Error] ${e.toString()}");
      //Get.snackbar('Error', e.toString());
    }
  }

  void completeFlexibleUpdate() async {
    try {
      await InAppUpdate.completeFlexibleUpdate();
      Get.snackbar('Success', 'Update completed successfully!');
    } catch (e) {
      AppLogger.d("completeFlexibleUpdate [Error] ${e.toString()}");
      // Get.snackbar('Error', e.toString());
    }
  }
}
