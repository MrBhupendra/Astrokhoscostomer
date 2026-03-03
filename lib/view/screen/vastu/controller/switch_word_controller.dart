import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/vastu/model/switch_word_calculation_model.dart';
import 'package:astro_brahmand/view/screen/vastu/model/switch_word_model.dart';

import '../../../../controller/razorpay_controller.dart';
import '../../../../model/razorpay_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_dialogs.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/common_methods.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_checkbox.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../splash/controller/config_controller.dart';

class SwitchWordController extends GetxController {
  final Dio _dio = Dio();
  final isSwitchWordLoading = false.obs;
  final isSwitchWordSuccess = false.obs;
  SwitchWordModel switchWordModel = SwitchWordModel();

  List<SwitchWordData> switchWordListData = [];
  num offsetCount = 0;
  bool isNoMoreData = false;
  ScrollController scrollController = ScrollController();

  // Search
  final searchQuery = ''.obs;
  Timer? _debounce;

  final isCalculationLoading = false.obs;
  final isCalculationSuccess = false.obs;
  final isWalletSelected = 0.obs;
  RxString walletPayableAmount = '0'.obs;
  RxString totalPayableAmount = '0'.obs;
  RxString gstAmount = '0'.obs;
  SwitchWordCalculationModel switchWordCalculation = SwitchWordCalculationModel();

  final isPurchaseLoading = false.obs;
  final isPurchaseSuccess = false.obs;
  RazorpayModel razorpayModel = RazorpayModel();

  final ConfigController configController = Get.find();

  @override
  void onInit() {
    super.onInit();
    getSwitchWordList(offsetCount, "");

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if(isSwitchWordLoading.isFalse && !isNoMoreData) {
          getSwitchWordList(offsetCount, searchQuery.value);
        }
      }
    });
  }

  void search(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      searchQuery.value = query;
      offsetCount = 0;
      // isNoMoreData = false;
      // switchWordListData.clear();
      getSwitchWordList(offsetCount, query);
    });
  }

  Future<void> getSwitchWordList(num offset, String search) async {
    if(offset == 0){
      offsetCount = 0;
      isNoMoreData = false;
      switchWordListData.clear();
      // if (search != searchQuery.value) {
      //   switchWordListData.clear();
      // }
    }

    isSwitchWordLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getSwitchWords, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "offset" : offset,
        "search": search
      });

      if (response.statusCode == 200) {
        switchWordModel = SwitchWordModel.fromJson(response.data);
        if (switchWordModel.status == AppConstants.success) {
          offsetCount = switchWordModel.offset!;
          isSwitchWordSuccess(true);

          for (var element in (switchWordModel.data ?? [])) {
            switchWordListData.add(element);
          }
        } else {
          if(offset == 0){
            isSwitchWordSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      isSwitchWordSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isSwitchWordLoading(false);
    }
  }

  Future<void> getSwitchWordCalculation(
      String switchWordId, int walletCheck,SwitchWordData switchWordData, String action) async {
    CustomProgressDialog.showDialog();
    isCalculationLoading(true);
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? payMethod =
      await SharedPreferencesHelper.getData(AppConstants.paymentGateway);
      final response = await _dio.post(AppConstants.switchWordCalculation, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "switchword_id": switchWordId,
        "wallet_check": walletCheck,
        "payment_method": payMethod
      });
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        switchWordCalculation =
            SwitchWordCalculationModel.fromJson(response.data);
        if (switchWordCalculation.status == AppConstants.success) {
          isCalculationSuccess(true);

          isWalletSelected.value = walletCheck;

          walletPayableAmount.value =
              switchWordCalculation.data!.walletAmount.toString();

          gstAmount.value =
              switchWordCalculation.data!.rechargeGstValue.toString();

          totalPayableAmount.value =
              switchWordCalculation.data!.payableAmount.toString();

          if (action == "Open") {
            _showCalculationBottomSheet(
                switchWordId, switchWordCalculation.data, switchWordData);
          }
        } else {
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

  Future<void> switchWordPurchase(
      String switchWordId, int walletCheck, String paymentMethod) async {
    isPurchaseLoading(true);
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.switchWordPurchase, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "switchword_id": switchWordId,
        "wallet_check": walletCheck,
        "payment_method": paymentMethod
      });
      if (response.statusCode == 200) {
        if(paymentMethod == AppConstants.payRazorpay) {
          razorpayModel = RazorpayModel.fromJson(response.data);
          if (razorpayModel.status == AppConstants.success) {
            isPurchaseSuccess(true);
            Get.back(); //Hide payment info bottom sheet
            final RazorpayController razorpayController =
            Get.put(RazorpayController());
            if (razorpayModel.paymentGatewayStatus == AppConstants.success) {
              razorpayController.openCheckout(razorpayModel.paymentGateway!,
                  "${AppStrings.divineCode} Purchase", uniId,
                  AppConstants.divineCode);
            } else {
              AppDialog().showPaymentSuccessDialog(AppConstants.divineCode);
            }
          } else {
            isPurchaseSuccess(false);
            CustomSnackBar.showBottom(razorpayModel.msg.toString());
          }
        } else {
          CustomSnackBar.showBottom(AppStrings.noPaymentGatewayFound.tr);
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      isPurchaseSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isPurchaseLoading(false);
    }
  }

  void _showCalculationBottomSheet(String switchWordId,
      SwitchWordCalculatioData? calculationData, SwitchWordData switchWordData) {
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
                              "${AppStrings.divineCode} Detail",
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
                                    switchWordData.title.toString(),
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
                                  "${configController.currencySymbol} ${calculationData?.switchwordAmount}",
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
                              getSwitchWordCalculation(
                                  switchWordData.id.toString(),
                                  1,
                                  switchWordData,
                                  "Wallet");
                            } else {
                              getSwitchWordCalculation(
                                  switchWordData.id.toString(),
                                  0,
                                  switchWordData,
                                  "Wallet");
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
                  //         String? payMethod =
                  //         await SharedPreferencesHelper.getData(
                  //             AppConstants.paymentGateway);
                  //         if (payMethod == AppConstants.payRazorpay ||
                  //             payMethod == AppConstants.payCCAvenue) {
                  //           switchWordPurchase(switchWordId, isWalletSelected.value, payMethod!);
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
                                    switchWordPurchase(switchWordId, isWalletSelected.value, configController.paymentGatewayList[index].payMethod.toString());
                                  }else{
                                    switchWordPurchase(switchWordId, isWalletSelected.value, configController.internationalPaymentGatewayList[index].payMethod.toString());
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
                                switchWordPurchase(
                                    switchWordId,
                                    isWalletSelected.value,
                                    defaultPayMethod.toString()
                                );
                              }else {
                                switchWordPurchase(
                                    switchWordId,
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
                    onTap: (){
                      print("Tap");
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