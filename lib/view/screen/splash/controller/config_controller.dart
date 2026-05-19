import 'package:get/get.dart';
import '../../../../model/payment_gateway_list_model.dart';
import '../../../../model/welcome_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/images.dart';

class ConfigController extends GetxController {
  late WelcomeModel config;
  String _currencySymbol = "\u20B9"; //Default Currency(Rs)
  String _currencyCode = "INR";
  String _phoneCode = "+91";

  String get currencyCode => _currencyCode;
  String get currencySymbol => _currencySymbol;
  String get phoneCode => _phoneCode;

  void setConfigData(WelcomeModel data) {
    config = data;
    getPaymentGateways();
    getInternationalPaymentGateways();
  }

  void setCurrency(
      {required String currencySymbol,
      required String currencyCode,
      required String phoneCode}) {
    _currencySymbol = currencySymbol;
    _currencyCode = currencyCode;
    _phoneCode = phoneCode;
  }

  var currentScreen = ''.obs;
  void setCurrentScreen(String screenName) {
    currentScreen.value = screenName;
  }

  //PaymentGateways
  List<PaymentGatewayListModel> paymentGatewayList = [];
  List<PaymentGatewayListModel> internationalPaymentGatewayList = [];

  void getPaymentGateways() {
    paymentGatewayList.clear();
    bool? razorpay = config.data?.payment?.razorpay ?? false;
    bool? ccAvenue = config.data?.payment?.ccavenue ?? false;
    bool? phonePe = config.data?.payment?.phonepe ?? false;
    bool? cashFree = config.data?.payment?.cashfree ?? false;
    bool? payU = config.data?.payment?.payu ?? false;

    if (razorpay) {
      paymentGatewayList.add(PaymentGatewayListModel(
          AppStrings.razorpay, Images.razorPay, AppConstants.payRazorpay));
      paymentGatewayList.add(PaymentGatewayListModel(
          AppStrings.razorpayQr, Images.razorPayQr, AppConstants.payRazorpayQr));
    }
    if (ccAvenue) {
      paymentGatewayList.add(PaymentGatewayListModel(
          AppStrings.ccAvenue, Images.ccAvenue, AppConstants.payCCAvenue));
    }
    if (phonePe) {
      paymentGatewayList.add(PaymentGatewayListModel(
          AppStrings.phonePe, Images.phonePe, AppConstants.payPhonePe));
    }
    if (cashFree) {
      paymentGatewayList.add(PaymentGatewayListModel(
          AppStrings.cashFree, Images.cashFree, AppConstants.payCashfree));
    }
    if (payU) {
      paymentGatewayList.add(PaymentGatewayListModel(
          AppStrings.payU, Images.payu, AppConstants.payPayu));
    }
  }

  void getInternationalPaymentGateways() {
    internationalPaymentGatewayList.clear();
    bool? paypal = config.data?.paymentForOtherCountry?.paypal ?? false;
    bool? razorpay = config.data?.paymentForOtherCountry?.razorpay ?? false;
    bool? ccAvenue = config.data?.paymentForOtherCountry?.ccavenue ?? false;
    bool? phonePe = config.data?.paymentForOtherCountry?.phonepe ?? false;
    bool? cashFree = config.data?.paymentForOtherCountry?.cashfree ?? false;
    bool? payU = config.data?.paymentForOtherCountry?.payu ?? false;

    if (paypal) {
      internationalPaymentGatewayList.add(PaymentGatewayListModel(
          AppStrings.payPal, Images.paypal, AppConstants.payPayPal));
    }
    if (razorpay) {
      internationalPaymentGatewayList.add(PaymentGatewayListModel(
          AppStrings.razorpay, Images.razorPay, AppConstants.payRazorpay));
      internationalPaymentGatewayList.add(PaymentGatewayListModel(
          AppStrings.razorpayQr, Images.razorPayQr, AppConstants.payRazorpayQr));
    }
    if (ccAvenue) {
      internationalPaymentGatewayList.add(PaymentGatewayListModel(
          AppStrings.ccAvenue, Images.ccAvenue, AppConstants.payCCAvenue));
    }
    if (phonePe) {
      internationalPaymentGatewayList.add(PaymentGatewayListModel(
          AppStrings.phonePe, Images.phonePe, AppConstants.payPhonePe));
    }
    if (cashFree) {
      internationalPaymentGatewayList.add(PaymentGatewayListModel(
          AppStrings.cashFree, Images.cashFree, AppConstants.payCashfree));
    }
    if (payU) {
      internationalPaymentGatewayList.add(PaymentGatewayListModel(
          AppStrings.payU, Images.payu, AppConstants.payPayu));
    }
  }
}
