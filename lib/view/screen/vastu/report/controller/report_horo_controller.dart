import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/view/widget/custom_progress_dialog.dart';

import '../../../../../controller/razorpay_controller.dart';
import '../../../../../model/razorpay_model.dart';
import '../../../../../model/vedic_data.dart';
import '../../../../../utill/app_constants.dart';
import '../../../../../utill/app_dialogs.dart';
import '../../../../../utill/app_strings.dart';
import '../../../../../utill/color_resources.dart';
import '../../../../../utill/common_methods.dart';
import '../../../../../utill/dimensions.dart';
import '../../../../../utill/images.dart';
import '../../../../../utill/shared_preference.dart';
import '../../../../widget/custom_checkbox.dart';
import '../../../../widget/custom_elevated_button.dart';
import '../../../../widget/custom_snack_bar.dart';
import '../../../../widget/custom_text_medium.dart';
import '../../../../widget/custom_text_regular.dart';
import '../../../splash/controller/config_controller.dart';
import '../../../vedic_and_jyotisham_astro/model/report_horo_calculation.dart';
import '../../../vedic_and_jyotisham_astro/model/report_kundli_list_model.dart';
import '../../../vedic_and_jyotisham_astro/model/report_order_list_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class ReportHoroController extends GetxController {
  final Dio _dio = Dio();
  final isCalculationLoading = false.obs;
  final isCalculationSuccess = false.obs;

  final isReportLoading = false.obs;
  final isReportSuccess = false.obs;

  final isOrderLoading = false.obs;
  final isOrderSuccess = false.obs;

  RxString selectedGender = ''.obs;
  RxString selectedLanguage = ''.obs;

  final isWalletSelected = 0.obs;
  RxString walletPayableAmount = '0'.obs;
  RxString totalPayableAmount = '0'.obs;
  RxString gstAmount = '0'.obs;
  ReportHoroCalculation reportCalculation = ReportHoroCalculation();

  final isPurchaseLoading = false.obs;
  final isPurchaseSuccess = false.obs;
  RazorpayModel razorpayModel = RazorpayModel();

  // Report kundli list
  ReportKundliListModel reportKundliListModel = ReportKundliListModel();
  List<ReportData> reportListData = [];
  num offsetCount = 0;
  bool isNoMoreData = false;
  ScrollController scrollController = ScrollController();

  // Search
  final searchQuery = ''.obs;
  Timer? _debounce;

  // Report Orders list
  ReportOrderListModel reportOrderListModel = ReportOrderListModel();

  final ConfigController configController = Get.find();

  void setGender(String gender) {
    selectedGender.value = gender;
  }

  void setLanguage(String language) {
    selectedLanguage.value = language;
  }

  void search(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      searchQuery.value = query;
      offsetCount = 0;
      // isNoMoreData = false;
      // sanjeeviniListData.clear();
      getReportKundliList(offsetCount, query);
    });
  }

  // report list
  Future<void> getReportKundliList(num offset, String search) async {
    if (offset == 0) {
      offsetCount = 0;
      isNoMoreData = false;
      reportListData.clear();
    }
    isReportLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.reportKundliList, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "offset": offset,
        "search": search,
      });

      if (response.statusCode == 200) {
        reportKundliListModel = ReportKundliListModel.fromJson(response.data);
        if (reportKundliListModel.status == AppConstants.success) {
          offsetCount = reportKundliListModel.offset!;
          isReportSuccess(true);

          for (var element in (reportKundliListModel.data ?? [])) {
            reportListData.add(element);
          }

        } else {
          if (offset == 0 && search.isEmpty) {
            isReportSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isReportSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isReportLoading(false);
    }
  }

  //Horoscope
  Future<void> getHoroReportCalculation(String id,
      String orderType, int walletCheck, String action, KundliMatchData data) async {
    CustomProgressDialog.showDialog();
    isCalculationLoading(true);
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? payMethod =
      await SharedPreferencesHelper.getData(AppConstants.paymentGateway);
      final response =
      await _dio.post(AppConstants.reportCalculation, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "paid_kundli_manual_id": id,
        "order_for": orderType,
        "wallet_check": walletCheck,
        "payment_method": payMethod
      });

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        reportCalculation = ReportHoroCalculation.fromJson(response.data);
        if (reportCalculation.status == AppConstants.success) {
          isCalculationSuccess(true);

          isWalletSelected.value = walletCheck;

          walletPayableAmount.value =
              reportCalculation.data!.walletAmount.toString();

          gstAmount.value = reportCalculation.data!.rechargeGstValue.toString();

          totalPayableAmount.value =
              reportCalculation.data!.payableAmount.toString();

          if (action == "Open") {
            _showHoroCalculationBottomSheet(
                id,reportCalculation.data, orderType, data);
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

  // report order list
  Future<void> getReportOrderList(int offset) async {
    isOrderLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.reportHoroscopeOrderList, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "offset": offset
      });

      if (response.statusCode == 200) {
        reportOrderListModel = ReportOrderListModel.fromJson(response.data);
        if (reportOrderListModel.status == AppConstants.success) {
          isOrderSuccess(true);
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

  Future<void> horoscopeReportPurchase(String id,String orderType, int walletCheck,
      String paymentMethod, KundliMatchData data) async {
    AppLogger.d('As11');
    isPurchaseLoading(true);
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);
      Map<String, dynamic> requestData = {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "paid_kundli_manual_id": id,
        "order_for": orderType,
        "wallet_check": walletCheck,
        "payment_method": paymentMethod,
        "lang": data.language,
      };

      if (orderType == AppConstants.single) {
        //Single
        requestData.addAll({
          "name": data.boyName,
          "dob": data.boyDob,
          "tob": data.boyTob,
          "lat": data.boyLat,
          "lon": data.boyLong,
          "pob": data.boyPlace,
          "gender" : data.gender
        });
      }

      if (orderType == AppConstants.married) {
        requestData.addAll({
          "boy_name": data.boyName,
          "boy_dob": data.boyDob,
          "boy_tob": data.boyTob,
          "boy_lat": data.boyLat,
          "boy_lon": data.boyLong,
          "boy_pob": data.boyPlace,
          "boy_gender": data.gender,
          "girl_name": data.girlName,
          "girl_dob": data.girlDob,
          "girl_tob": data.girlTob,
          "girl_lat": data.girlLat,
          "girl_lon": data.girlLong,
          "girl_pob": data.girlPlace
        });
      }

      final response = await _dio.post(AppConstants.reportHoroscopePurchase, data: requestData);
      AppLogger.d('AS1 ${response.data}');
      if (response.statusCode == 200) {
        if(paymentMethod == AppConstants.payRazorpay) {
          razorpayModel = RazorpayModel.fromJson(response.data);
          if (razorpayModel.status == AppConstants.success) {
            isPurchaseSuccess(true);
            Get.back(); //Hide payment info bottom sheet
            final RazorpayController razorpayController = Get.put(
                RazorpayController());
            if (razorpayModel.paymentGatewayStatus == AppConstants.success) {
              razorpayController.openCheckout(razorpayModel.paymentGateway!,
                  "${AppStrings.kundliReport.tr} Purchase", uniId,
                  AppConstants.report);
            } else {
              AppDialog().showPaymentSuccessDialog(AppConstants.report);
            }
          } else {
            isPurchaseSuccess(false);
            CustomSnackBar.showBottom(razorpayModel.msg.toString());
          }
        } else {
          CustomSnackBar.showBottom(AppStrings.noPaymentGatewayFound.tr);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isPurchaseSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isPurchaseLoading(false);
    }
  }

  void _showHoroCalculationBottomSheet(String id,
      ReportHoroCalculationData? calculationData,
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
                              "${AppStrings.kundliReport.tr} Detail",
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
                                    AppStrings.kundliReport.tr,
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
                                  "${configController.currencySymbol} ${calculationData
                                      ?.orderAmount}",
                                  color: ColorResources.black1,
                                ),
                              ],
                            ),
                          ),
                          Obx(() =>
                              Visibility(
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
                                      Obx(() =>
                                          CustomTextRegular(
                                            "${AppStrings
                                                .rupeeSign} ${walletPayableAmount
                                                .value}",
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
                                Obx(() =>
                                    CustomTextRegular(
                                      "${configController.currencySymbol} ${gstAmount
                                          .value}",
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
                                Obx(() =>
                                    CustomTextMedium(
                                        "${AppStrings
                                            .rupeeSign} ${totalPayableAmount
                                            .value}",
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
                                "Available for payment ${AppStrings
                                    .rupeeSign} ${calculationData
                                    ?.myWalletAmount}",
                                color: ColorResources.black1,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                            ],
                          ),
                        ),
                        CustomCheckbox(
                          onChanged: (isChecked) {
                            if (isChecked) {
                              getHoroReportCalculation(
                                 id, orderType, 1, "Wallet", data);
                            } else {
                              getHoroReportCalculation(
                                  id, orderType, 0, "Wallet", data);
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
                  //       backgroundColor: ColorResources.colorPrimaryVariant,
                  //       onPressed: () async {
                  //         String? payMethod = await SharedPreferencesHelper.getData(AppConstants.paymentGateway);
                  //         if (payMethod == AppConstants.payRazorpay) {
                  //           horoscopeReportPurchase(id,orderType, isWalletSelected.value, payMethod!, data);
                  //         } else {
                  //           CustomSnackBar.showBottom('No Payment Gateway Found');
                  //         }
                  //       }),
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
                                    horoscopeReportPurchase(
                                        id,
                                        orderType,
                                        isWalletSelected.value,
                                        configController.paymentGatewayList[index].payMethod.toString(),
                                        data
                                    );
                                  }else{
                                    horoscopeReportPurchase(
                                        id,
                                        orderType,
                                        isWalletSelected.value,
                                        configController.internationalPaymentGatewayList[index].payMethod.toString(),
                                        data
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
                                      CommonMethods().toCapitalize(
                                        configController.phoneCode == AppConstants.defaultPhoneCode
                                            ? configController.config.data!.payment!.defaultPaymentGateway.toString()
                                            : configController.config.data!.paymentForOtherCountry!.defaultPaymentGateway.toString(),
                                      ),
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
                                  horoscopeReportPurchase(
                                      id,
                                      orderType,
                                      isWalletSelected.value,
                                      defaultPayMethod.toString(),
                                      data
                                  );
                                }else {
                                  horoscopeReportPurchase(
                                      id,
                                      orderType,
                                      isWalletSelected.value,
                                      defaultPayMethodInternational.toString(),
                                      data
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
                    onTap: (){
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
}
