import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:astro_brahmand/utill/app_logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../utill/app_strings.dart';
import '../utill/color_resources.dart';
import '../utill/dimensions.dart';
import '../utill/images.dart';
import '../view/widget/custom_text_medium.dart';
import '../view/widget/custom_text_regular.dart';

class ConnectivityController extends FullLifeCycleController
    with FullLifeCycleMixin {
  final Dio _dio = Dio();

  var isSlowConnection = false.obs;
  RxList<ConnectivityResult> connectionStatus = <ConnectivityResult>[ConnectivityResult.none].obs;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
  late String dialogId;

  bool wasPreviouslyOffline = false;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();

    connectivitySubscription = connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  @override
  void onClose() {
    connectivitySubscription.cancel();
    super.onClose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      AppLogger.e('Couldn\'t check connectivity status', error: e);
      return;
    }
    return updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(List<ConnectivityResult> result) async {
    connectionStatus.value = result;
    if (connectionStatus.first == ConnectivityResult.none) {
      wasPreviouslyOffline = true;
      if (!Get.isDialogOpen!) {
        dialogId = Get.dialog(
              Dialog(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: Get.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10,top: 10,bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Images.noInternet, // Image
                              height: 65,
                              width: 65,
                              color: ColorResources.black5,
                            ),
                          ],
                        ),
                        const Gap(8),
                        CustomTextMedium(
                          AppStrings.noInternet.tr,
                          fontSize: Dimensions.fontSizeOverLarge,
                          textAlign: TextAlign.center,
                        ),
                        const Gap(2),
                        CustomTextRegular(
                          AppStrings.noInternetMsg.tr,
                          textAlign: TextAlign.center,
                          color: ColorResources.black4,
                        ),
                        const Gap(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                AppSettings.openAppSettings(type: AppSettingsType.wifi);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeDefault,
                                    vertical: Dimensions.paddingSizeOverSmall
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: ColorResources.green)
                                  // color: ColorResources.colorPrimary,
                                ),
                                child: CustomTextRegular(
                                  "Connect",
                                  textAlign: TextAlign.center,
                                  // fontSize: Dimensions.fontSizeSmall,
                                  color: ColorResources.green,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              barrierDismissible: false
            ).toString();
        //     Get.dialog(
        //   AlertDialog(
        //     title: const Text("No Internet"),
        //     content: const Text("Please check your internet connection."),
        //     actions: <Widget>[
        //       TextButton(
        //         onPressed: () async {
        //           AppSettings.openAppSettings(type: AppSettingsType.wifi);
        //         },
        //         child: const Text("Connect"),
        //       ),
        //     ],
        //   ),
        //   barrierDismissible: false,
        // ).toString();
      }
    }
    else {
      if (Get.isDialogOpen!) {
        Get.back(); // Dismiss the dialog
      }
      if (wasPreviouslyOffline) {
        wasPreviouslyOffline = false;
        onNetworkReconnect();
      }
      // checkForSlowConnection();
    }
    // ignore: avoid_print
    AppLogger.d('Connectivity changed: $connectionStatus');
  }

  Future<void> onNetworkReconnect() async {
    AppLogger.d("Internet is back. Refreshing app state...");
    Get.offAllNamed('/splash');
  }


  Future<void> checkForSlowConnection() async {
    try {
      final stopwatch = Stopwatch()..start();
      final response = await _dio.get('https://www.google.com');
      stopwatch.stop();

      if (response.statusCode == 200) {
        final elapsed = stopwatch.elapsedMilliseconds;
        // Consider a connection slow if it takes more than 2 seconds
        isSlowConnection.value = elapsed > 2000;
        // if (isSlowConnection.isTrue) {
        //   if (!Get.isDialogOpen!) {
        //     dialogId = Get.dialog(
        //       AlertDialog(
        //         title: const Text("Slow Internet"),
        //         content: const Text("Please check your internet connection."),
        //         actions: <Widget>[
        //           TextButton(
        //             onPressed: () async {
        //               AppSettings.openAppSettings(type: AppSettingsType.wifi);
        //             },
        //             child: const Text("Ok"),
        //           ),
        //         ],
        //       ),
        //       barrierDismissible: false,
        //     ).toString();
        //   }
        // }
        // else {
        //   if (Get.isDialogOpen!) {
        //     Get.back(); // Dismiss the dialog
        //   }
        //   checkForSlowConnection();
        // }
      } else {
        isSlowConnection.value = false;
      }
    } catch (e) {
      isSlowConnection.value = false;
    }
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
  }

  @override
  void onResumed() {
    initConnectivity();
  }
}
