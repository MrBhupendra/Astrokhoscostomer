import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../controller/cash_free_controller.dart';
import '../../../../../controller/phonepe_controller.dart';
import '../../../../../controller/razorpay_controller.dart';
import '../../../../../model/cashfree_model.dart';
import '../../../../../model/phonepe_model.dart';
import '../../../../../model/razorpay_model.dart';
import '../../../../../utill/app_constants.dart';
import '../../../../../utill/app_dialogs.dart';
import '../../../../../utill/app_strings.dart';
import '../../../../../utill/color_resources.dart';
import '../../../../../utill/dimensions.dart';
import '../../../../../utill/images.dart';
import '../../../../../utill/shared_preference.dart';
import '../../../../widget/custom_checkbox.dart';
import '../../../../widget/custom_elevated_button.dart';
import '../../../../widget/custom_progress_dialog.dart';
import '../../../../widget/custom_snack_bar.dart';
import '../../../../widget/custom_text_medium.dart';
import '../../../../widget/custom_text_regular.dart';
import '../../../splash/controller/config_controller.dart';
import '../../model/report_order_list_model.dart';
import '../../model/vedic_data.dart';
import '../../vedic_astro_model/report_calculation_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class ReportController extends GetxController {
  final Dio _dio = Dio();
  final isCalculationLoading = false.obs;
  final isCalculationSuccess = false.obs;

  final isOrderLoading = false.obs;
  final isOrderSuccess = false.obs;

  RxString selectedGender = ''.obs;
  RxString selectedLanguage = ''.obs;

  final isWalletSelected = 0.obs;
  RxString walletPayableAmount = '0'.obs;
  RxString totalPayableAmount = '0'.obs;
  RxString gstAmount = '0'.obs;
  RxString pdfSize = "medium".obs;

  final isPurchaseLoading = false.obs;
  final isPurchaseSuccess = false.obs;
  RazorpayModel razorpayModel = RazorpayModel();

  final CashFreeController cashfreeController = Get.put(CashFreeController());
  CashfreeModel cashfreePaymentModel =
      CashfreeModel();

  //Multiple PG
  final ConfigController configController = Get.find();

  PhonepeModel phonePeModel = PhonepeModel();

  num offsetCount = 0;
  bool isNoMoreData = false;
  ScrollController scrollController = ScrollController();

  ReportCalculationModel reportCalculationModel = ReportCalculationModel();

  ReportOrderListModel reportOrderListModel = ReportOrderListModel();
  String? horoscopePrice;
  String? matchingPrice;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    horoscopePrice =
        await SharedPreferencesHelper.getData(AppConstants.horoscopePrice);
    matchingPrice =
        await SharedPreferencesHelper.getData(AppConstants.kundliMatchingPrice);
    CFPaymentGatewayService()
        .setCallback(cashfreeController.onVerify, cashfreeController.onError);
  }

  void setGender(String gender) {
    selectedGender.value = gender;
  }

  void setLanguage(String language) {
    selectedLanguage.value = language;
  }

  // report order list

  Future<void> getReportOrderList() async {
    isOrderLoading(true);
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.paidKundliOrderList,
          data: {'api_key': apiKey, "user_uni_id": uniId});

      if (response.statusCode == 200) {
        reportOrderListModel = ReportOrderListModel.fromJson(response.data);
        if (reportOrderListModel.status == AppConstants.success) {
          // isOrderSuccess(true);
          if (reportOrderListModel.data!.isNotEmpty) {
            isOrderSuccess(true);
          } else {
            isOrderSuccess(false);
          }
        } else {
          isOrderSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isOrderSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isOrderLoading(false);
    }
  }

  // Horoscope pdf
  Future<void> paidKundliCalculation(String orderType, int walletCheck, String action, KundliMatchData data) async {
    AppLogger.d("Enter in");
    CustomProgressDialog.showDialog();
    isCalculationLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? payMethod = await SharedPreferencesHelper.getData(AppConstants.paymentGateway);
      final response = await _dio.post(AppConstants.paidKundliCalculation, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "order_for": orderType,
        "wallet_check": walletCheck,
        "payment_method": payMethod,
        "pdf_type": pdfSize.value,
      });
      AppLogger.d("order:::>$orderType");
      AppLogger.d("wallet_check:::>$walletCheck");
      AppLogger.d("payment_method:::>$payMethod");

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        AppLogger.d(response.data);
        reportCalculationModel = ReportCalculationModel.fromJson(response.data);
        if (reportCalculationModel.status == AppConstants.success) {
          isCalculationSuccess(true);

          isWalletSelected.value = walletCheck;

          walletPayableAmount.value =
              reportCalculationModel.data!.walletAmount.toString();

          gstAmount.value =
              reportCalculationModel.data!.rechargeGstValue.toString();

          totalPayableAmount.value =
              reportCalculationModel.data!.payableAmount.toString();

          if (action == "Open") {
            _showHoroCalculationBottomSheet(
                reportCalculationModel.data, orderType, data);
          }
        } else {
          isCalculationSuccess(false);
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      isCalculationSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isCalculationLoading(false);
    }
  }

  Future<void> paidKundliPurchase(String orderType, int walletCheck,
      String paymentMethod, KundliMatchData data) async {
    CustomProgressDialog.showDialog();
    isPurchaseLoading(true);
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      Map<String, dynamic> requestData = {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "order_for": orderType,
        "offer_code": "",
        "wallet_check": walletCheck,
        "payment_method": paymentMethod,
        "lang": "en"
      };

      if (orderType == AppConstants.reportHoroscope) {
        // Single
        requestData.addAll({
          "name": data.boyName,
          "dob": data.boyDob,
          "tob": data.boyTob,
          "lat": data.boyLat,
          "lon": data.boyLong,
          "tz": data.boyTz,
          "pob": data.boyPlace,
          "style": "north",
          "color": "140",
          "pdf_type": "medium"
        });
      }

      if (orderType == AppConstants.reportMatching) {
        requestData.addAll({
          "boy_dob": data.boyDob,
          "boy_tob": data.boyTob,
          "boy_tz": data.boyTz,
          "boy_lat": data.boyLat,
          "boy_lon": data.boyLong,
          "girl_dob": data.girlDob,
          "girl_tob": data.girlTob,
          "girl_tz": data.girlTz,
          "girl_lat": data.girlLat,
          "girl_lon": data.girlLong,
          "style": "north",
          "color": "140",
          "pdf_type": "medium",
          "boy_pob": data.boyPlace,
          "girl_pob": data.girlPlace,
          "boy_name": data.boyName,
          "girl_name": data.girlName,
        });
      }

      AppLogger.d('Request Data: $requestData'); // Log request data

      final response =
          await _dio.post(AppConstants.paidKundliPurchase, data: requestData);
      AppLogger.d('Response Data: ${response.data}'); // Log response data

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        razorpayModel = RazorpayModel.fromJson(response.data);
        if (razorpayModel.status == AppConstants.success) {
          isPurchaseSuccess(true);
          Get.back(); // Hide payment info bottom sheet
          final RazorpayController razorpayController =
              Get.put(RazorpayController());
          if (razorpayModel.paymentGatewayStatus == AppConstants.success) {
            razorpayController.openCheckout(
                razorpayModel.paymentGateway!,
                "${AppStrings.kundliReport.tr} Purchase",
                uniId,
                AppConstants.report);
          } else {
            AppDialog().showPaymentSuccessDialog(AppConstants.report);
            // razorpayController.showSuccessDialog(razorpayModel.orderId.toString(), AppConstants.report);
          }
        } else {
          isPurchaseSuccess(false);
          AppLogger.d('Purchase failed: ${razorpayModel.msg}');
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError: ${response.statusCode} ${response.statusMessage}');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      isPurchaseSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isPurchaseLoading(false);
    }
  }

  Future<void> paidCashfreeKundliPurchase(String orderType, int walletCheck,
      String paymentMethod, KundliMatchData data) async {
    CustomProgressDialog.showDialog();
    isPurchaseLoading(true);
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      Map<String, dynamic> requestData = {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "order_for": orderType,
        "offer_code": "",
        "wallet_check": walletCheck,
        "payment_method": paymentMethod,
        "lang": "en"
      };

      if (orderType == AppConstants.reportHoroscope) {
        // Single
        requestData.addAll({
          "name": data.boyName,
          "dob": data.boyDob,
          "tob": data.boyTob,
          "lat": data.boyLat,
          "lon": data.boyLong,
          "tz": data.boyTz,
          "pob": data.boyPlace,
          "style": "north",
          "color": "140",
          "pdf_type": "medium"
        });
      }

      if (orderType == AppConstants.reportMatching) {
        requestData.addAll({
          "boy_dob": data.boyDob,
          "boy_tob": data.boyTob,
          "boy_tz": data.boyTz,
          "boy_lat": data.boyLat,
          "boy_lon": data.boyLong,
          "girl_dob": data.girlDob,
          "girl_tob": data.girlTob,
          "girl_tz": data.girlTz,
          "girl_lat": data.girlLat,
          "girl_lon": data.girlLong,
          "style": "north",
          "color": "140",
          "pdf_type": "medium",
          "boy_pob": data.boyPlace,
          "girl_pob": data.girlPlace,
          "boy_name": data.boyName,
          "girl_name": data.girlName,
        });
      }

      AppLogger.d('Request Data: $requestData'); // Log request data

      final response =
          await _dio.post(AppConstants.paidKundliPurchase, data: requestData);
      AppLogger.d('Response Data: ${response.data}'); // Log response data

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        cashfreePaymentModel =
            CashfreeModel.fromJson(response.data);
        if (cashfreePaymentModel.status == AppConstants.success) {
          isPurchaseSuccess(true);
          Get.back(); // Hide payment info bottom sheet
          if (cashfreePaymentModel.cashfreeData!.status ==
              AppConstants.success) {
            isPurchaseSuccess(true);

            cashfreeController.orderId.value =
                cashfreePaymentModel.cashfreeData!.response!.orderId!;
            cashfreeController.sessionId.value =
                cashfreePaymentModel.cashfreeData!.response!.paymentSessionId!;
            cashfreeController.webCheckout(
                cashfreePaymentModel.paymentGateway!.amount!,
                uniId.toString(),
                AppConstants.serviceOrder);
          } else {
            cashfreeController.showSuccessDialog(
                cashfreePaymentModel.orderId.toString(), AppConstants.report);
          }
        } else {
          isPurchaseSuccess(false);
          AppLogger.d('Purchase failed: ${cashfreePaymentModel.msg}');
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError: ${response.statusCode} ${response.statusMessage}');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      isPurchaseSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isPurchaseLoading(false);
    }
  }

  Future<void> paidPhonePeKundliPurchase(String orderType, int walletCheck,
      String paymentMethod, KundliMatchData data) async {
    CustomProgressDialog.showDialog();
    isPurchaseLoading(true);
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      Map<String, dynamic> requestData = {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "order_for": orderType,
        "offer_code": "",
        "wallet_check": walletCheck,
        "payment_method": paymentMethod,
        "lang": "en"
      };

      if (orderType == AppConstants.reportHoroscope) {
        // Single
        requestData.addAll({
          "name": data.boyName,
          "dob": data.boyDob,
          "tob": data.boyTob,
          "lat": data.boyLat,
          "lon": data.boyLong,
          "tz": data.boyTz,
          "pob": data.boyPlace,
          "style": "north",
          "color": "140",
          "pdf_type": "medium"
        });
      }

      if (orderType == AppConstants.reportMatching) {
        requestData.addAll({
          "boy_dob": data.boyDob,
          "boy_tob": data.boyTob,
          "boy_tz": data.boyTz,
          "boy_lat": data.boyLat,
          "boy_lon": data.boyLong,
          "girl_dob": data.girlDob,
          "girl_tob": data.girlTob,
          "girl_tz": data.girlTz,
          "girl_lat": data.girlLat,
          "girl_lon": data.girlLong,
          "style": "north",
          "color": "140",
          "pdf_type": "medium",
          "boy_pob": data.boyPlace,
          "girl_pob": data.girlPlace,
          "boy_name": data.boyName,
          "girl_name": data.girlName,
        });
      }

      AppLogger.d('Request Data: $requestData'); // Log request data

      final response =
          await _dio.post(AppConstants.paidKundliPurchase, data: requestData);
      AppLogger.d('Response Data: ${response.data}'); // Log response data

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        phonePeModel = PhonepeModel.fromJson(response.data);
        String? phonePeId = configController.config.data?.phonepeMerchantId.toString();
        if (phonePeModel.status == AppConstants.success) {
          final PhonePeController phonePeController = Get.put(PhonePeController(phonePeId.toString()));
          isPurchaseSuccess(true);
          Get.back(); // Hide payment info bottom sheet
          if (phonePeModel.phonepeData != null && phonePeModel.phonepeData!.status == AppConstants.success) {
            isPurchaseSuccess(true);
            phonePeController.startTransaction(
                phonePeModel.phonepeData!.encode.toString(),
                phonePeModel.phonepeData!.data!.callbackUrl.toString(),
                phonePeModel.phonepeData!.finalXHeader.toString(),
                AppConstants.shop,
                phonePeModel.phonepeData!.orderId.toString(),
                phonePeModel.phonepeData!.orderId.toString(),
                num.parse(phonePeModel.data!.payableAmount.toString()),
                phonePeModel.phonepeData!.data!.mobileNumber.toString(),
                uniId.toString());
          } else {
            phonePeController.showSuccessDialog(
                phonePeModel.phonepeData!.orderId.toString(), AppConstants.report);
          }
        } else {
          isPurchaseSuccess(false);
          AppLogger.d('Purchase failed: ${phonePeModel.msg}');
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError: ${response.statusCode} ${response.statusMessage}');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      isPurchaseSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isPurchaseLoading(false);
    }
  }

  void _showHoroCalculationBottomSheet(ReportCalculationData? calculationData,
      String orderType, KundliMatchData data) {
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
                            child: CustomTextMedium(
                                AppStrings.paymentInformation.tr,
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
                              orderType == AppConstants.reportHoroscope
                                  ? "${AppStrings.kundliReport.tr} Detail"
                                  : "${AppStrings.matchingReport.tr} Detail",
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
                                    orderType == AppConstants.reportHoroscope
                                        ? AppStrings.kundliReport.tr
                                        : AppStrings.matchingReport.tr,
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
                                  "${AppStrings.rupeeSign} ${calculationData?.orderAmount}",
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
                                            "${AppStrings.rupeeSign} ${walletPayableAmount.value}",
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
                                      "${AppStrings.rupeeSign} ${gstAmount.value}",
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
                                    "${AppStrings.rupeeSign} ${totalPayableAmount.value}",
                                    color: ColorResources.colorPrimary)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(10),
                  Visibility(
                    visible: orderType == AppConstants.reportHoroscope,
                    child: Column(
                      children: [
                        const Gap(10),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.picture_as_pdf_outlined, size: 26,
                                    color: ColorResources.colorPrimary,),
                                  const Gap(15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomTextRegular("PDF Size"),
                                        CustomTextRegular(
                                          "Please select below your preferred PDF size:",
                                          color: ColorResources.black1,
                                          fontSize: Dimensions.fontSizeSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Obx(() => Column(
                                children: [
                                  Row(
                                    children: [
                                      const Gap(20),
                                      const Icon(Icons.circle, size: 8, color: ColorResources.black),
                                      const Gap(15),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomTextRegular("Small"),
                                            CustomTextRegular(
                                              "Around 10 Pages",
                                              color: ColorResources.black1,
                                              fontSize: Dimensions.fontSizeSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Radio<String>(
                                        value: "small",
                                        groupValue: pdfSize.value,
                                        onChanged: (value) {
                                          AppLogger.d("${pdfSize.value}");
        
                                          if (value != null) {
                                            pdfSize.value = value;
                                            paidKundliCalculation(orderType, 0, "", data);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Gap(20),
                                      const Icon(Icons.circle, size: 8, color: ColorResources.black),
                                      const Gap(15),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomTextRegular("Medium"),
                                            CustomTextRegular(
                                              "Around 30 Pages",
                                              color: ColorResources.black1,
                                              fontSize: Dimensions.fontSizeSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Radio<String>(
                                        value: "medium",
                                        groupValue: pdfSize.value,
                                        onChanged: (value) {
                                          AppLogger.d("${pdfSize.value}");
                                          if (value != null) {
                                            pdfSize.value = value;
                                            paidKundliCalculation(orderType, 0, "", data);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Gap(20),
                                      const Icon(Icons.circle, size: 8, color: ColorResources.black),
                                      const Gap(15),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomTextRegular("Large"),
                                            CustomTextRegular(
                                              "Around 60 Pages",
                                              color: ColorResources.black1,
                                              fontSize: Dimensions.fontSizeSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Radio<String>(
                                        value: "large",
                                        groupValue: pdfSize.value,
                                        onChanged: (value) {
                                          AppLogger.d("${pdfSize.value}");
        
                                          if (value != null) {
                                            pdfSize.value = value;
                                            paidKundliCalculation(orderType, 0, "", data);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                      ],
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
                                "Available for payment ${AppStrings.rupeeSign} ${calculationData?.myWalletAmount}",
                                color: ColorResources.black1,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                            ],
                          ),
                        ),
                        CustomCheckbox(
                          onChanged: (isChecked) {
                            if (isChecked) {
                              paidKundliCalculation(orderType, 1, "Wallet", data);
                            } else {
                              paidKundliCalculation(orderType, 0, "Wallet", data);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  // const Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: CustomElevatedButton(
                        text: AppStrings.proceedToPay.tr,
                        textColor: ColorResources.toolbarText,
                        backgroundColor: ColorResources.colorPrimaryVariant,
                        onPressed: () async {
                          String? payMethod =
                              await SharedPreferencesHelper.getData(
                                  AppConstants.paymentGateway);
                          AppLogger.d(payMethod);
                          if (payMethod == AppConstants.payRazorpay ||
                              payMethod == AppConstants.payCCAvenue) {
                            paidKundliPurchase(orderType, isWalletSelected.value,
                                payMethod!, data);
                          } else if (payMethod == AppConstants.payCashfree) {
                            paidCashfreeKundliPurchase(orderType,
                                isWalletSelected.value, payMethod!, data);
                          } else if (payMethod == AppConstants.payPhonePe) {
                            paidPhonePeKundliPurchase(orderType,
                                isWalletSelected.value, payMethod!, data);
                          } else {
                            CustomSnackBar.showBottom('No Payment Gateway Found');
                          }
                        }),
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
                              color: ColorResources.colorPrimaryDark),
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
}
