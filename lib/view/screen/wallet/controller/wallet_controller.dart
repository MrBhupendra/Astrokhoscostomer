import 'package:astro_brahmand/model/paypal_model.dart';
import 'package:astro_brahmand/model/payu_wallet_recharge_model.dart';
import 'package:astro_brahmand/model/phonepe_model.dart';
import 'package:astro_brahmand/model/razorpay_wallet_recharge_model.dart';
import 'package:astro_brahmand/view/screen/webview/payment_webview_screen.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:astro_brahmand/model/recharge_voucher_model.dart';
import '../../../../controller/cash_free_controller.dart';
import '../../../../controller/phonepe_controller.dart';
import '../../../../controller/razorpay_controller.dart';
import '../../../../model/cashfree_wallet_recharge_model.dart';
import '../../../../model/ccavenue_wallet_recharge_model.dart';
import '../../../../model/payment_gateway_list_model.dart';
import '../../../../model/phonepe_wallet_recharge_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_events.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/common_methods.dart';
import '../../../../utill/images.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../splash/controller/config_controller.dart';

class WalletController extends GetxController {
  final Dio _dio = Dio();
  final isVoucherLoading = false.obs;
  final isVoucherSuccess = false.obs;
  RechargeVoucherModel walletModel = RechargeVoucherModel();

  final selectedVoucherIndex = RxInt(0);
  RxString amount = '***'.obs;
  RxString gstPercent = '***'.obs;
  RxString gstAmount = '***'.obs;
  RxString giftAmount = '***'.obs;
  RxString payAmount = '***'.obs;
  RxString walletId = '0'.obs;

  final isPurchaseLoading = false.obs;
  final isPurchaseSuccess = false.obs;
  RazorpayWalletRechargeModel razorpayModel = RazorpayWalletRechargeModel();
  PaypalModel paypalModel = PaypalModel();
  // PhonePeModel phonePeModel = PhonePeModel();
  PhonepeWalletRechargeModel phonePeModel = PhonepeWalletRechargeModel();
  CcAvenueWalletRechargeModel ccAvenueModel = CcAvenueWalletRechargeModel();
  PayuWalletRechargeModel payuWalletRechargeModel = PayuWalletRechargeModel();

  final CashFreeController cashfreeController = Get.put(CashFreeController());
  CashfreeWalletRechargeModel cashfreeWalletRechargeModel = CashfreeWalletRechargeModel();

  //Multiple PG
  final ConfigController configController = Get.find();


  String? _uniqueId;
  String? _channelName;
  String? _agoraAppId;
  String? _agoraToken;
  String? _astroName;
  String? _astroImage;
  String? _astroUniId;
  int? _isVirtual;

  void setPaymentData({String? uniqueId, String? channelName, String? agoraAppId, String? agoraToken, String? astroName,
    String? astroImage,
    String? astroUniId,
    int? isVirtual,}) {
    _uniqueId = uniqueId;
    _channelName = channelName;
    _agoraAppId = agoraAppId;
    _agoraToken = agoraToken;
    _astroName = astroName;
    _astroImage = astroImage;
    _astroUniId = astroUniId;
    _isVirtual = isVirtual;
    print("callDuration===>3");
    print(uniqueId);
    print(channelName);
    print(agoraAppId);
    print(agoraToken);
    print(astroName);
    print(astroImage);
    print(astroUniId);
    print(isVirtual);
  }

  @override
  void onInit() {
    super.onInit();
    getRechargeVoucher();
    CFPaymentGatewayService().setCallback(cashfreeController.onVerify, cashfreeController.onError);
  }

  void selectVoucher(int index) {
    selectedVoucherIndex.value = index;
    walletId.value = walletModel.data![index].id.toString();
    amount.value = walletModel.data![index].walletAmount.toString();
    gstPercent.value = walletModel.data![index].gstprecent.toString();
    gstAmount.value = walletModel.data![index].gstamount.toString();
    giftAmount.value = walletModel.data![index].giftAmount.toString();
    payAmount.value = walletModel.data![index].totalamount.toString();
  }

  Future<void> getRechargeVoucher() async {
    isVoucherLoading(true);
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getRechargeVoucher, data: {
        "api_key": apiKey,
        "user_uni_id": uniId,
      });
      if (response.statusCode == 200) {
        walletModel = RechargeVoucherModel.fromJson(response.data);
        if (walletModel.status == AppConstants.success) {
          if (walletModel.data!.isNotEmpty) {
            walletId.value = walletModel.data![0].id.toString();
            amount.value = walletModel.data![0].walletAmount.toString();
            gstPercent.value = walletModel.data![0].gstprecent.toString();
            gstAmount.value = walletModel.data![0].gstamount.toString();
            giftAmount.value = walletModel.data![0].giftAmount.toString();
            payAmount.value = walletModel.data![0].totalamount.toString();
            isVoucherSuccess(true);
          } else {
            isVoucherSuccess(false);
          }
        } else {
          isVoucherSuccess(false);
          CommonMethods().showSessionExpiredDialog();
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      isVoucherSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isVoucherLoading(false);
    }
  }

  Future<void> proceedPaymentRequest(String walletId, String paymentMethod) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.proceedRechargeRequest, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "wallet_id": walletId,
        "payment_method": paymentMethod
      });

      print("Request $apiKey $uniId $walletId $paymentMethod");

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        if(paymentMethod == AppConstants.payRazorpay){
          razorpayModel = RazorpayWalletRechargeModel.fromJson(response.data);
          if (razorpayModel.status == AppConstants.success) {
            final RazorpayController razorpayController = Get.put(RazorpayController());
            razorpayController.openCheckout(razorpayModel.data!, AppStrings.walletRecharge, uniId, AppConstants.wallet);
          } else {
            CustomSnackBar.showBottom(razorpayModel.msg.toString());
          }
        }
        else if(paymentMethod == AppConstants.payCCAvenue){
          ccAvenueModel = CcAvenueWalletRechargeModel.fromJson(response.data);
          if (ccAvenueModel.status == AppConstants.success) {
            String url = "${AppConstants.ccAvenueUrl}&encRequest=${ccAvenueModel.ccavenueData!.encVal.toString()}&access_code=${ccAvenueModel.ccavenueData!.accessCode.toString()}";
            Get.to(() => PaymentWebViewScreen(AppConstants.appName,url,AppConstants.wallet,AppStrings.walletRecharge));
            try {
              AppEvents().sendInitCheckoutEvent(ccAvenueModel.data!.amount.toString(), ccAvenueModel.ccavenueData!.orderId.toString(), uniId.toString(), AppConstants.wallet);
            } catch (e) {
              debugPrint("Error Event openCheckout: $e");
            }
          } else {
            CustomSnackBar.showBottom(ccAvenueModel.msg.toString());
          }
        }
        else if(paymentMethod == AppConstants.payPayu){
          payuWalletRechargeModel = PayuWalletRechargeModel.fromJson(response.data);
          if (payuWalletRechargeModel.status == AppConstants.success) {
            // String url = "${AppConstants.ccAvenueUrl}&encRequest=${payuWalletRechargeModel.ccavenueData!.encVal.toString()}&access_code=${ccAvenueModel.ccavenueData!.accessCode.toString()}";
            Get.to(() => PaymentWebViewScreen(AppConstants.appName,payuWalletRechargeModel.payuData!.paymentLink.toString(),AppConstants.wallet,AppStrings.walletRecharge));
            try {
              AppEvents().sendInitCheckoutEvent(payuWalletRechargeModel.data!.amount.toString(), payuWalletRechargeModel.payuData!.orderId.toString(), uniId.toString(), AppConstants.wallet);
            } catch (e) {
              debugPrint("Error Event openCheckout: $e");
            }
          } else {
            CustomSnackBar.showBottom(payuWalletRechargeModel.msg.toString());
          }
        }
        else if(paymentMethod == AppConstants.payCashfree){
          cashfreeWalletRechargeModel = CashfreeWalletRechargeModel.fromJson(response.data);
          if (cashfreeWalletRechargeModel.status == AppConstants.success) {
            cashfreeController.orderId.value = cashfreeWalletRechargeModel.data!.orderId!;
            cashfreeController.sessionId.value = cashfreeWalletRechargeModel.cashfreeData!.response!.paymentSessionId!;
            cashfreeController.webCheckout(cashfreeWalletRechargeModel.data!.amount!,uniId.toString(),AppConstants.wallet);
          } else {
            CustomSnackBar.showBottom(cashfreeWalletRechargeModel.msg.toString());
          }
        }
        else if(paymentMethod == AppConstants.payPayPal){
          paypalModel = PaypalModel.fromJson(response.data);
          if (paypalModel.status == AppConstants.success) {
            Get.to(() => PaymentWebViewScreen(AppConstants.appName, paypalModel.paypalData!.url.toString(),AppConstants.wallet,AppStrings.walletRecharge));
            try {
              AppEvents().sendInitCheckoutEvent(paypalModel.data!.amount.toString(), paypalModel.paypalData!.orderId.toString(), uniId.toString(), AppConstants.wallet);
            } catch (e) {
              debugPrint("Error Event openCheckout: $e");
            }
          } else {
            CustomSnackBar.showBottom(razorpayModel.msg.toString());
          }
        }
        // else if(paymentMethod == AppConstants.payPhonePe){
        //   phonePeModel = PhonePeModel.fromJson(response.data);
        //   if (phonePeModel.status == AppConstants.success) {
        //     Get.to(() => PaymentWebViewScreen(AppConstants.appName, phonePeModel.phonePeData!.url.toString(),AppConstants.wallet,AppStrings.walletRecharge));
        //     try {
        //       AppEvents().sendInitCheckoutEvent(phonePeModel.data!.amount.toString(), phonePeModel.phonePeData!.orderId.toString(), uniId.toString(), AppConstants.wallet);
        //     } catch (e) {
        //       debugPrint("Error Event openCheckout: $e");
        //     }
        //   } else {
        //     CustomSnackBar.showBottom(phonePeModel.msg.toString());
        //   }
        // }
        else if(paymentMethod == AppConstants.payPhonePe){
          String? phonePeId = configController.config.data?.phonepeMerchantId.toString();
          phonePeModel = PhonepeWalletRechargeModel.fromJson(response.data);
          if (phonePeModel.status == AppConstants.success) {
            final PhonePeController phonePeController = Get.put(PhonePeController(phonePeId.toString()));
            phonePeController.startTransaction(phonePeModel.phonepeData!.encode.toString(),phonePeModel.phonepeData!.data!.callbackUrl.toString(),phonePeModel.phonepeData!.finalXHeader.toString(), AppConstants.wallet,phonePeModel.phonepeData!.orderId.toString(),phonePeModel.phonepeData!.orderId.toString(),
                num.parse(phonePeModel.data!.amount.toString()),
                phonePeModel.phonepeData!.data!.mobileNumber.toString(),
                uniId.toString()
            );
          } else {
            CustomSnackBar.showBottom(phonePeModel.msg.toString());
          }
        }
        else{
          CustomSnackBar.showBottom(AppStrings.noPaymentGatewayFound.tr);
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
        print('OnException==> ${e.toString()}');
      }
    }
  }

  String getUniqueIdSafe() => _uniqueId ?? "";
  String getChannelNameSafe() => _channelName ?? "";
  String getAgoraTokenSafe() => _agoraToken ?? "";
  String getAgoraAppIdSafe() => _agoraAppId ?? "";

  String getAstroNameSafe() => _astroName ?? "";

  String getAstroImageSafe() => _astroImage ?? "";

  String getAstroUniIdSafe() => _astroUniId ?? "";

  int getIsVirtualSafe() => _isVirtual ?? 0;
}
