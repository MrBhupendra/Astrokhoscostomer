import 'package:astro_brahmand/view/widget/custom_progress_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/success_model.dart';
import '../utill/app_constants.dart';
import '../utill/app_dialogs.dart';
import '../utill/app_events.dart';
import '../utill/shared_preference.dart';

class CashFreeController extends GetxController {
  RxString orderId = ''.obs;
  RxString sessionId = ''.obs;

  String _type = '';
  String _userId = '';
  num? _amount = 0;

  //Update payment
  final Dio _dio = Dio();
  final isUpdateLoading = false.obs;
  final isUpdateSuccess = false.obs;
  SuccessModel successModel = SuccessModel();

  CFSession? createSession() {
    try {
      print("orderId:::${orderId.value}");
      print("sessionId:::${sessionId.value}");
          var session = CFSessionBuilder()
          .setEnvironment(CFEnvironment.PRODUCTION)
          .setOrderId(orderId.value)
          .setPaymentSessionId(sessionId.value)
          .build();
      return session;
    } on CFException catch (e) {
      print(e.message);
    }
    return null;
  }

  webCheckout(num amount, String userUniId, String type) async {
    try {
      //For Events-->
      _type = type;
      _userId = userUniId.toString();
      _amount = amount;
      AppEvents().sendInitCheckoutEvent(
          amount.toString(), orderId.toString(), userUniId.toString(), type);
      // -->

      var session = createSession();
      var cfWebCheckout =
          CFWebCheckoutPaymentBuilder().setSession(session!).build();
      CFPaymentGatewayService().doPayment(cfWebCheckout);
    } on CFException catch (e) {
      print(e.message);
    }
  }

  void onVerify(String orderId) {
    print('success:::');
    updateOnlinePayment(
        orderId, orderId);
  }

  void onError(CFErrorResponse errorResponse, String orderId) {

    print('error:::${errorResponse.getMessage()}, $orderId');
    Future.delayed(const Duration(milliseconds: 500), () {
      AppDialog().showPaymentFailedDialog();
    });
    // Get.dialog(
    //   AlertDialog(
    //     title: const Text('Payment Failed'),
    //     actions: [
    //       ElevatedButton(
    //         onPressed: () {
    //           Get.back(); // Close the dialog
    //         },
    //         child: const Text('OK'),
    //       ),
    //     ],
    //   ),
    // );
  }

  Future<void> updateOnlinePayment(String orderId, String paymentId) async {
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
        if (kDebugMode) {
          print('OnApiSuccess updateOnlinePayment ${response.data.toString()}');
        }
        CustomProgressDialog.dismissDialog();
        var successModel = SuccessModel.fromJson(response.data);
        if (successModel.status == AppConstants.success) {
          isUpdateSuccess(true);
        } else {
          isUpdateSuccess(false);
        }
      } else {
        CustomProgressDialog.dismissDialog();
        debugPrint('OnApiError updateOnlinePayment');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      isUpdateSuccess(false);
      debugPrint('OnException updateOnlinePayment==> ${e.toString()}');
    } finally {
      isUpdateLoading(false);
      AppDialog().showPaymentSuccessDialog(_type);
      // Get.dialog(
      //   AlertDialog(
      //     title: const Text('Payment Successful'),
      //     content: Text('Payment ID: $paymentId'),
      //     actions: [
      //       ElevatedButton(
      //         onPressed: () {
      //           Get.back(); //Close Dialog
      //           if (_type.isNotEmpty) {
      //             if (_type == AppConstants.jeevini) {
      //               //JEEVINI
      //               Get.offAllNamed('/paid_orders_tab_screen',
      //                   arguments: {'index': 0});
      //             } else if (_type == AppConstants.divineCode) {
      //               //DIVINE
      //               Get.offAllNamed('/paid_orders_tab_screen',
      //                   arguments: {'index': 1});
      //             } else if (_type == AppConstants.pdfBook) {
      //               //BOOKS
      //               Get.offAllNamed('/paid_orders_tab_screen',
      //                   arguments: {'index': 2});
      //             } else if (_type == AppConstants.report) {
      //               //REPORT
      //               Get.offAllNamed('/paid_orders_tab_screen',
      //                   arguments: {'index': 3});
      //             } else if (_type == AppConstants.shop) {
      //               //SHOP
      //               Get.offAllNamed('/orders_tab_screen',
      //                   arguments: {'index': 1});
      //             } else if (_type == AppConstants.serviceOrder) {
      //               //Service
      //               Get.offAllNamed('/orders_tab_screen',
      //                   arguments: {'index': 2});
      //             } else if (_type == AppConstants.architect) {
      //               //Architect
      //               Get.offAllNamed('/architect_orders_tab_screen');
      //             } else {
      //               Get.offAllNamed('/dashboard');
      //             }
      //           } else {
      //             Get.offAllNamed('/dashboard');
      //           }
      //         },
      //         child: const Text('OK'),
      //       ),
      //     ],
      //   ),
      // );
    }
  }

  void showSuccessDialog(String paymentId, String type) {
    print(paymentId);
    print(type);
    Get.dialog(
      AlertDialog(
        title: const Text('Payment Successful'),
        content: Text('Payment ID: $paymentId'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back(); //Close Dialog
              if (type == AppConstants.jeevini) {
                //JEEVINI
                Get.offAllNamed('/paid_orders_tab_screen',
                    arguments: {'index': 0});
              } else if (type == AppConstants.divineCode) {
                //DIVINE
                Get.offAllNamed('/paid_orders_tab_screen',
                    arguments: {'index': 1});
              } else if (type == AppConstants.pdfBook) {
                //BOOKS
                Get.offAllNamed('/paid_orders_tab_screen',
                    arguments: {'index': 2});
              } else if (type == AppConstants.report) {
                //REPORT
                Get.offAllNamed('/paid_orders_tab_screen',
                    arguments: {'index': 3});
              } else if (type == AppConstants.shop) {
                //Service
                Get.offAllNamed('/orders_tab_screen', arguments: {'index': 1});
              } else if (type == AppConstants.serviceOrder) {
                //Service
                Get.offAllNamed('/orders_tab_screen', arguments: {'index': 2});
              } else if (type == AppConstants.architect) {
                //Service
                Get.offAllNamed('/architect_orders_tab_screen');
              } else if (type == "Manual Service") {
                //Service
                Get.offAllNamed('/orders_tab_screen', arguments: {'index': 3});
              } else {
                Get.offAllNamed('/dashboard');
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
