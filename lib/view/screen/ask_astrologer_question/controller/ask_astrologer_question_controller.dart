import 'package:astro_brahmand/view/screen/ask_astrologer_question/model/astro_question_customer_list_model.dart';
import 'package:astro_brahmand/view/screen/ask_astrologer_question/model/astro_question_purchase_model.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/app_dialogs.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/common_methods.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_text_regular.dart';
import '../../splash/controller/config_controller.dart';
import '../model/astro_question_calculation_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class AskAstrologerQuestionController extends GetxController {
  final TextEditingController messageController = TextEditingController();

  final Dio _dio = Dio();

  //Calculation
  final isCalculationLoading = false.obs;
  final isCalculationSuccess = false.obs;
  final isWalletSelected = 0.obs;
  RxString walletPayableAmount = '0'.obs;
  RxString totalPayableAmount = '0'.obs;
  RxString gstAmount = '0'.obs;
  AstroQuestionCalculationModel astroQuestionCalculationModel = AstroQuestionCalculationModel();

  // Purchase
  final isPurchaseLoading = false.obs;
  final isPurchaseSuccess = false.obs;
  AstroQuestionPurchaseModel purchaseModel = AstroQuestionPurchaseModel();

  // List
  final isQueListLoading = false.obs;
  final isQueListSuccess = false.obs;
  AstroQuestionCustomerListModel askQuestionCustomerListModel = AstroQuestionCustomerListModel();
  RxList<AstroQuestionCustomerListData> askQuestionCustomerListData = <AstroQuestionCustomerListData>[].obs;

  //Scroll
  ScrollController scrollController = ScrollController();
  num offsetCount = 0;
  bool isNoMoreData = false;

  // // Expand Answer
  // var isExpanded = false.obs;
  //
  // void toggleExpanded() {
  //   isExpanded.value = !isExpanded.value;
  // }

  // Expand Answer
  var expandedStates = <int, bool>{}.obs;

  void toggleExpanded(int index) {
    expandedStates[index] = !(expandedStates[index] ?? false);
  }
  bool isExpanded(int index) {
    return expandedStates[index] ?? false;
  }

  final ConfigController configController = Get.find();

  @override
  void onInit() {
    super.onInit();

  }


  Future<void> getAskQuestionCustomerList(num offset) async {
    if (offset == 0) {
      offsetCount = 0;
      isNoMoreData = false;
      askQuestionCustomerListData.clear();
    }
    isQueListLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.askQuestionCustomerList, data: {
        'api_key': apiKey,
        "customer_uni_id": uniId,
        "offset": offset
      });

      if (response.statusCode == 200) {
        askQuestionCustomerListModel = AstroQuestionCustomerListModel.fromJson(response.data);
        if (askQuestionCustomerListModel.status == AppConstants.success) {
          offsetCount = askQuestionCustomerListModel.offset!;
          isQueListSuccess(true);

          for (var element in (askQuestionCustomerListModel.data ?? [])) {
            askQuestionCustomerListData.add(element);
          }
        } else {
          if (offset == 0) {
            isQueListSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isQueListSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isQueListLoading(false);
    }
  }

  Future<void> getCalculation(String question,String astroUniId, int walletCheck, String action,) async {
    CustomProgressDialog.showDialog();
    isCalculationLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.askAstroQuestionCalculation, data: {
        "api_key": apiKey,
        "customer_uni_id": uniId
      });

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        astroQuestionCalculationModel = AstroQuestionCalculationModel.fromJson(response.data);
        if (astroQuestionCalculationModel.status == AppConstants.success) {
          isCalculationSuccess(true);

          isWalletSelected.value = walletCheck;

          walletPayableAmount.value = astroQuestionCalculationModel.data!.walletAmount.toString();

          gstAmount.value = astroQuestionCalculationModel.data!.rechargeGstValue.toString();

          totalPayableAmount.value = astroQuestionCalculationModel.data!.payableAmount.toString();

          if (action == "Open") {
            _showCalculationBottomSheet(question, astroUniId, astroQuestionCalculationModel.data);
          }
        } else {
          CustomSnackBar.showBottom(astroQuestionCalculationModel.data.toString());
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

  Future<void> questionPurchase(String question, String astroUniId, int walletCheck) async {
    AppLogger.d("questionPurchase->$astroUniId");
    CustomProgressDialog.showDialog();
    isPurchaseLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.askAstroQuestionPurchase, data: {
        'api_key': apiKey,
        "customer_uni_id": uniId,
        "astrologer_uni_id": astroUniId,
        "question": question,
        "wallet_check": walletCheck
      });
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        purchaseModel = AstroQuestionPurchaseModel.fromJson(response.data);
        if (purchaseModel.status == AppConstants.success) {
          isPurchaseSuccess(true);
          messageController.clear();
          Get.back();
          AppDialog().showPaymentSuccessDialog(AppConstants.askQuestion);
        } else {
          isPurchaseSuccess(false);
          if(purchaseModel.errorCode == AppConstants.insufficientBalance){
            CommonMethods().showInsufficientBalancedDialog();
          }
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      isPurchaseSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isPurchaseLoading(false);
    }
  }

  void _showCalculationBottomSheet(String question, String astroUniId, AstroQuestionCalculationData? calculationData) {
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
                              "Payment Detail",
                              color: ColorResources.colorPrimary,
                              fontSize: Dimensions.fontSizeLarge,
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
                                  "${configController.currencySymbol} ${calculationData?.askQuestionPrice}",
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
                                            "${configController.currencySymbol} ${walletPayableAmount.value}",
                                            color: ColorResources.black1,
                                          )),
                                    ],
                                  ),
                                ),
                              )),
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
                                        "${configController.currencySymbol} ${totalPayableAmount.value}",
                                        color: ColorResources.colorPrimary
                                    )
                                ),
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
                      ],
                    ),
                  ),
                  // const Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: CustomElevatedButton(
                        text: AppStrings.proceedToPay.tr,
                        textColor: ColorResources.toolbarText,
                        backgroundColor: ColorResources.colorPrimary,
                        onPressed: () async {
                          questionPurchase(question, astroUniId, 1);
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
