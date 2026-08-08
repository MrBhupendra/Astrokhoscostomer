import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/model/products_model.dart';

import '../../../../controller/ccavenue_controller.dart';
import '../../../../controller/phonepe_controller.dart';
import '../../../../controller/razorpay_controller.dart';
import '../../../../model/ccavenue_wallet_recharge_model.dart';
import '../../../../model/group_pooja_calculation_model.dart';
import '../../../../model/group_puja_astrologer_list_model.dart';
import '../../../../model/group_puja_category_model.dart';
import '../../../../model/group_pujas_list_model.dart';
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
import '../../../widget/custom_payment_status_dialog.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../splash/controller/config_controller.dart';
import '../../webview/ccavenue_webview_screen.dart';
import '../../webview/payment_webview_screen.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class GroupPoojaController extends GetxController {
  final Dio _dio = Dio();
  final isLoading = false.obs;
  final isSuccess = false.obs;

  // Group Pooja category
  final isCategoryLoading = false.obs;
  final isCategorySuccess = false.obs;
  GroupPujaCategoryModel groupPujaCategoryModel = GroupPujaCategoryModel();

  // GroupPoojaList
  final isGroupPoojaLoading = false.obs;
  final isGroupPoojaSuccess = false.obs;
  GroupPujasListModel groupPujasListModel = GroupPujasListModel();
  GroupPoojaListData groupPoojaListData = GroupPoojaListData();

  List<ProductsData> productListData = [];
  num serviceOffsetCount = 0;
  bool serviceIsNoMoreData = false;

  //Astrologer
  final isAstrologerLoading = false.obs;
  final isAstrologerSuccess = false.obs;
  GroupPujaAstrologerListModel groupPujaAstrologerListModel = GroupPujaAstrologerListModel();
  List<GroupPoojaAstrologerListData> groupPoojaAstrologerListData = [];

  bool astrologerIsNoMoreData = false;
  ScrollController astrologerScrollController = ScrollController();
  num astrologerOffsetCount = 0;

  // Search
  final searchQuery = ''.obs;
  Timer? debounce;
  num offsetCount = 0;
  String categoryId = "";

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
  GroupPoojaCalculationModel groupPoojaCalculationModel = GroupPoojaCalculationModel();

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

  final ConfigController configController = Get.find();

  void searchGroupPoojaCategory(String query) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(seconds: 1), () {
      searchQuery.value = query;
      offsetCount = 0;
      getGroupPoojaCategory("", query);
    });
  }

  Future<void> getGroupPoojaCategory(String offset, String search) async {
    isCategoryLoading(true);
    try {
      final response = await _dio.post(AppConstants.getGroupPujaCategory,
          data: {'offset': offset, "search": search});
      if (response.statusCode == 200) {
        groupPujaCategoryModel = GroupPujaCategoryModel.fromJson(response.data);
        if (groupPujaCategoryModel.status == AppConstants.success) {
          isCategorySuccess(true);
        } else {
          isCategorySuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isCategorySuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isCategoryLoading(false);
    }
  }

  Future<void> getGroupPoojaList(num offset, String categoryId, String search, {String slug = ''}) async {
    isGroupPoojaSuccess(false);
    isGroupPoojaLoading(true);
    try {
      final response = await _dio.post(AppConstants.getGroupPujas, data: {
        'group_puja_category_id': categoryId,
        "search": search,
        "slug": slug,
        'offset': offset,
      });

      AppLogger.d("request $offset $categoryId $search $slug");
      if (response.statusCode == 200) {
        groupPujasListModel = GroupPujasListModel.fromJson(response.data);
        if (groupPujasListModel.status == AppConstants.success) {
          if (groupPujasListModel.data!.isNotEmpty) {
            isGroupPoojaSuccess(true);
          } else {
            isGroupPoojaSuccess(false);
          }
        } else {
          isGroupPoojaSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isGroupPoojaSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isGroupPoojaLoading(false);
    }
  }

  Future<void> getGroupPujaAstrologerList(num offset, String groupPoojaId,{String astrologerUniId = ""}) async {
    if (offset == 0) {
      isAstrologerSuccess(false);
      astrologerOffsetCount = 0;
      astrologerIsNoMoreData = false;
      groupPoojaAstrologerListData.clear();
    }
    isAstrologerLoading(true);
    try {

      final response = await _dio.post(AppConstants.getGroupPujaAstrologerList, data: {
        "astrologer_uni_id" : "",
        "group_puja_id": groupPoojaId,
        "offset": offset,
      });

      if (response.statusCode == 200) {
        groupPujaAstrologerListModel = GroupPujaAstrologerListModel.fromJson(response.data);
        if (groupPujaAstrologerListModel.status == AppConstants.success) {
          astrologerOffsetCount = groupPujaAstrologerListModel.offset!;

          for (var element in (groupPujaAstrologerListModel.data ?? [])) {
            groupPoojaAstrologerListData.add(element);
          }
          isAstrologerSuccess(true);
        }
        else {
          if (offset == 0) {
            isAstrologerSuccess(false);
          }
          astrologerIsNoMoreData = true;
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isAstrologerSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isAstrologerLoading(false);
    }
  }

  Future<void> getGroupPoojaCalculation(String groupPoojaAssignId,String astrologerId, int walletCheck, GroupPoojaListData groupPoojaListData, String action,String duration,BuildContext context) async {
    mContext = context;
    CustomProgressDialog.showDialog();
    isCalculationLoading(true);
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getGroupPujaCalculation, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "group_puja_assign_id": groupPoojaAssignId,
        "astrologer_uni_id": astrologerId,
        "customer_uni_id": uniId,
        "wallet_check": walletCheck,
      });
      AppLogger.d(groupPoojaAssignId);
      AppLogger.d(walletCheck.toString());
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        groupPoojaCalculationModel = GroupPoojaCalculationModel.fromJson(response.data);
        if (groupPoojaCalculationModel.status == AppConstants.success) {
          isCalculationSuccess(true);

          isWalletSelected.value = walletCheck;

          walletPayableAmount.value = groupPoojaCalculationModel.data!.walletAmount.toString();

          gstAmount.value = groupPoojaCalculationModel.data!.rechargeGstValue.toString();

          totalPayableAmount.value = groupPoojaCalculationModel.data!.payableAmount.toString();

          if (action == "Open") {
            _showCalculationBottomSheet(groupPoojaAssignId, astrologerId,duration,groupPoojaCalculationModel.data, groupPoojaListData);
          }
        } else {
          CustomSnackBar.showBottom(groupPoojaCalculationModel.msg.toString());
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

  void _showCalculationBottomSheet(
      String groupPoojaAssignId,
      String astrologerId,
      String duration,
      GroupPoojaCalculationData? calculationData,
      GroupPoojaListData groupPoojaListData) {
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
                              AppStrings.importantNotice,
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
                                    groupPoojaListData.groupPujaName.toString(),
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
                          ),
        
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
                                  "${configController.currencySymbol} ${calculationData?.groupPujaAmount}",
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
                              getGroupPoojaCalculation(
                                  groupPoojaAssignId,
                                  astrologerId,
                                  1,
                                  groupPoojaListData,
                                  duration,
                                  "Wallet",
                              mContext!);
                            } else {
                              getGroupPoojaCalculation(
                                  groupPoojaAssignId,
                                  astrologerId,
                                  0,
                                  groupPoojaListData,
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
                  //             servicePurchaseRazorpay(groupPoojaAssignId, astrologerId, CommonMethods().convertDateInput(birthDateController.text.toString()),CommonMethods().convertTimeInput(birthTimeController.text.toString()) ,isWalletSelected.value, payMethod.toString());
                  //           }else if (payMethod == AppConstants.payCCAvenue) {
                  //             servicePurchaseCCAvenue(groupPoojaAssignId, astrologerId, CommonMethods().convertDateInput(birthDateController.text.toString()),CommonMethods().convertTimeInput(birthTimeController.text.toString()) ,isWalletSelected.value, payMethod.toString());
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
                                  groupPoojaPurchase(
                                      groupPoojaAssignId,
                                      astrologerId,
                                      isWalletSelected.value,
                                      configController.paymentGatewayList[index].payMethod.toString()
                                  );
                                }else{
                                  groupPoojaPurchase(
                                      groupPoojaAssignId,
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
                                AppLogger.d("groupPoojaAssignId$groupPoojaAssignId");
                                String? defaultPayMethod = configController.config.data?.payment?.defaultPaymentGateway.toString();
                                String? defaultPayMethodInternational = configController.config.data?.paymentForOtherCountry?.defaultPaymentGateway.toString();
                                if(configController.phoneCode == AppConstants.defaultPhoneCode){
                                  groupPoojaPurchase(
                                      groupPoojaAssignId,
                                      astrologerId,
                                      isWalletSelected.value,
                                      defaultPayMethod.toString()
                                  );
                                }else {
                                  groupPoojaPurchase(
                                      groupPoojaAssignId,
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

  Future<void> servicePurchaseRazorpay(String groupPoojaAssignId,String astrologerId,String date,String time,int walletCheck, String paymentMethod) async {
    CustomProgressDialog.showDialog();
    isPurchaseLoading(true);
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.purchaseService, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "service_assign_id": groupPoojaAssignId,
        "astrologer_uni_id": astrologerId,
        "customer_uni_id": uniId,
        "date": date,
        "time": time,
        "wallet_check": walletCheck,
        "payment_method": paymentMethod
      });

      AppLogger.d("Req data $apiKey $uniId $groupPoojaAssignId $astrologerId $uniId $date $time $walletCheck $paymentMethod");

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        razorpayModel = RazorpayModel.fromJson(response.data);
        if (razorpayModel.status == AppConstants.success) {
          isPurchaseSuccess(true);
          final RazorpayController razorpayController = Get.put(RazorpayController());
          if (razorpayModel.paymentGatewayStatus == AppConstants.success) {
            razorpayController.openCheckout(razorpayModel.paymentGateway!,"Group Pooja Purchase", uniId,AppConstants.groupPoojaOrder);
          } else {
            AppDialog().showPaymentSuccessDialog(AppConstants.groupPoojaOrder);
          }
        } else {
          CustomSnackBar.showBottom(razorpayModel.msg.toString());
          isPurchaseSuccess(false);
        }
      } else {
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

  Future<void> servicePurchaseCCAvenue(String groupPoojaAssignId,String astrologerId,String date,String time,int walletCheck,
      String paymentMethod) async {
    CustomProgressDialog.showDialog();
    isPurchaseLoading(true);
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.purchaseService, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "service_assign_id": groupPoojaAssignId,
        "astrologer_uni_id": astrologerId,
        "customer_uni_id": uniId,
        "date": date,
        "time": time,
        "wallet_check": walletCheck,
        "payment_method": paymentMethod
      });

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        ccAvenueModel = CcAvenueWalletRechargeModel.fromJson(response.data);
       // String otpOrderId = response.data['otpless_orderId'];
        if (ccAvenueModel.status == AppConstants.success) {
          isPurchaseSuccess(true);

          try {
            AppEvents().sendInitCheckoutEvent(
                "",
                ccAvenueModel.ccavenueData!.orderId.toString(),
                uniId.toString(),
                AppConstants.groupPoojaOrder);
          } catch (e) {
            AppLogger.d("Error Event openCheckout: $e");
          }

          final CCAvenueController ccAvenueController = Get.put(CCAvenueController());
          if (ccAvenueModel.paymentGatewayStatus == AppConstants.success) {
            var result = await Get.to(() => CCAvenueWebViewScreen(
                ccAvenueModel.ccavenueData!.encVal.toString(),
                ccAvenueModel.ccavenueData!.accessCode.toString()));
            if (result != null) {
              String status = result['status'].toString();
              if (status == "Success") {
                ccAvenueController.updateOnlinePayment(
                    "",
                    ccAvenueModel.ccavenueData!.orderId.toString(),
                    ccAvenueModel.ccavenueData!.orderId.toString(),
                    uniId.toString(),
                    AppConstants.groupPoojaOrder);
              } else {
                Future.delayed(const Duration(milliseconds: 500), () {
                  AppDialog().showPaymentFailedDialog();
                });
              }
            } else {
              Future.delayed(const Duration(milliseconds: 500), () {
                AppDialog().showPaymentFailedDialog();
              });
            }

          } else {
            AppDialog().showPaymentSuccessDialog(AppConstants.groupPoojaOrder);
            // ccAvenueController.showSuccessDialog(ccAvenueModel.orderId.toString(), AppConstants.groupPoojaOrder);
          }

        } else {
          CustomSnackBar.showBottom(ccAvenueModel.msg.toString());
          isPurchaseSuccess(false);
        }
      } else {
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

  Future<void> groupPoojaPurchase(String groupPoojaAssignId,String astrologerId,int walletCheck, String paymentMethod) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.purchaseGroupPuja, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "group_puja_assign_id": groupPoojaAssignId,
        "astrologer_uni_id": astrologerId,
        "customer_uni_id": uniId,
        "wallet_check": walletCheck,
        "payment_method": paymentMethod
      });

      AppLogger.d("Req data $apiKey $uniId $groupPoojaAssignId $astrologerId $uniId $walletCheck $paymentMethod");

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        if(paymentMethod == AppConstants.payRazorpay){
          razorpayModel = RazorpayModel.fromJson(response.data);
          if (razorpayModel.status == AppConstants.success) {
            final RazorpayController razorpayController = Get.put(RazorpayController());
            if (razorpayModel.paymentGatewayStatus == AppConstants.success) {
              razorpayController.openCheckout(razorpayModel.paymentGateway!,"Group Pooja Purchase", uniId,AppConstants.groupPoojaOrder);
            } else {
              AppDialog().showPaymentSuccessDialog(AppConstants.groupPoojaOrder);
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
              Get.to(() => PaymentWebViewScreen(AppConstants.appName,url,AppConstants.groupPoojaOrder,"Group Pooja Purchase"));
              try {
                AppEvents().sendInitCheckoutEvent(ccAvenueModel.data!.amount.toString(), ccAvenueModel.ccavenueData!.orderId.toString(), uniId.toString(), AppConstants.groupPoojaOrder);
              } catch (e) {
                AppLogger.d("Error Event openCheckout: $e");
              }
            }else{
              AppDialog().showPaymentSuccessDialog(AppConstants.groupPoojaOrder);
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
              phonePeController.startTransaction(phonePeModel.phonepeData!.encode.toString(),phonePeModel.phonepeData!.data!.callbackUrl.toString(),phonePeModel.phonepeData!.finalXHeader.toString(), AppConstants.groupPoojaOrder,phonePeModel.phonepeData!.orderId.toString(),phonePeModel.phonepeData!.orderId.toString(),
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
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    }
  }
}
