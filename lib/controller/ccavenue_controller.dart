import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/success_model.dart';
import '../utill/app_constants.dart';
import '../utill/app_dialogs.dart';
import '../utill/app_events.dart';
import '../utill/shared_preference.dart';
import '../view/widget/custom_progress_dialog.dart';

class CCAvenueController extends GetxController {

  final Dio _dio = Dio();
  final isUpdateLoading = false.obs;
  final isUpdateSuccess = false.obs;
  SuccessModel successModel = SuccessModel();

  Future<void> updateOnlinePayment(String amount,String orderId, String paymentId,String userId, String type) async {
    try {
      AppEvents().sendPaymentSuccessEvent(amount.toString(), orderId.toString(), userId.toString(),  type);
    } catch (_) {
      // Analytics failure must not block payment update.
    }
    CustomProgressDialog.showDialog();
    isUpdateLoading(true);

    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? paymentMethod =
      await SharedPreferencesHelper.getData(AppConstants.paymentGateway);
      final response =
      await _dio.post(AppConstants.updatePaymentRequest, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "payment_method": paymentMethod,
        "order_id": orderId,
        "payment_id": paymentId
      });
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        successModel = SuccessModel.fromJson(response.data);
        if (successModel.status == AppConstants.success) {
          isUpdateSuccess(true);
        } else {
          isUpdateSuccess(false);
        }
      } else {
        CustomProgressDialog.dismissDialog();
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      isUpdateSuccess(false);
    } finally {
      isUpdateLoading(false);
      AppDialog().showPaymentSuccessDialog(type);
    }
  }
}