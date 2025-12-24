
import 'package:astro_brahmand/model/astrologer_detail_model.dart';
import 'package:astro_brahmand/utill/app_dialogs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:astro_brahmand/model/check_call_detail_model.dart';
import 'package:astro_brahmand/model/review_model.dart';
import 'package:astro_brahmand/model/success_model.dart';
import 'package:astro_brahmand/utill/app_strings.dart';

import '../../../../controller/razorpay_controller.dart';
import '../../../../model/astrologer_model.dart';
import '../../../../model/razorpay_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_checkbox.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_round_network_image.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../splash/controller/config_controller.dart';
import '../model/architect_calculation_model.dart';

class ArchitectProfileController extends FullLifeCycleController
    with FullLifeCycleMixin {
  final Dio _dio = Dio();

  final isLoading = false.obs;
  final isSuccess = false.obs;
  final isReviewLoading = false.obs;
  final isReviewSuccess = false.obs;
  final isCallLoading = false.obs;
  final isCallSuccess = false.obs;

  ReviewModel reviewModel = ReviewModel();
  CheckCallDetailModel checkCallDetailModel = CheckCallDetailModel();
  SuccessModel startVoiceCallModel = SuccessModel();

  var isFollowLoading = false.obs;
  RxBool isFollow = false.obs;
  SuccessModel astrologerFollowModel = SuccessModel();

  //Astrologer
  final AstrologerData astrologer = Get.arguments['data']; //Initial Data
  final isAstrologerLoading = false.obs;
  final isAstrologerSuccess = false.obs;
  AstrologerDetailModel astrologerModel = AstrologerDetailModel();
  var astrologerData = AstrologerData().obs;

  //Calculation
  final isCalculationLoading = false.obs;
  final isCalculationSuccess = false.obs;
  final isWalletSelected = 0.obs;
  RxString walletPayableAmount = '0'.obs;
  RxString totalPayableAmount = '0'.obs;
  RxString gstAmount = '0'.obs;
  ArchitectCalculationModel architectCalculation = ArchitectCalculationModel();

  //Purchase
  final isPurchaseLoading = false.obs;
  final isPurchaseSuccess = false.obs;
  RazorpayModel razorpayModel = RazorpayModel();

  final ConfigController configController = Get.find();

  @override
  void onInit() {
    super.onInit();
    astrologerData.value = astrologer;
    isFollow.value = astrologer.isFollow as bool;
    getAstrologerDetail(astrologer.astrologerUniId.toString());
  }

  @override
  void onResumed() {
    getAstrologerDetail(astrologer.astrologerUniId.toString());
  }

  Future<void> getAstrologerDetail(String astrologerUniId) async {
    print(astrologerUniId);
    isAstrologerLoading(true);
    try {
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getAstrologerDetail,
          data: {"user_uni_id": uniId, "astrologer_uni_id": astrologerUniId});
      if (response.statusCode == 200) {
        astrologerModel = AstrologerDetailModel.fromJson(response.data);
        if (astrologerModel.status == AppConstants.success) {
          isAstrologerSuccess(true);
          astrologerData.value = astrologerModel.data!;
          isFollow.value = astrologerModel.data!.isFollow as bool;
        } else {
          isAstrologerSuccess(false);
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      isAstrologerSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isAstrologerLoading(false);
    }
  }

  Future<void> getAllReviews(int offset, String astrologerUniId) async {
    isReviewLoading(true);
    print(astrologerUniId);
    try {
      final response = await _dio.post(AppConstants.getReviews,
          data: {'offset': offset, "astrologer_uni_id": astrologerUniId});
      if (response.statusCode == 200) {
        reviewModel = ReviewModel.fromJson(response.data);
        if (reviewModel.status == AppConstants.success) {
          isReviewSuccess(true);
        } else {
          isReviewSuccess(false);
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      isReviewSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isReviewLoading(false);
    }
  }

  Future<void> astrologerFollow(String status, String astrologerUniId) async {
    isFollowLoading(true);
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.astrologerFollow, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'astrologer_uni_id': astrologerUniId,
        'status': status
      });
      if (response.statusCode == 200) {
        astrologerFollowModel = SuccessModel.fromJson(response.data);
        if (astrologerFollowModel.status == AppConstants.success) {
          if (status == "1") {
            isFollow(true);
          } else {
            isFollow(false);
          }
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isFollowLoading(false);
    }
  }

  void showTypeBottomSheet(String isOldNew,String mainType,String subTypeLayout,String subTypeComplete,String completePrice,
      String layoutPrice, AstrologerData astrologer) {
    String selectedType = "";
    Get.bottomSheet(
        Container(
      color: ColorResources.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CustomRoundNetworkImage(
                        imageUrl: astrologer.astroImg.toString(),
                        height: 40,
                        width: 40),
                    Expanded(
                      child: CustomTextMedium(
                        astrologer.displayName.toString(),
                        fontSize: Dimensions.fontSizeDefault,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        color: ColorResources.black1,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Image.asset(
                          'assets/images/close.png',
                          height: Dimensions.iconImageHeightOver,
                          color: ColorResources.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1.5),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: CustomTextMedium("$mainType Floor Plan",
                          fontSize: Dimensions.fontSizeDefault),
                    ),
                    CustomTextRegular(
                      "Price ${configController.currencySymbol} $layoutPrice/-",
                      color: ColorResources.colorPrimaryDark,
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                    const Gap(Dimensions.gapExtraSmall),
                    Visibility(
                      visible: isOldNew == "new",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: CustomTextMedium("$mainType Layout With Complete Elevation",
                                fontSize: Dimensions.fontSizeDefault),
                          ),
                          CustomTextRegular(
                            "Price ${configController.currencySymbol} $completePrice/-",
                            color: ColorResources.colorPrimaryDark,
                            fontSize: Dimensions.fontSizeDefault,
                          ),
                          const Gap(Dimensions.gapExtraSmall),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: CustomTextMedium("HOW IT WORKS ?",
                          fontSize: Dimensions.fontSizeDefault),
                    ),
                    CustomTextRegular(
                      "Simply click 'Start' button to initiate session.Your session will be active for the next 24 hours.",
                      color: ColorResources.black1,
                      fontSize: Dimensions.fontSizeSmall,
                    ),
                    const Gap(Dimensions.gapExtraSmall),
                    const Divider(),
                    GestureDetector(
                      onTap: (){
                        Get.back(); //Close dialog
                        selectedType = subTypeLayout;
                        getCalculation(selectedType, astrologer.astrologerUniId.toString(), 0, "Open");
                      },
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: ColorResources.colorPrimary, // Container color
                          borderRadius: BorderRadius.circular(8.0), // Radius value
                        ),
                        child: Column(
                        children: [
                          CustomTextRegular(
                            "$mainType Floor Plan",
                            color: ColorResources.white,
                            fontSize: Dimensions.fontSizeSmall,
                          ),
                          CustomTextRegular(
                            "PAY ${configController.currencySymbol} $layoutPrice/-",
                            color: ColorResources.white,
                            fontSize: Dimensions.fontSizeDefault,
                          ),
                        ],
                      ),),
                    ),

                    Visibility(
                      visible: isOldNew == "new",
                      child: Column(
                        children: [
                          const Gap(Dimensions.gapExtraSmall),
                          GestureDetector(
                            onTap: (){
                              Get.back(); //Close dialog
                              selectedType = subTypeComplete;
                              getCalculation(selectedType, astrologer.astrologerUniId.toString(), 0, "Open");
                            },
                            child: Container(
                              width: Get.width,
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: ColorResources.colorPrimary, // Container color
                                borderRadius: BorderRadius.circular(8.0), // Radius value
                              ),
                              child: Column(
                                children: [
                                  CustomTextRegular(
                                    "$mainType Layout With Complete Elevation",
                                    color: ColorResources.white,
                                    fontSize: Dimensions.fontSizeSmall,
                                  ),
                                  CustomTextRegular(
                                    "PAY ${configController.currencySymbol} $completePrice/-",
                                    color: ColorResources.white,
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                                ],
                              ),),
                          ),
                        ],
                      ),
                    ),

                    const Gap(10),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/wallet");
                      },
                      child: Center(
                        child: CustomTextRegular(
                          "Recharge",
                          color: ColorResources.colorPrimary,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> getCalculation(String type,String astrologerId, int walletCheck, String action) async {
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
      await _dio.post(AppConstants.architectServiceCalculation, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "astrologer_uni_id": astrologerId,
        "call_type": type,
        "wallet_check": walletCheck,
        "payment_method": payMethod
      });

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        architectCalculation = ArchitectCalculationModel.fromJson(response.data);
        if (architectCalculation.status == AppConstants.success) {
          isCalculationSuccess(true);

          isWalletSelected.value = walletCheck;

          walletPayableAmount.value =
              architectCalculation.data!.walletAmount.toString();

          gstAmount.value = architectCalculation.data!.rechargeGstValue.toString();

          totalPayableAmount.value =
              architectCalculation.data!.payableAmount.toString();

          if (action == "Open") {
            _showCalculationBottomSheet(
                type,astrologerId,architectCalculation.data);
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

  void _showCalculationBottomSheet(String type,String astrologerId, ArchitectCalculationData? calculationData) {
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: CustomTextMedium(
                            "${AppStrings.vastuArchitect.tr} Detail",
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
                                "Architect Consultant",
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
                                    ?.architectServiceAmount}",
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
                            getCalculation(
                                type, astrologerId, 1, "Wallet");
                          } else {
                            getCalculation(
                                type, astrologerId, 0, "Wallet");
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
                      backgroundColor: ColorResources.colorPrimary,
                      onPressed: () async {
                        print("AS1");
                        String? payMethod =
                        await SharedPreferencesHelper.getData(
                            AppConstants.paymentGateway);
                        if (payMethod == AppConstants.payRazorpay ||
                            payMethod == AppConstants.payCCAvenue) {
                          architectServicePurchase(astrologerId,type,isWalletSelected.value,payMethod.toString());
                        } else {
                          CustomSnackBar.showBottom('No Payment Gateway Found');
                        }
                      }),
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
      isScrollControlled: true,
    );
  }

  Future<void> architectServicePurchase(
      String astrologerUniId, String type, int walletCheck, String paymentMethod) async {
    isPurchaseLoading(true);
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.architectServicePurchase, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "astrologer_uni_id": astrologerUniId,
        "call_type": type,
        "wallet_check": walletCheck,
        "payment_method": paymentMethod
      });
      print("Req -> $apiKey $uniId $astrologerUniId $type $walletCheck $paymentMethod");


      if (response.statusCode == 200) {
        razorpayModel = RazorpayModel.fromJson(response.data);
        if (razorpayModel.status == AppConstants.success) {
          isPurchaseSuccess(true);
          Get.back(); //Hide payment info bottom sheet
          final RazorpayController razorpayController =
          Get.put(RazorpayController());
          if (razorpayModel.paymentGatewayStatus == AppConstants.success) {
            razorpayController.openCheckout(razorpayModel.paymentGateway!, "Architect Service Purchase", uniId,AppConstants.architect);
          } else {
            AppDialog().showPaymentSuccessDialog(AppConstants.architect);
          }
        } else {
          CustomSnackBar.showBottom(razorpayModel.msg.toString());
          isPurchaseSuccess(false);
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

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }
}
