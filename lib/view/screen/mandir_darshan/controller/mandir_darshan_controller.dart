import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../controller/phonepe_controller.dart';
import '../../../../controller/razorpay_controller.dart';
import '../../../../model/ccavenue_wallet_recharge_model.dart';
import '../../../../model/live_temple_darshan_calculation_model.dart';
import '../../../../model/paypal_model.dart';
import '../../../../model/phonepe_model.dart';
import '../../../../model/razorpay_model.dart';
import '../../../../model/success_model.dart';
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
import '../model/mandir_assign_list_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class MandirDarshanController extends GetxController {
  final Dio _dio = Dio();

  //Mandir Darshan
  final isMandirLoading = false.obs;
  final isMandirSuccess = false.obs;
  MandirAssignListModel mandirAssignModel = MandirAssignListModel();
  List<MandirAssignData> mandirAssignListData = [];

  //Join
  SuccessModel liveJoinModel = SuccessModel();

  final ConfigController configController = Get.find();

  // Manage product (Calculation)
  final isCalculationLoading = false.obs;
  final isCalculationSuccess = false.obs;
  final isWalletSelected = 0.obs;
  RxString myWalletAmount = '0'.obs;
  RxString walletPayableAmount = '0'.obs;
  RxString totalPayableAmount = '0'.obs;
  RxString subTotalAmount = '0'.obs;
  RxString gstPercent = '0'.obs;
  RxString gstAmount = '0'.obs;
  RxString refDiscount = '0'.obs;
  RxString refId = ''.obs;
  LiveTempleDarshanCalculationModel liveTempleDarshanCalculationModel = LiveTempleDarshanCalculationModel();

  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController birthTimeController = TextEditingController();
  BuildContext? mContext;

  // Purchase
  final isPurchaseLoading = false.obs;
  final isPurchaseSuccess = false.obs;
  RazorpayModel razorpayModel = RazorpayModel();
  PaypalModel paypalModel = PaypalModel();
  PhonepeModel phonePeModel = PhonepeModel();
  CcAvenueWalletRechargeModel ccAvenueModel = CcAvenueWalletRechargeModel();

  //Mandir Darshan
  Future<void> getLiveMandirDarshan(num offset) async {
    if (offset == 0) {
      isMandirSuccess(false);
      mandirAssignListData.clear();
    }

    isMandirLoading(true);
    try {
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getLiveMandirDarshanList,data: {
        'is_live': 1,
        'customer_uni_id': uniId
      });
      AppLogger.d("responseGetLiveMandirDarshan:::$response");
      if (response.statusCode == 200) {
        mandirAssignModel = MandirAssignListModel.fromJson(response.data);
        if(mandirAssignModel.status == AppConstants.success){
          isMandirSuccess(true);

          for (var element in (mandirAssignModel.data ?? [])) {
            mandirAssignListData.add(element);
          }
        }
        else{
          if (offset == 0) {
            isMandirSuccess(false);
          }
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isMandirSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isMandirLoading(false);
    }
  }

  Future<void> joinMandirDarshan(int astrologerUID,String uniqueId, String astrologerUniId,String assignId) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? agoraAppId = await SharedPreferencesHelper.getData(AppConstants.agoraAppId);
      AppLogger.d("$apiKey $uniId $assignId Customer");
      final response = await _dio.post(AppConstants.joinMandirDarshan, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'live_temple_darshan_assign_id' : assignId,
        'started_by' : "Customer"
      });
      AppLogger.d("responseTemple:::$response");
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        liveJoinModel = SuccessModel.fromJson(response.data);
        if(liveJoinModel.status == AppConstants.success){
          String? token = response.data["token"];
          Get.toNamed('/liveStreamScreen',arguments: {
            'uniqueId': uniqueId,
            'agoraAppId': agoraAppId,
            'token': token,
            'astrologerId': astrologerUniId,
            'astrologerUID': astrologerUID
          });
          AppLogger.d("As1 Req $token $uniqueId $agoraAppId $astrologerUniId $astrologerUID");
        }else{
          CustomSnackBar.showBottom(liveJoinModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    }
  }

  Future<void> getMandirDarshanCalculation(String liveMandirDarshanAssignId,String astrologerId, int walletCheck, LiveTempleDarshan liveTempleDarshanData, String action,String duration,BuildContext context) async {
    mContext = context;
    CustomProgressDialog.showDialog();
    isCalculationLoading(true);
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getMandirDarshanCalculation, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "astrologer_uni_id": astrologerId,
        "customer_uni_id": uniId,
        "live_temple_darshan_assign_id": liveMandirDarshanAssignId,
        "wallet_check": walletCheck,
      });
      AppLogger.d(liveMandirDarshanAssignId);
      AppLogger.d(walletCheck.toString());
      AppLogger.d("responseGetMandirDarshanCalculation:::$response");
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        liveTempleDarshanCalculationModel = LiveTempleDarshanCalculationModel.fromJson(response.data);
        if (liveTempleDarshanCalculationModel.status == AppConstants.success) {
          isCalculationSuccess(true);

          isWalletSelected.value = walletCheck;

          walletPayableAmount.value =
              liveTempleDarshanCalculationModel.data!.walletAmount.toString();

          gstAmount.value =
              liveTempleDarshanCalculationModel.data!.rechargeGstValue.toString();

          totalPayableAmount.value =
              liveTempleDarshanCalculationModel.data!.payableAmount.toString();

          if (action == "Open") {
            showCalculationBottomSheet(liveMandirDarshanAssignId, astrologerId,duration,liveTempleDarshanCalculationModel.data, liveTempleDarshanData);
          }
        } else {
          CustomSnackBar.showBottom(liveTempleDarshanCalculationModel.msg.toString());
          isCalculationSuccess(false);
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiErrorGetMandirDarshanCalculation');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      isCalculationSuccess(false);
      AppLogger.d('OnExceptionGetMandirDarshanCalculation==> ${e.toString()}');
    } finally {
      isCalculationLoading(false);
    }
  }

  Future<void> purchaseMandirDarshanPooja(String liveMandirDarshanAssignId,String astrologerId,int walletCheck, String paymentMethod) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.purchaseMandirDarshanPooja, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "live_temple_darshan_assign_id": liveMandirDarshanAssignId,
        "astrologer_uni_id": astrologerId,
        "customer_uni_id": uniId,
        "wallet_check": walletCheck,
        "payment_method": paymentMethod
      });

      AppLogger.d("Req data $apiKey $uniId $liveMandirDarshanAssignId $astrologerId $uniId $walletCheck $paymentMethod");
      AppLogger.d("responsePurchaseMandirDarshanPooja:::$response");
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        if(paymentMethod == AppConstants.payRazorpay){
          razorpayModel = RazorpayModel.fromJson(response.data);
          if (razorpayModel.status == AppConstants.success) {
            final RazorpayController razorpayController = Get.put(RazorpayController());
            if (razorpayModel.paymentGatewayStatus == AppConstants.success) {
              razorpayController.openCheckout(razorpayModel.paymentGateway!,"Mandir Darshan Purchase", uniId,AppConstants.orderMandirDarshan);
            } else {
              AppDialog().showPaymentSuccessDialog(AppConstants.orderMandirDarshan);
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
              Get.to(() => PaymentWebViewScreen(AppConstants.appName,url,AppConstants.orderMandirDarshan,"Mandir Darshan Purchase"));
              try {
                AppEvents().sendInitCheckoutEvent(ccAvenueModel.data!.amount.toString(), ccAvenueModel.ccavenueData!.orderId.toString(), uniId.toString(), AppConstants.orderMandirDarshan);
              } catch (e) {
                AppLogger.d("Error Event openCheckout: $e");
              }
            }else{
              AppDialog().showPaymentSuccessDialog(AppConstants.orderMandirDarshan);
            }
          } else {
            CustomSnackBar.showBottom(ccAvenueModel.msg.toString());
          }
        }
        // else if(paymentMethod == AppConstants.payPayPal){
        //   paypalModel = PaypalModel.fromJson(response.data);
        //   if (paypalModel.status == AppConstants.success) {
        //     if (paypalModel.paymentGatewayStatus == AppConstants.success) {
        //       Get.to(() => PaymentWebViewScreen(AppConstants.appName, paypalModel.paypalData!.url.toString(),AppConstants.orderMandirDarshan,"Mandir Darshan Purchase"));
        //       try {
        //         AppEvents().sendInitCheckoutEvent(paypalModel.data!.amount.toString(), paypalModel.paypalData!.orderId.toString(), uniId.toString(), AppConstants.orderMandirDarshan);
        //       } catch (e) {
        //         debugPrint("Error Event openCheckout: $e");
        //       }
        //     }else{
        //       AppDialog().showPaymentSuccessDialog(AppConstants.orderMandirDarshan);
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
              phonePeController.startTransaction(phonePeModel.phonepeData!.encode.toString(),phonePeModel.phonepeData!.data!.callbackUrl.toString(),phonePeModel.phonepeData!.finalXHeader.toString(), AppConstants.orderMandirDarshan,phonePeModel.phonepeData!.orderId.toString(),phonePeModel.phonepeData!.orderId.toString(),
                  num.parse(phonePeModel.paymentGatewayData!.amount.toString()),
                  phonePeModel.phonepeData!.data!.mobileNumber.toString(),
                  uniId.toString()
              );
            }
            else{
              AppDialog().showPaymentSuccessDialog(AppConstants.orderMandirDarshan);
            }
          } else {
            CustomSnackBar.showBottom(phonePeModel.msg.toString());
          }
        }
        //TODO Handle Phonepe
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiErrorPurchaseMandirDarshanPooja');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnExceptionPurchaseMandirDarshanPooja==> ${e.toString()}');
    }
  }


  void showCalculationBottomSheet(
      String liveMandirDarshanAssignId,
      String astrologerId,
      String duration,
      LiveMandirDarshanCalculationData? calculationData,
      LiveTempleDarshan liveTempleDarshanData) {
    Get.bottomSheet(
      SafeArea(
        child: Container(
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: CustomTextMedium(
                              AppStrings.importantNoticeTempleDarshan,
                              color: ColorResources.colorPrimary,
                              fontSize: Dimensions.fontSizeOverSmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: CustomTextMedium(
                              AppStrings.serviceDetail,
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
                                  child: CustomTextRegular(
                                    liveTempleDarshanData.liveTempleDarshanName.toString(),
                                    color: ColorResources.black1,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          int.tryParse(duration)! > 0 ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomTextRegular(
                                    "Duration",
                                    color: ColorResources.black1,
                                  ),
                                ),
                                Expanded(
                                  child:CustomTextRegular(
                                    CommonMethods().getFormattedTimeFromMin(int.parse(duration)),
                                    color: ColorResources.black1,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ) : const SizedBox.shrink(),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextRegular(
                                  "Wallet main balance",
                                  color: ColorResources.black1,
                                ),
                                CustomTextRegular(
                                  "${configController.currencySymbol} ${calculationData?.myWalletAmount}",
                                  color: ColorResources.black1,
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
                                  "Wallet gift balance",
                                  color: ColorResources.black1,
                                ),
                                CustomTextRegular(
                                  "${configController.currencySymbol} ${calculationData?.walletGiftBalance}",
                                  color: ColorResources.black1,
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
                                  "${configController.currencySymbol} ${calculationData?.liveTempleDarshanAmount}",
                                  color: ColorResources.black1,
                                ),
                              ],
                            ),
                          ),
                          Obx(() => Visibility(
                            visible: isWalletSelected.value == 1,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextRegular(
                                    "Wallet",
                                    color: ColorResources.black1,
                                  ),
                                  Obx(() => CustomTextRegular(
                                    "${configController.currencySymbol} ${walletPayableAmount.value}",
                                    color: ColorResources.black1,
                                  )),
                                ],
                              ),
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextRegular(
                                  "GST ${calculationData?.rechargeGstPercent}%",
                                  color: ColorResources.black1,
                                ),
                                Obx(() => CustomTextRegular(
                                  "${configController.currencySymbol} ${gstAmount.value}",
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
                                    "${configController.currencySymbol} ${totalPayableAmount.value}",
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
                    padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                    child: Row(
                      children: [
                        Image.asset(
                          Images.walletBalance,
                          height: 26,
                          color: ColorResources.colorPrimary,
                        ),
                        const Gap(15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextRegular("Wallet"),
                              CustomTextRegular(
                                "Available for payment ${configController.currencySymbol} ${calculationData?.myWalletAmount}",
                                color: ColorResources.black1,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                            ],
                          ),
                        ),
                        CustomCheckbox(
                          onChanged: (isChecked) {
                            if (isChecked) {
                              getMandirDarshanCalculation(
                                  liveMandirDarshanAssignId,
                                  astrologerId,
                                  1,
                                  liveTempleDarshanData,
                                  duration,
                                  "Wallet",
                                  mContext!);
                            } else {
                              getMandirDarshanCalculation(
                                  liveMandirDarshanAssignId,
                                  astrologerId,
                                  0,
                                  liveTempleDarshanData,
                                  duration,
                                  "Wallet",
                                  mContext!);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  // const Gap(10),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 4),
                  //   child: CustomElevatedButton(
                  //       text: AppStrings.proceedToPay.tr,
                  //       textColor: ColorResources.toolbarText,
                  //       backgroundColor: ColorResources.colorPrimary,
                  //       onPressed: () async {
                  //         if(birthDateController.text.isNotEmpty && birthTimeController.text.isNotEmpty){
                  //           String? payMethod = await SharedPreferencesHelper.getData(AppConstants.paymentGateway);
                  //           if (payMethod == AppConstants.payRazorpay) {
                  //             servicePurchaseRazorpay(liveMandirDarshanAssignId, astrologerId, CommonMethods().convertDateInput(birthDateController.text.toString()),CommonMethods().convertTimeInput(birthTimeController.text.toString()) ,isWalletSelected.value, payMethod.toString());
                  //           }else if (payMethod == AppConstants.payCCAvenue) {
                  //             servicePurchaseCCAvenue(liveMandirDarshanAssignId, astrologerId, CommonMethods().convertDateInput(birthDateController.text.toString()),CommonMethods().convertTimeInput(birthTimeController.text.toString()) ,isWalletSelected.value, payMethod.toString());
                  //           } else {
                  //             CustomSnackBar.showBottom('No Payment Gateway Found');
                  //           }
                  //         }else if(birthDateController.text.isEmpty){
                  //           CustomSnackBar.showBottom("Please Select Date");
                  //         }else if(birthTimeController.text.isEmpty){
                  //           CustomSnackBar.showBottom("Please Select Time");
                  //         }
                  //       }
                  //       ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraOverSmall),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            CommonMethods().showPaymentMethodBottomSheet(configController.phoneCode == AppConstants.defaultPhoneCode ? false : true,
                                onItemSelected: (int index){
                                  if(configController.phoneCode == AppConstants.defaultPhoneCode){
                                    purchaseMandirDarshanPooja(
                                        liveMandirDarshanAssignId,
                                        astrologerId,
                                        isWalletSelected.value,
                                        configController.paymentGatewayList[index].payMethod.toString()
                                    );
                                  }else{
                                    purchaseMandirDarshanPooja(
                                        liveMandirDarshanAssignId,
                                        astrologerId,
                                        isWalletSelected.value,
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
                              AppLogger.d("liveMandirDarshanAssignId$liveMandirDarshanAssignId");
                              String? defaultPayMethod = configController.config.data?.payment?.defaultPaymentGateway.toString();
                              String? defaultPayMethodInternational = configController.config.data?.paymentForOtherCountry?.defaultPaymentGateway.toString();
                              if(configController.phoneCode == AppConstants.defaultPhoneCode){
                                purchaseMandirDarshanPooja(
                                    liveMandirDarshanAssignId,
                                    astrologerId,
                                    isWalletSelected.value,
                                    defaultPayMethod.toString()
                                );
                              }else {
                                purchaseMandirDarshanPooja(
                                    liveMandirDarshanAssignId,
                                    astrologerId,
                                    isWalletSelected.value,
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
      ),
      isScrollControlled: true,
    );
  }

  // Future<void> endMandirStream(String id, DatabaseReference dbReference) async {
  //   CustomProgressDialog.showDialog();
  //   try {
  //     String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
  //     String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
  //     final response = await _dio.post(AppConstants.endMandirStream, data: {
  //       'api_key': apiKey,
  //       'user_uni_id': uniId,
  //       'live_temple_darshan_assign_id': id
  //     });
  //     if (response.statusCode == 200) {
  //       CustomProgressDialog.dismissDialog();
  //       liveEndModel = SuccessModel.fromJson(response.data);
  //       if (liveEndModel.status == AppConstants.success) {
  //         dbReference.child("liveEnd").set(true);
  //         dbReference.child("astrologer_status").set(false);
  //       } else {
  //         CustomSnackBar.showBottom(liveEndModel.msg.toString());
  //         dbReference.child("liveEnd").set(true);
  //         dbReference.child("astrologer_status").set(false);
  //       }
  //     } else {
  //       CustomProgressDialog.dismissDialog();
  //       if (kDebugMode) {
  //         print('OnApiError');
  //       }
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('OnException==> ${e.toString()}');
  //     }
  //   }
  // }
}
