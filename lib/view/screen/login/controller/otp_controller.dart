import 'package:astro_brahmand/view/screen/login/controller/sample_strategy.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:otp_autofill/otp_autofill.dart';


// OTPController to manage OTP logic
class OTPController extends GetxController {
  final scaffoldKey = GlobalKey();
  late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;

  @override
  void onInit() {
    super.onInit();
    _initInteractor();
    controller = OTPTextEditController(
      codeLength: 6,
      //ignore: avoid_print
      onCodeReceive: (code) => print('Your Application receive code - $code'),
      otpInteractor: _otpInteractor,
    )..startListenUserConsent(
          (code) {
        final exp = RegExp(r'(\d{6})');
        return exp.stringMatch(code ?? '') ?? '';
      },
      strategies: [
        SampleStrategy(),
      ],
    );
  }

  Future<void> _initInteractor() async {
    _otpInteractor = OTPInteractor();

    final appSignature = await _otpInteractor.getAppSignature();

    if (kDebugMode) {
      print('Your app signature: $appSignature');
    }
  }

  @override
  void onClose() {
    controller.stopListen();
    super.onClose();
  }
}