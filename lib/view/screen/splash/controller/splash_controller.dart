import 'dart:async';
import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../model/welcome_model.dart';
import '../../../../notification/notification_router.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import 'config_controller.dart';

class SplashController extends GetxController {
  final Dio _dio = Dio();
  final isLoading = false.obs;
  WelcomeModel welcomeModel = WelcomeModel();

  @override
  Future<void> onInit() async {
    super.onInit();
    CommonMethods().getFCMToken();
    await SharedPreferencesHelper.saveBoolData(AppConstants.isPopUp, true);
    getData();
  }

  Future<void> getData() async {
    String language =
        await SharedPreferencesHelper.getData(AppConstants.appLanguage) ?? 'en';
    language = (language == '***') ? 'en' : language;
    Get.updateLocale(Locale(language));

    isLoading(true);
    try {
      final response = await _dio.post(AppConstants.welcomeUri);
      if (response.statusCode == 200) {
        welcomeModel = WelcomeModel.fromJson(response.data);
        if (welcomeModel.status == AppConstants.success) {
          ConfigController configController =
              Get.put(ConfigController(), permanent: true);
          //SaveData to Pref
          configController.setConfigData(welcomeModel);
          await CommonMethods()
              .saveConfigSharedPrefData(welcomeModel, language);
          bool isLogin = await SharedPreferencesHelper.getIsLogin();
          if (isLogin) {
            String? currencyCode = await SharedPreferencesHelper.getData(
                AppConstants.currencyCode);
            String? currencySymbol = await SharedPreferencesHelper.getData(
                AppConstants.currencySymbol);
            String? phoneCode =
                await SharedPreferencesHelper.getData(AppConstants.phoneCode);
            configController.setCurrency(
                currencySymbol: currencySymbol == "***"
                    ? welcomeModel.data!.defaultCurrencySymbol.toString()
                    : currencySymbol.toString(),
                currencyCode: currencyCode == "***"
                    ? welcomeModel.data!.defaultCurrencyCode.toString()
                    : currencyCode.toString(),
                phoneCode: phoneCode == "***"
                    ? AppConstants.defaultPhoneCode
                    : phoneCode.toString());

            // If app was opened via notification tap (terminated state),
            // don't override the navigation with dashboard routing.
            if (NotificationRouter.hasPendingColdStartNavigation) {
              await NotificationRouter.flushColdStartQueue();
              return;
            }
            Get.offAllNamed('/dashboard');
          } else {
            configController.setCurrency(
                currencySymbol: welcomeModel.data!.defaultCurrencySymbol ??
                    AppConstants.defaultCurrencySymbol,
                currencyCode: welcomeModel.data!.defaultCurrencyCode ??
                    AppConstants.defaultCurrencyCode,
                phoneCode: AppConstants.defaultPhoneCode);
            // If app was opened via notification tap (terminated state),
            // let notification router decide where to go (it may still end up on login).
            if (NotificationRouter.hasPendingColdStartNavigation) {
              await NotificationRouter.flushColdStartQueue();
              return;
            }
            Get.offAllNamed('/login');
          }
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isLoading(false);
    }
  }
}
