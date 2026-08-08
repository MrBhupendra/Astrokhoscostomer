import 'dart:async';
import 'dart:io';

import 'package:android_play_install_referrer/android_play_install_referrer.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class DeepLinkController extends GetxController {
  StreamSubscription<Uri>? _linkSubscription;
  var referrerCode = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // _initDeepLinks();
    if(Platform.isAndroid){
      _fetchInstallReferrer();
    }
  }

  @override
  void onClose() {
    super.onClose();
    _linkSubscription?.cancel();
  }

  // Handle deep links while app is running
  Future<void> _initDeepLinks() async {
    try{
      _linkSubscription = AppLinks().uriLinkStream.listen((uri) {
        if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'wallet') {
          Get.toNamed('/wallet');
        } else {
          Get.toNamed('/dashboard');
        }
      });
    }catch(e){
      AppLogger.d("DeepLinkController->Error initDeepLinks: $e");
    }

  }

  /// Fetch Install Referrer Data
  Future<void> _fetchInstallReferrer() async {
    try {
      ReferrerDetails referrerDetails = await AndroidPlayInstallReferrer.installReferrer;
      referrerCode.value = referrerDetails.installReferrer ?? "";
      if(referrerCode.value.startsWith("CUS") || referrerCode.value.startsWith("ASTRO") || referrerCode.value.startsWith("CNSULT")){
        referrerCode.value = referrerDetails.installReferrer ?? "";
      } else{
        referrerCode.value = "";
      }
      AppLogger.d("DeepLinkController->Referral Code: ${referrerCode.value}");
    } catch (e) {
      AppLogger.d("DeepLinkController->Error retrieving referrer: $e");
    }
  }
}
