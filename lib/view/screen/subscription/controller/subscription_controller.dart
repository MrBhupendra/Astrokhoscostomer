import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../controller/phonepe_controller.dart';
import '../../../../controller/razorpay_controller.dart';
import '../../../../model/ccavenue_wallet_recharge_model.dart';
import '../../../../model/paypal_model.dart';
import '../../../../model/phonepe_model.dart';
import '../../../../model/razorpay_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_dialogs.dart';
import '../../../../utill/app_events.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/common_methods.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_checkbox.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../splash/controller/config_controller.dart';
import '../../webview/payment_webview_screen.dart';
import '../model/subscription_calculation_model.dart';
import '../model/subscription_list_model.dart';
import '../model/subscription_purchase_model.dart';

class SubscriptionController extends GetxController{
  final Dio _dio = Dio();

  final isSubscriptionLoading = false.obs;
  final isSubscriptionSuccess = false.obs;
  SubscriptionListModel subscriptionListModel = SubscriptionListModel();

  final isCalculationLoading = false.obs;
  final isCalculationSuccess = false.obs;
  SubscriptionCalculationModel subscriptionCalculationModel = SubscriptionCalculationModel();


  final isSubscriptionPurchaseListLoading = false.obs;
  final isSubscriptionPurchaseListSuccess = false.obs;
  SubscriptionPurchaseModel subscriptionPurchaseModel = SubscriptionPurchaseModel();

  RxString walletPayableAmount = '0'.obs;
  RxString gstAmount = '0'.obs;
  RxString totalPayableAmount = '0'.obs;

  RazorpayModel razorpayModel = RazorpayModel();
  PaypalModel paypalModel = PaypalModel();
  PhonepeModel phonePeModel = PhonepeModel();
  CcAvenueWalletRechargeModel ccAvenueModel = CcAvenueWalletRechargeModel();


  // Search
  final searchQuery = ''.obs;
  Timer? debounce;
  num offsetCount = 0;

  final ConfigController configController = Get.find();

  void searchSubscription(String query) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(seconds: 1), () {
      searchQuery.value = query;
      offsetCount = 0;
      getSubscriptionList("", query);
    });
  }

  Future<void> getSubscriptionList(String offset, String search) async {
    isSubscriptionLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getSubscriptionList,
          data: {
            'api_key': apiKey,
            'user_uni_id': uniId,
            'offset': offset,
            "search": search,
      });
      if (response.statusCode == 200) {
        subscriptionListModel = SubscriptionListModel.fromJson(response.data);
        if (subscriptionListModel.status == AppConstants.success) {
          isSubscriptionSuccess(true);
        } else {
          isSubscriptionSuccess(false);
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      isSubscriptionSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isSubscriptionLoading(false);
    }
  }


  Future<void> getSubscriptionCalculation(String subscriptionAssignId, String action) async {
    CustomProgressDialog.showDialog();
    isCalculationLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getSubscriptionCalculation, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "subscription_id": subscriptionAssignId,
        "offer_code": "",
        "wallet_check": "",
        "is_updated": "",
      });
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        subscriptionCalculationModel = SubscriptionCalculationModel.fromJson(response.data);
        if (subscriptionCalculationModel.status == AppConstants.success) {
          isCalculationSuccess(true);

          walletPayableAmount.value = subscriptionCalculationModel.data!.walletAmount.toString();

          gstAmount.value = subscriptionCalculationModel.data!.rechargeGstValue.toString();

          totalPayableAmount.value = subscriptionCalculationModel.data!.payableAmount.toString();

          if (action == "Open") {
            _showCalculationBottomSheet(subscriptionAssignId,subscriptionCalculationModel.data,);
          }
        } else {
          CustomSnackBar.showBottom(subscriptionCalculationModel.msg.toString());
          isCalculationSuccess(false);
        }
      } else {
        CustomProgressDialog.dismissDialog();
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      isCalculationSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isCalculationLoading(false);
    }
  }

  void _showCalculationBottomSheet(
      String subscriptionId,
      SubscriptionData? subscriptionData,
      ) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Row(
                    children: [
                      // const Gap(20),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2),
                          child: Image.asset(
                            Images.back,
                            height: 24,
                            color: ColorResources.black,
                          ),
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                          child: CustomTextMedium(AppStrings.paymentInformation.tr,
                              color: ColorResources.black1,
                              fontSize: Dimensions.fontSizeLarge)),

                      // const Gap(10),
                    ],
                  ),
                ),
                const Divider(),
                Container(
                  decoration: BoxDecoration(
                      color: ColorResources.white,
                      borderRadius:
                      BorderRadius.circular(Dimensions.borderRadiusDefault),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        )
                      ]),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 6),
                        //   child: CustomTextMedium(
                        //     AppStrings.importantNotice,
                        //     color: ColorResources.colorPrimary,
                        //     fontSize: Dimensions.fontSizeOverSmall,
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: CustomTextMedium(
                            AppStrings.subscriptionDetail,
                            color: ColorResources.colorPrimary,
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomTextRegular(
                                  "Name",
                                  color: ColorResources.black1,
                                ),
                              ),
                              Expanded(
                                child: CustomTextRegular(subscriptionData!.subscriptionDetail!.title.toString(),
                                  color: ColorResources.black1,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextRegular(
                                "Price",
                                color: ColorResources.black1,
                              ),
                              CustomTextRegular(
                                "${AppConstants.defaultCurrencySymbol}${subscriptionData.subscriptionDetail!.price}",
                                color: ColorResources.black1,
                              ),
                            ],
                          ),
                        ),

                        // Obx(() => Visibility(
                        //   visible: isWalletSelected.value == 1,
                        //   child: Padding(
                        //     padding:
                        //     const EdgeInsets.symmetric(vertical: 4),
                        //     child: Row(
                        //       mainAxisAlignment:
                        //       MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         CustomTextRegular(
                        //           "Wallet",
                        //           color: ColorResources.black1,
                        //         ),
                        //         Obx(() => CustomTextRegular(
                        //           "${configController.currencySymbol} ${walletPayableAmount.value}",
                        //           color: ColorResources.black1,
                        //         )),
                        //       ],
                        //     ),
                        //   ),
                        // )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextRegular(
                                "GST ${subscriptionData.rechargeGstPercent}%",
                                color: ColorResources.black1,
                              ),
                              Obx(() => CustomTextRegular(
                                "${AppConstants.defaultCurrencySymbol}${gstAmount.value}",
                                color: ColorResources.black1,
                              )),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextMedium("Total Payable",
                                  color: ColorResources.black),
                              Obx(() => CustomTextMedium(
                                  "${AppConstants.defaultCurrencySymbol}${totalPayableAmount.value}",
                                  color: ColorResources.colorPrimary)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                const Gap(10),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraOverSmall),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          CommonMethods().showPaymentMethodBottomSheet(configController.phoneCode == AppConstants.defaultPhoneCode ? false : true,
                              onItemSelected: (int index){
                                if(configController.phoneCode == AppConstants.defaultPhoneCode){
                                  subscriptionPurchase(
                                      subscriptionId,
                                       configController.paymentGatewayList[index].payMethod.toString()
                                  );
                                }else{
                                  subscriptionPurchase(
                                      subscriptionId,
                                      configController.internationalPaymentGatewayList[index].payMethod.toString()
                                  );
                                }
                              }
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextRegular(
                              "Pay Using",
                              fontSize: Dimensions.fontSizeSmall,
                              color: ColorResources.black2,
                            ),
                            Row(
                              children: [
                                CustomTextMedium(
                                    configController.phoneCode == AppConstants.defaultPhoneCode
                                        ? configController.config.data!.payment!.defaultPaymentGateway.toString()
                                        : configController.config.data!.paymentForOtherCountry!.defaultPaymentGateway.toString(),
                                    fontSize: Dimensions.fontSizeSmall
                                ),
                                const Icon(Icons.arrow_drop_up)
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            String? defaultPayMethod = configController.config.data?.payment?.defaultPaymentGateway.toString();
                            String? defaultPayMethodInternational = configController.config.data?.paymentForOtherCountry?.defaultPaymentGateway.toString();
                            if(configController.phoneCode == AppConstants.defaultPhoneCode){
                              subscriptionPurchase(
                                  subscriptionId,
                                  defaultPayMethod.toString()
                              );
                            }else {
                              subscriptionPurchase(
                                  subscriptionId,
                                  defaultPayMethodInternational.toString()
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorResources.colorPrimary,
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 14, right: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: CustomTextMedium(
                            AppStrings.proceedToPay,
                            color: ColorResources.toolbarText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/wallet");
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextMedium("Recharge",
                            color: ColorResources.colorPrimary),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Future<void> subscriptionPurchase(String subscriptionId,String paymentMethod) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.subscriptionPurchase, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "subscription_id": subscriptionId,
        "offer_code": "",
        "reference_id": 0,
        "wallet_check": 0,
        "payment_method": paymentMethod
      });

      if (kDebugMode) {
        print("Req data $apiKey $uniId $subscriptionId $paymentMethod");
      }

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        if(paymentMethod == AppConstants.payRazorpay){
          razorpayModel = RazorpayModel.fromJson(response.data);
          if (razorpayModel.status == AppConstants.success) {
            final RazorpayController razorpayController = Get.put(RazorpayController());
            if (razorpayModel.paymentGatewayStatus == AppConstants.success) {
              razorpayController.openCheckout(razorpayModel.paymentGateway!,"Subscription Purchase", uniId,AppConstants.subscriptionOrder);
            } else {
              AppDialog().showPaymentSuccessDialog(AppConstants.subscriptionOrder);
            }
          } else {
            CustomSnackBar.showBottom(razorpayModel.msg.toString());
          }
        }
        else if(paymentMethod == AppConstants.payCCAvenue){
          ccAvenueModel = CcAvenueWalletRechargeModel.fromJson(response.data);
          if (ccAvenueModel.status == AppConstants.success) {
            if (ccAvenueModel.paymentGatewayStatus == AppConstants.success) {
              String url = "${AppConstants.ccAvenueUrl}&encRequest=${ccAvenueModel.ccavenueData!.encVal.toString()}&access_code=${ccAvenueModel.ccavenueData!.accessCode.toString()}";
              Get.to(() => PaymentWebViewScreen(AppConstants.appName,url,AppConstants.subscriptionOrder,"Subscription Purchase"));
              try {
                AppEvents().sendInitCheckoutEvent(ccAvenueModel.data!.amount.toString(), ccAvenueModel.ccavenueData!.orderId.toString(), uniId.toString(), AppConstants.groupPoojaOrder);
              } catch (e) {
                debugPrint("Error Event openCheckout: $e");
              }
            }else{
              AppDialog().showPaymentSuccessDialog(AppConstants.subscriptionOrder);
            }
          } else {
            CustomSnackBar.showBottom(ccAvenueModel.msg.toString());
          }
        }
        // else if(paymentMethod == AppConstants.payPayPal){
        //   paypalModel = PaypalModel.fromJson(response.data);
        //   if (paypalModel.status == AppConstants.success) {
        //     if (paypalModel.paymentGatewayStatus == AppConstants.success) {
        //       Get.to(() => PaymentWebViewScreen(AppConstants.appName, paypalModel.paypalData!.url.toString(),AppConstants.groupPoojaOrder,"Group Pooja Purchase"));
        //       try {
        //         AppEvents().sendInitCheckoutEvent(paypalModel.data!.amount.toString(), paypalModel.paypalData!.orderId.toString(), uniId.toString(), AppConstants.groupPoojaOrder);
        //       } catch (e) {
        //         debugPrint("Error Event openCheckout: $e");
        //       }
        //     }else{
        //       AppDialog().showPaymentSuccessDialog(AppConstants.groupPoojaOrder);
        //     }
        //   } else {
        //     CustomSnackBar.showBottom(paypalModel.msg.toString());
        //   }
        // }
        else if(paymentMethod == AppConstants.payPhonePe){
          String? phonePeId = configController.config.data?.phonepeMerchantId.toString();
          phonePeModel = PhonepeModel.fromJson(response.data);
          if (phonePeModel.status == AppConstants.success) {
            if (phonePeModel.paymentGatewayStatus == AppConstants.success) {
              // Get.to(() => PaymentWebViewScreen(AppConstants.appName, phonePeModel.phonepeData!.url.toString(),AppConstants.shop,"Product Purchase"));
              // try {
              //   AppEvents().sendInitCheckoutEvent(phonePeModel.data!.amount.toString(), phonePeModel.phonepeData!.orderId.toString(), uniId.toString(), AppConstants.shop);
              // } catch (e) {
              //   debugPrint("Error Event openCheckout: $e");
              // }
              final PhonePeController phonePeController = Get.put(PhonePeController(phonePeId.toString()));
              phonePeController.startTransaction(phonePeModel.phonepeData!.encode.toString(),phonePeModel.phonepeData!.data!.callbackUrl.toString(),phonePeModel.phonepeData!.finalXHeader.toString(), AppConstants.subscriptionOrder,phonePeModel.phonepeData!.orderId.toString(),phonePeModel.phonepeData!.orderId.toString(),
                  num.parse(phonePeModel.paymentGatewayData!.amount.toString()),
                  phonePeModel.phonepeData!.data!.mobileNumber.toString(),
                  uniId.toString()
              );
            }
            else{
              AppDialog().showPaymentSuccessDialog(AppConstants.shop);
            }
          } else {
            CustomSnackBar.showBottom(phonePeModel.msg.toString());
          }
        }
        //TODO Handle Phonepe
      } else {
        CustomProgressDialog.dismissDialog();
        if (kDebugMode) {print('OnApiError');}
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      if (kDebugMode) {print('OnException==> ${e.toString()}');}
    }
  }


  Future<void> getSubscriptionPurchaseList() async {
    isSubscriptionPurchaseListLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.subscriptionPurchaseList,
          data: {
            'api_key': apiKey,
            'user_uni_id': uniId,
            'offset': 0,
            'payment_status': 1,
          });

      print("apiKey => $apiKey");
      print("uniId => $uniId");


      if (response.statusCode == 200) {
        subscriptionPurchaseModel = SubscriptionPurchaseModel.fromJson(response.data);
        if (subscriptionPurchaseModel.status == AppConstants.success) {
          isSubscriptionPurchaseListSuccess(true);
        } else {
          isSubscriptionPurchaseListSuccess(false);
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      isSubscriptionPurchaseListSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isSubscriptionPurchaseListLoading(false);
    }
  }

}