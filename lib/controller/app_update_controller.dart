import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';

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
      debugPrint("checkForUpdate [Error] ${e.toString()}");
      // Get.snackbar('Error', e.toString());
    }
  }

  void performImmediateUpdate() async {
    try {
      await InAppUpdate.performImmediateUpdate();
    } catch (e) {
      debugPrint("performImmediateUpdate [Error] ${e.toString()}");
    }
  }

  void startFlexibleUpdate() async {
    try {
      await InAppUpdate.startFlexibleUpdate();
      flexibleUpdateAvailable.value = true;
      completeFlexibleUpdate();
    } catch (e) {
      debugPrint("startFlexibleUpdate [Error] ${e.toString()}");
      //Get.snackbar('Error', e.toString());
    }
  }

  void completeFlexibleUpdate() async {
    try {
      await InAppUpdate.completeFlexibleUpdate();
      Get.snackbar('Success', 'Update completed successfully!');
    } catch (e) {
      debugPrint("completeFlexibleUpdate [Error] ${e.toString()}");
      // Get.snackbar('Error', e.toString());
    }
  }
}
