import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import '../model/success_model.dart';
import '../utill/app_constants.dart';
import '../utill/app_dialogs.dart';
import '../utill/app_events.dart';

class PhonePeController extends GetxController {
  final String _merchantId;
  PhonePeController(this._merchantId); //Phonepe
  Object? result;
  final String _environmentValue = 'PRODUCTION';
  final String _appId = "";
  /// PhonePe SDK logs only in debug builds.
  final bool _enableLogs = kDebugMode;

  String _type = '';

  //Update payment
  final Dio _dio = Dio();
  final isUpdateLoading = false.obs;
  final isUpdateSuccess = false.obs;
  SuccessModel successModel = SuccessModel();

  @override
  void onInit() {
    super.onInit();
    initPhonePeSdk();
  }

  void initPhonePeSdk() {
    PhonePePaymentSdk.init(_environmentValue, _appId, _merchantId, _enableLogs)
        .then((isInitialized) {
      result = 'PhonePe SDK Initialized - $isInitialized';
    }).catchError((error) {
      handleError(error);
      return error;
    });
  }

  void handleError(error) {
    if (error is Exception) {
      result = error.toString();
    } else {
      result = {"error": error};
    }
  }

  void startTransaction(
      String body,
      String callBackUrl,
      String checksum,
      String type1,
      String orderId,
      String paymentId,
      num amount,
      String mobile,
      String userUniId) async {
    _type = type1;
    AppEvents().sendInitCheckoutEvent(
        amount.toString(), orderId.toString(), userUniId.toString(), type1);
    try {
      PhonePePaymentSdk.startTransaction(body, callBackUrl, checksum, "")
          .then((response) {
        if (response != null) {
          String status = response['status'].toString();
          String error = response['error'].toString();
          if (status == 'SUCCESS') {
            result = "Flow Completed - Status: Success!";
            AppEvents().sendPaymentSuccessEvent(amount.toString(), orderId.toString(), userUniId.toString(), type1);
            AppDialog().showPaymentSuccessDialog(_type);
          } else {
            result = "Flow Completed - Status: $status and Error: $error";
            Future.delayed(const Duration(milliseconds: 500), () {
              AppDialog().showPaymentFailedDialog();
            });
          }
        } else {
          Future.delayed(const Duration(milliseconds: 500), () {
            AppDialog().showPaymentFailedDialog();
          });

          result = "Flow Incomplete";
        }
      }).catchError((error) {
        handleError(error);
        return error;
      });
    } catch (error) {
      handleError(error);
    }
  }

  void showSuccessDialog(String paymentId, String type) {
    AppDialog().showPaymentSuccessDialog(type);
  }

}
