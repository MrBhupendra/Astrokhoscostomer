import 'package:astro_brahmand/model/success_model.dart';
import 'package:astro_brahmand/utill/app_dialogs.dart';
import 'package:astro_brahmand/utill/app_events.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:astro_brahmand/utill/app_constants.dart';
import 'dart:async';
import '../model/razorpay_model.dart';
import '../model/razorpay_qr_model.dart';
import '../utill/shared_preference.dart';
import '../view/widget/custom_progress_dialog.dart';
import '../view/screen/payment/razorpay_qr_payment_screen.dart';
import '../view/screen/payment/razorpay_qr_payment_success_screen.dart';
import '../view/screen/wallet/controller/wallet_controller.dart';

class RazorpayController extends GetxController {
  late Razorpay _razorpay;
  String _type = '';
  String _userId = '';
  num? _amount = 0;
  String _lastOrderIdForQr = '';
  String _walletIdForQr = '';
  DateTime? _qrCreatedAt;

  static const Duration _qrExpiryDuration = Duration(minutes: 15);

  final Dio _dio = Dio();
  final isUpdateLoading = false.obs;
  final isUpdateSuccess = false.obs;
  SuccessModel successModel = SuccessModel();

  // QR flow — single active flag + expiry (no duplicate capture/screen flags)
  final isQrExpired = false.obs;
  final isQrTimerStarted = false.obs;
  final qrRemainingTimeText = '--:--'.obs;
  final qrImageUrl = ''.obs;
  final qrId = ''.obs;
  final qrStatusText = 'Waiting for payment confirmation...'.obs;
  final qrError = ''.obs;

  Timer? _qrPollTimer;
  Timer? _qrCountdownTimer;
  bool _isQrFlowActive = false;
  bool _qrExpiryTimerStarted = false;

  String get walletIdForQr => _walletIdForQr;
  num get amountForQr => _amount ?? 0;
  bool get canCheckQrPayment => _isQrFlowActive && !isQrExpired.value;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }

  @override
  void onClose() {
    endQrFlow();
    _razorpay.clear();
    super.onClose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint("Razorpay Payment Success");
    try {
      AppEvents().sendPaymentSuccessEvent(
        _amount.toString(),
        response.orderId.toString(),
        _userId.toString(),
        _type,
      );
    } catch (e) {
      debugPrint("Error Event _handlePaymentSuccess: $e");
    }
    updateOnlinePayment(
        response.orderId.toString(), response.paymentId.toString());
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

  void openCheckout(
    PaymentGateway paymentGateway,
    String description,
    String? userUniId,
    String type,
  ) {
    _type = type;
    _userId = userUniId.toString();
    _amount = paymentGateway.amount;
    final mobile = paymentGateway.phone ?? '8888888888';
    final email = paymentGateway.email ?? '8888888888@gmail.com';

    final options = {
      'key': paymentGateway.razorpayId,
      'amount': int.parse("100") * paymentGateway.amount!,
      'order_id': paymentGateway.orderId,
      'name': AppConstants.appName,
      'description': description,
      'prefill': {'contact': mobile, 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      CustomSnackBar.showBottom("Something went wrong.Please try again.");
      debugPrint("RazorpayController (onException) $e");
    }

    try {
      AppEvents().sendInitCheckoutEvent(
        paymentGateway.amount.toString(),
        paymentGateway.orderId.toString(),
        userUniId.toString(),
        type,
      );
    } catch (e) {
      debugPrint("Error Event openCheckout: $e");
    }
  }

  /// Opens QR screen and starts polling. QR data comes from proceedPaymentRequest.
  void startQrPaymentFromProceedResponse({
    required String qrIdValue,
    required String imageUrl,
    required String orderId,
    required num amount,
    required String? userUniId,
    required String type,
    required String walletId,
  }) {
    final qrIdVal = qrIdValue.trim();
    final imageUrlVal = imageUrl.trim();

    if (qrIdVal.isEmpty || imageUrlVal.isEmpty) {
      CustomSnackBar.showBottom("QR not available. Please try again.");
      return;
    }

    _type = type;
    _userId = userUniId.toString();
    _amount = amount;
    _lastOrderIdForQr = orderId;
    _walletIdForQr = walletId;
    _qrCreatedAt = null;
    _qrExpiryTimerStarted = false;

    qrError('');
    qrId(qrIdVal);
    qrImageUrl(imageUrlVal);
    isQrExpired(false);
    isQrTimerStarted(false);
    qrRemainingTimeText('--:--');
    qrStatusText('Waiting for payment confirmation...');
    _isQrFlowActive = true;

    stopQrPolling();
    _stopQrCountdown();
    _startQrPolling();
    Get.to(() => const RazorpayQrPaymentScreen());

    try {
      AppEvents().sendInitCheckoutEvent(
        amount.toString(),
        orderId,
        userUniId.toString(),
        type,
      );
    } catch (e) {
      debugPrint("Error Event startQrPaymentFromProceedResponse: $e");
    }
  }

  void markQrExpired() {
    if (!_isQrFlowActive || isQrExpired.value) return;
    isQrExpired(true);
    stopQrPolling();
    _stopQrCountdown();
    qrRemainingTimeText('00:00');
    qrStatusText('QR expired. Please generate a new QR to continue.');
  }

  /// Starts 15-minute expiry countdown after QR image is loaded on screen.
  void startQrExpiryTimer() {
    if (_qrExpiryTimerStarted || !_isQrFlowActive || isQrExpired.value) {
      return;
    }
    _qrExpiryTimerStarted = true;
    isQrTimerStarted(true);
    _qrCreatedAt = DateTime.now();
    qrRemainingTimeText('15:00');
    _startQrCountdown();
    _checkQrExpiry();
  }

  void regenerateQr() {
    if (_walletIdForQr.isEmpty) return;
    endQrFlow();
    if (Get.key.currentState?.canPop() ?? false) {
      Get.back();
    }
    Get.find<WalletController>().proceedPaymentRequest(
      _walletIdForQr,
      AppConstants.payRazorpayQr,
    );
  }

  void _checkQrExpiry() {
    if (_qrCreatedAt == null) return;

    final expiry = _qrCreatedAt!.add(_qrExpiryDuration);
    if (DateTime.now().isAfter(expiry)) {
      markQrExpired();
    }
  }

  void _startQrCountdown() {
    _updateQrRemainingTime();
    _qrCountdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _checkQrExpiry();
      _updateQrRemainingTime();
    });
  }

  void _updateQrRemainingTime() {
    if (_qrCreatedAt == null || isQrExpired.value) {
      qrRemainingTimeText('00:00');
      return;
    }

    final expiry = _qrCreatedAt!.add(_qrExpiryDuration);
    final remaining = expiry.difference(DateTime.now());

    if (!remaining.isNegative && remaining > Duration.zero) {
      final minutes =
          remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
      final seconds =
          remaining.inSeconds.remainder(60).toString().padLeft(2, '0');
      qrRemainingTimeText('$minutes:$seconds');
      return;
    }

    qrRemainingTimeText('00:00');
  }

  void _stopQrCountdown() {
    _qrCountdownTimer?.cancel();
    _qrCountdownTimer = null;
  }

  void _startQrPolling() {
    if (qrId.value.isEmpty || !_isQrFlowActive || isQrExpired.value) return;

    _verifyQrPaymentOnce();
    _qrPollTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _verifyQrPaymentOnce();
    });
  }

  Future<void> checkQrPaymentStatusOnce() async {
    if (!canCheckQrPayment) return;
    await _verifyQrPaymentOnce();
  }

  Future<void> _verifyQrPaymentOnce() async {
    if (!_isQrFlowActive || isQrExpired.value) return;
    if (qrId.value.isEmpty) return;

    _checkQrExpiry();
    if (isQrExpired.value) return;

    try {
      final apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      final uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(
        AppConstants.razorpayQrVerify,
        data: {
          'api_key': apiKey,
          'user_uni_id': uniId,
          'qr_id': qrId.value,
        },
      );

      if (response.statusCode == 200) {
        final verifyResp = RazorpayQrVerifyResponse.fromJson(response.data);

        if (_isPaymentCaptured(verifyResp)) {
          final paymentId = _resolvePaymentId(verifyResp);
          if (paymentId.isNotEmpty) {
            qrStatusText('Payment received successfully');
            _openSuccessScreen(paymentId);
            return;
          }
        }

        final pendingMsg = verifyResp.msg?.trim().toLowerCase() ?? '';
        if (pendingMsg.contains('pending')) {
          qrStatusText('Waiting for payment confirmation...');
        } else if (pendingMsg.isNotEmpty) {
          qrStatusText(verifyResp.msg!.trim());
        } else {
          qrStatusText('Please complete the payment using any UPI app');
        }
      }
    } catch (e) {
      qrStatusText('Still waiting... (network issue, retrying)');
      debugPrint('OnException _verifyQrPaymentOnce==> ${e.toString()}');
    }
  }

  bool _isPaymentCaptured(RazorpayQrVerifyResponse response) {
    return response.status == AppConstants.success &&
        response.isPaid == 1 &&
        _resolvePaymentId(response).isNotEmpty;
  }

  String _resolvePaymentId(RazorpayQrVerifyResponse response) {
    final rootId = (response.paymentId ?? '').trim();
    if (rootId.isNotEmpty) return rootId;
    return (response.data?.id ?? '').trim();
  }

  void _openSuccessScreen(String paymentId) {
    if (!_isQrFlowActive) return;
    endQrFlow();

    try {
      AppEvents().sendPaymentSuccessEvent(
        _amount.toString(),
        _lastOrderIdForQr,
        _userId,
        _type,
      );
    } catch (e) {
      debugPrint("Error Event _openSuccessScreen: $e");
    }

    Get.off(
      () => RazorpayQrPaymentSuccessScreen(
        orderId: _lastOrderIdForQr,
        paymentId: paymentId,
        type: _type,
        amount: _amount,
      ),
    );
  }

  void stopQrPolling() {
    _qrPollTimer?.cancel();
    _qrPollTimer = null;
  }

  void endQrFlow() {
    stopQrPolling();
    _stopQrCountdown();
    _isQrFlowActive = false;
    _qrCreatedAt = null;
    _qrExpiryTimerStarted = false;
    isQrTimerStarted(false);
  }

  Future<bool> updateOnlinePayment(
    String orderId,
    String paymentId, {
    bool showSuccessDialog = true,
    bool showProgressDialog = true,
  }) async {
    if (showProgressDialog) {
      CustomProgressDialog.showDialog();
    }
    isUpdateLoading(true);
    var success = false;

    try {
      final apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      final uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final paymentMethod =
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
        successModel = SuccessModel.fromJson(response.data);
        success = successModel.status == AppConstants.success;
        isUpdateSuccess(success);
      } else {
        debugPrint('OnApiError updateOnlinePayment');
      }
    } catch (e) {
      isUpdateSuccess(false);
      debugPrint('OnException updateOnlinePayment==> ${e.toString()}');
    } finally {
      if (showProgressDialog) {
        CustomProgressDialog.dismissDialog();
      }
      isUpdateLoading(false);
      if (showSuccessDialog) {
        AppDialog().showPaymentSuccessDialog(_type);
      }
    }
    return success;
  }
}
