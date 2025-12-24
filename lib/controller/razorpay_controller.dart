import 'package:astro_brahmand/model/success_model.dart';
import 'package:astro_brahmand/utill/app_dialogs.dart';
import 'package:astro_brahmand/utill/app_events.dart';
import 'package:astro_brahmand/view/widget/custom_payment_status_dialog.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:astro_brahmand/utill/app_constants.dart';
import '../model/razorpay_model.dart';
import '../utill/app_strings.dart';
import '../utill/color_resources.dart';
import '../utill/images.dart';
import '../utill/shared_preference.dart';
import '../view/widget/custom_progress_dialog.dart';

class RazorpayController extends GetxController {
  //Razorpay
  late Razorpay _razorpay;
  String _type = '';
  String _userId = '';
  num? _amount = 0;

  //Update payment
  final Dio _dio = Dio();
  final isUpdateLoading = false.obs;
  final isUpdateSuccess = false.obs;
  SuccessModel successModel = SuccessModel();

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint("Razorpay Payment Success");
    try {
      AppEvents().sendPaymentSuccessEvent(_amount.toString(), response.orderId.toString(), _userId.toString(),  _type);
    } catch (e) {
      debugPrint("Error Event _handlePaymentSuccess: $e");
    }
    updateOnlinePayment(response.orderId.toString(), response.paymentId.toString());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint("Razorpay Payment Error: ${response.code}, ${response.message}");

    Future.delayed(const Duration(milliseconds: 500), () {
     AppDialog().showPaymentFailedDialog();
    });

  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint("External Wallet: ${response.walletName}");
  }

  void openCheckout(PaymentGateway paymentGateway, String description, String? userUniId, String type) {
    _type = type;
    _userId = userUniId.toString();
    _amount = paymentGateway.amount;
    String? mobile = paymentGateway.phone ?? '8888888888';
    String? email = paymentGateway.email ?? '8888888888@gmail.com';

    var options = {
      'key': paymentGateway.razorpayId,
      'amount': int.parse("100") * paymentGateway.amount!, // Convert to paise
      'order_id': paymentGateway.orderId,
      'name': AppConstants.appName,
      'description': description,
      'prefill': {'contact': mobile, 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };
    debugPrint("RazorpayController (openCheckout) $options");
    try{
      _razorpay.open(options);
    }catch(e){
      CustomSnackBar.showBottom("Something went wrong.Please try again.");
      debugPrint("RazorpayController (onException) $e");
    }

    try {
      AppEvents().sendInitCheckoutEvent(paymentGateway.amount.toString(), paymentGateway.orderId.toString(), userUniId.toString(), type);
    } catch (e) {
      debugPrint("Error Event openCheckout: $e");
    }
  }

  Future<void> updateOnlinePayment(String orderId, String paymentId) async {
    CustomProgressDialog.showDialog();
    isUpdateLoading(true);

    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? paymentMethod = await SharedPreferencesHelper.getData(AppConstants.paymentGateway);
      final response = await _dio.post(AppConstants.updatePaymentRequest, data: {
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
        successModel = SuccessModel.fromJson(response.data);
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
    }
  }
}
