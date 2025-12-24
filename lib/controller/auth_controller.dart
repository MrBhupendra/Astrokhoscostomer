import 'package:astro_brahmand/model/success_model.dart';
import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../utill/shared_preference.dart';
import '../view/widget/custom_snack_bar.dart';

class AuthController extends GetxController {
  final Dio _dio = Dio();
  final isLoading = false.obs;
  final isSuccess = false.obs;

  String? name = 'Not logged in';
  String? uid = '***';
  String? profileImage = '***';
  bool isLogin = false;

  SuccessModel deleteAccModel = SuccessModel();

  late String customerIdDeepLink;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    isLogin = await SharedPreferencesHelper.getIsLogin();

    if (isLogin == true) {
      name = await SharedPreferencesHelper.getData(AppConstants.name);
      uid = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      customerIdDeepLink = uid!;
      profileImage = await SharedPreferencesHelper.getData(AppConstants.profileImage);
    }
  }

  Future<void> deleteAccount() async {
    isLoading(true);
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.deleteAccount,
          data: {'api_key': apiKey, 'user_uni_id': uniId});
      if (response.statusCode == 200) {
        deleteAccModel = SuccessModel.fromJson(response.data);
        if (deleteAccModel.status == AppConstants.success) {
          isSuccess(true);
          await SharedPreferencesHelper.logoutSession();
        } else {
          isSuccess(false);
          CustomSnackBar.showBottom(deleteAccModel.msg.toString());
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
