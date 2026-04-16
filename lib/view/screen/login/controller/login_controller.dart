import 'dart:async';

import 'package:astro_brahmand/controller/deeplink_controller.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/model/success_model.dart';
import 'package:astro_brahmand/model/verify_customer_model.dart';
import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phonecodes/phonecodes.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/app_events.dart';
import '../../../../utill/app_features.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_default_dialog.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../splash/controller/config_controller.dart';

class LoginController extends GetxController {
  /// Google Login
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: AppConstants.defaultWebClientId,
    scopes: [
      'email',
      'profile',
    ],
  );
  /// Google end


  final Dio _dio = Dio();
  final TextEditingController mobileController = TextEditingController();
  String mobileNumber = "";
  final RxString countryCode = '+91'.obs;
  final RxString countryName = 'India'.obs;
  String _otpOrderId = "";
  final RxString phoneNumber = ''.obs;
  final RxString otpValue = ''.obs;

  var isVerifying = false.obs;
  var isSendingOtp = false.obs;


  //Verify
  final TextEditingController otpController = TextEditingController();

  late OTPTextEditController otpTextEditController;
  late OTPInteractor _otpInteractor;

  // resend otp time
  late Timer _timer = Timer(Duration.zero, () {});
  RxInt remainingTime = 0.obs;
  RxBool canResendOtp = true.obs;

  SuccessModel otpModel = SuccessModel();
  VerifyCustomerModel verifyCustomerModel = VerifyCustomerModel();

  ConfigController configController = Get.find();
  DeepLinkController deepLinkController = Get.find();

  String regionCode = "IN";

  @override
  void onInit() {
    super.onInit();
    _dio.options = _dio.options.copyWith(
      connectTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 25),
    );
    CommonMethods().getFCMToken();
    if (AppFeatures.otpAutoFill) {
      _initOTPListener();
    }
  }

  @override
  void onClose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.onClose();
  }

  void updateCountryCode(CountryCode code) {
    countryCode.value = code.dialCode.toString();
    countryName.value = code.name.toString();
  }

  Future<void> loginClick() async {
    final phone = mobileController.text.trim();

    if (phone.isEmpty) {
      CustomSnackBar.showBottom(AppStrings.phoneError.tr);
      return;
    }

    if (countryCode.value == "+91" && phone.length != 10) {
      CustomSnackBar.showBottom(AppStrings.validPhoneError.tr);
      return;
    }

    isSendingOtp.value = true;
    otpController.text = "";
    phoneNumber.value = countryCode.value + phone;

    try {
      await sendOtp(
        countryCode.value,
        countryCode.value + phone,
      );
    } catch (e) {
      CustomSnackBar.showBottom("OTP sending failed: $e");
    } finally {
      isSendingOtp.value = false;
    }
  }

  /*void loginClick() {
    if (mobileController.text.isEmpty) {
      CustomSnackBar.showBottom(AppStrings.phoneError.tr);
      return;
    }
    if (countryCode.value == "+91" && mobileController.text.length != 10) {
      CustomSnackBar.showBottom(AppStrings.validPhoneError.tr);
      return;
    }
    otpController.text = "";
    phoneNumber.value = countryCode.value.toString() + mobileController.text;
    sendOtp(countryCode.value.toString(),
        countryCode.value.toString() + mobileController.text.toString());
  }*/

  void startTimer() {
    if (!canResendOtp.value) {
      _timer.cancel();
    } // Check if the timer is already running
    remainingTime.value = 30;
    canResendOtp.value = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value == 0) {
        canResendOtp.value = true;
        timer.cancel();
      } else {
        remainingTime.value--;
      }
    });
  }

  Future<void> sendOtp(String countryCode, String mobile) async {
    mobileNumber = mobile.toString();
    CustomProgressDialog.showDialog();
    try {
      final response = await _dio.post(
        AppConstants.otpSendUri,
        data: {'country_code': countryCode, 'phone': mobile},
      );
      if (response.statusCode == 200) {
        otpModel = SuccessModel.fromJson(response.data);
        if (otpModel.status == AppConstants.success) {
          _otpOrderId = response.data['otpless_orderId'] ?? "";
          // Important: close loader BEFORE navigating, otherwise dismissDialog()
          // may pop the newly pushed route instead of the dialog.
          CustomProgressDialog.dismissDialog();
          Get.toNamed('/verifyOtp');
          startTimer();
        } else {
          CustomSnackBar.showBottom(otpModel.msg.toString());
        }
      } else {
        if (kDebugMode) print('OnApiError: ${response.statusCode}');
        CustomSnackBar.showBottom("Something went wrong. Please try again.");
      }
    } catch (e) {
      if (kDebugMode) {
        print('OnException==> $e');
      }
      CustomSnackBar.showBottom("Network error. Please try again.");
    } finally {
      CustomProgressDialog.dismissDialog();
    }
  }

  //Verify OTP
  Future<void> verifyClick(String mobile) async {
    final otp = otpController.text.trim();

    if (otp.isEmpty) {
      CustomSnackBar.showBottom(AppStrings.otpError.tr);
      return;
    } else if (otp.length != 6) {
      CustomSnackBar.showBottom(AppStrings.validOtpError.tr);
      return;
    }

    isVerifying.value = true;

    try {
      await verifyOtp(mobile, otp, _otpOrderId);
    } catch (e) {
      CustomSnackBar.showBottom("Verification failed: $e");
    } finally {
      isVerifying.value = false;
    }
  }


  Future<void> verifyOtp(String mobile, String otp, String orderId) async {
    CustomProgressDialog.showDialog();
    try {
      debugPrint("mobile$mobile");
      String fcmToken = await CommonMethods().getFCMToken();
      final response = await _dio
          .post(AppConstants.verifyOtpUri, data: {
            'phone': mobile,
            'otp': otp,
            'user_fcm_token': fcmToken,
            'otpless_orderId': orderId,
            'is_updated': 1,
            'country_code': countryCode.value.toString(),
            'country_name': countryName.value.toString(),
            'referral_code': deepLinkController.referrerCode.value,
          })
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        verifyCustomerModel = VerifyCustomerModel.fromJson(response.data);
        if (verifyCustomerModel.status == AppConstants.success) {
          try {
            await FirebaseAuth.instance
                .signInWithCustomToken(
                  verifyCustomerModel.data!.firebaseAuthToken.toString(),
                )
                .timeout(const Duration(seconds: 25));
            await AppEvents().sendSignInEvent("mobile", verifyCustomerModel.data!.customerUniId.toString(), mobile.toString());
            configController.setCurrency(
                currencySymbol: verifyCustomerModel.data!.currencySymbol ?? AppConstants.defaultCurrencySymbol,
                currencyCode: verifyCustomerModel.data!.currencyCode ?? AppConstants.defaultCurrencyCode,
                phoneCode: countryCode.value.toString());

            if (verifyCustomerModel.data?.processStatus == AppConstants.success) {
              await CommonMethods().saveLoginSharedPrefData(
                  verifyCustomerModel, countryCode.value.toString(), true);
              await SharedPreferencesHelper.saveData(
                  AppConstants.phoneNumber, mobile);
              Get.offAllNamed('/dashboard');
            } else {
              await CommonMethods().saveLoginSharedPrefData(
                  verifyCustomerModel, countryCode.value.toString(), false);
              await SharedPreferencesHelper.saveData(
                  AppConstants.phoneNumber, mobile);
              Get.offAllNamed('/updateProfile',
                  arguments: {'mobile': mobile, 'type': "Register"});
            }
          } on TimeoutException {
            CustomSnackBar.showBottom("Network is slow. Please try again.");
          } on FirebaseAuthException catch (e) {
            switch (e.code) {
              case "invalid-custom-token":
                CustomSnackBar.showBottom(
                    "Invalid token.Contact Support Team.");
                debugPrint(
                    "[AUTH0] The supplied token is not a Firebase custom auth token.");
                break;
              case "custom-token-mismatch":
                CustomSnackBar.showBottom(
                    "Token Mismatch.Contact Support Team.");
                debugPrint(
                    "[AUTH0] The supplied token is for a different Firebase project.");
                break;
              default:
                CustomSnackBar.showBottom(
                    "Something went wrong.Contact Support Team.");
                debugPrint("[AUTH0] Unknown error.");
            }
          }
        } else {
          CustomSnackBar.showBottom(verifyCustomerModel.msg.toString());
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } on TimeoutException {
      CustomSnackBar.showBottom("Network is slow. Please try again.");
    } catch (e) {
      if (kDebugMode) {
        print('OnException==> $e');
      }
      CustomSnackBar.showBottom("Something went wrong. Please try again.");
    } finally {
      CustomProgressDialog.dismissDialog();
    }
  }

  Future<void> _initOTPListener() async {
    _otpInteractor = OTPInteractor();

    otpTextEditController = OTPTextEditController(
      codeLength: 6,
      onCodeReceive: (code) {
        debugPrint('code: $code');
        otpController.text = code;
        Future.delayed(Duration(seconds: 2), () {
          verifyClick(phoneNumber.value.toString());
        });
      },
      otpInteractor: _otpInteractor,
    );

    otpTextEditController.startListenUserConsent((message) {
      final exp = RegExp(r'\d{6}');

      return exp.stringMatch(message ?? '') ?? '';
    });

    final appSignature = await _otpInteractor.getAppSignature();

    debugPrint('App signature: $appSignature');
  }


  @override
  void dispose() {
    otpTextEditController.stopListen();

    otpController.dispose();

    super.dispose();
  }


  ///Google Login
  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      debugPrint("[Login] requestLocationPermissions granted");
      signInWithGoogle();
    } else if (permission == LocationPermission.deniedForever) {
      debugPrint("[Login] requestLocationPermissions deniedForever");
      await openAppSettings();
    } else {
      debugPrint("[Login] requestLocationPermissions denied");

      // Show dialog to inform the user
      CustomDefaultDialog.showOkDialog(
        "Permission Required",
        "Location permission required for Google Authentication",
            () {
          Get.back();
          // Optionally retry permission request after dialog is dismissed
          checkLocationPermission(); // Retry only once per user action
        },
      );
    }
  }


  Future<dynamic> signInWithGoogle() async {
    try {
      // Google Login
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId: configController.config.data?.gmailClientId.toString(),//AppConstants.defaultWebClientId,
        scopes: [
          'email',
          'profile',
        ],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return; //User cancelled the sign-in
      regionCode = await getCountryCode();
      Country country = Countries.findByCode(regionCode); //Ex:India,USA
      countryCode.value = country.dialCode; //Ex: +91, +1

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      // Using backend login with Google ID token; Firebase credential not required here.

      // Fetch user information
      String? customerName = googleUser.displayName;
      loginWithGmail(googleAuth.idToken.toString(),countryCode.value.toString(),regionCode.toString(),customerName.toString());
    } on Exception catch (e) {
      debugPrint('[LOGIN] exception->$e');
    }
  }

  Future<String> getCountryCode() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium,);
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,);

      if (placemarks.isNotEmpty) {
        return placemarks.first.isoCountryCode ?? 'IN';
      } else {
        debugPrint('Country not found');
        return 'IN';
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
      return 'IN';
    }
  }

  Future<void> loginWithGmail(String idToken, String countryCode, String countryName,String customerName) async {
    debugPrint("DebugPrint:$idToken");
    CustomProgressDialog.showDialog();
    try {
      String? fcmToken = await SharedPreferencesHelper.getData(AppConstants.fcmToken);
      final response = await _dio.post(AppConstants.gmailLoginUri, data: {
        'id_token': idToken,
        'user_fcm_token': fcmToken,
        'is_updated': 1,
        'country_code': countryCode,
        'country_name': countryName,
        'referral_code': '',
      });
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        verifyCustomerModel = VerifyCustomerModel.fromJson(response.data);
        if (verifyCustomerModel.status == AppConstants.success) {
          try {
            await FirebaseAuth.instance.signInWithCustomToken(
              verifyCustomerModel.data!.firebaseAuthToken.toString(),
            );
            debugPrint("Sign-in successful.");
            await AppEvents().sendSignInEvent("gmail",verifyCustomerModel.data!.customerUniId.toString(), "");
            configController.setCurrency(
                currencySymbol: verifyCustomerModel.data!.currencySymbol  ?? AppConstants.defaultCurrencySymbol,
                currencyCode: verifyCustomerModel.data!.currencyCode  ?? AppConstants.defaultCurrencyCode,
                phoneCode: countryCode.toString()
            );
            if (verifyCustomerModel.data?.processStatus == AppConstants.success) {
              await CommonMethods().saveLoginSharedPrefData(verifyCustomerModel,countryCode, true);
              await SharedPreferencesHelper.saveBoolData(AppConstants.isGoogleLogin, true);
              Get.offAllNamed('/dashboard');
            } else {
              await CommonMethods().saveLoginSharedPrefData(verifyCustomerModel,countryCode, false);
              await SharedPreferencesHelper.saveBoolData(AppConstants.isGoogleLogin, true);
              Get.offAllNamed('/updateProfile', arguments: {
                'type': "Register",
                'email': verifyCustomerModel.data!.email.toString(),
                'mobile': "",
                'name': customerName,
                'regionCode': countryCode
              });
            }
          } on FirebaseAuthException catch (e) {
            switch (e.code) {
              case "invalid-custom-token":
                CustomSnackBar.showBottom("Invalid token.Contact Support Team.");
                debugPrint("[AUTH0] The supplied token is not a Firebase custom auth token.");
                break;
              case "custom-token-mismatch":
                CustomSnackBar.showBottom("Token Mismatch.Contact Support Team.");
                debugPrint("[AUTH0] The supplied token is for a different Firebase project.");
                break;
              default:
                CustomSnackBar.showBottom("Something went wrong.Contact Support Team.");
                debugPrint("[AUTH0] Unknown error.");
            }
          }
        } else {
          CustomSnackBar.showBottom(verifyCustomerModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      if (kDebugMode) {
        print('OnException==> $e');
      }
    }
  }

  Future<void> handleSignOut() => _googleSignIn.disconnect();

/// Google end
}
