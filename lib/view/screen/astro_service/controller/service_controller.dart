import 'dart:async';

import 'package:astro_brahmand/view/screen/astro_service/model/service_astrologer_list_model.dart';
import 'package:astro_brahmand/view/screen/astro_service/model/service_calculation_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/model/products_model.dart';

import '../../../../controller/cash_free_controller.dart';
import '../../../../controller/ccavenue_controller.dart';
import '../../../../controller/phonepe_controller.dart';
import '../../../../controller/razorpay_controller.dart';
import '../../../../model/cashfree_model.dart';
import '../../../../model/ccavenue_wallet_recharge_model.dart';
import '../../../../model/paypal_model.dart';
import '../../../../model/payu_payment_model.dart';
import '../../../../model/phonepe_model.dart';
import '../../../../model/razorpay_model.dart';
import '../../../../model/service_category_model.dart';
import '../../../../model/services_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_dialogs.dart';
import '../../../../utill/app_events.dart';
import '../../../../utill/app_features.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/common_methods.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_checkbox.dart';
import '../../../widget/custom_payment_status_dialog.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../offer_code/controller/offer_code_controller.dart';
import '../../splash/controller/config_controller.dart';
import '../../webview/ccavenue_webview_screen.dart';
import '../../webview/payment_webview_screen.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class ServiceController extends GetxController {
  final Dio _dio = Dio();
  final isLoading = false.obs;
  final isSuccess = false.obs;

  // Service category
  final isCategoryLoading = false.obs;
  final isCategorySuccess = false.obs;
  ServiceCategoryModel serviceCategoryModel = ServiceCategoryModel();

  // Products
  final isServiceLoading = false.obs;
  final isServiceSuccess = false.obs;
  ServicesModel serviceModel = ServicesModel();
  ServicesData serviceData = ServicesData();

  List<ProductsData> productListData = [];
  num serviceOffsetCount = 0;
  bool serviceIsNoMoreData = false;

  //Astrologer
  final isAstrologerLoading = false.obs;
  final isAstrologerSuccess = false.obs;
  ServiceAstrologerListModel astrologerModel = ServiceAstrologerListModel();
  List<ServiceAstrologerData> astrologerListData = [];

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
  RxString offerDiscount = '0'.obs;
  RxString refId = ''.obs;
  RxString offerMsg = ''.obs;
  ServiceCalculationModel serviceCalculationModel = ServiceCalculationModel();

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
  PayuPaymentModel payuPaymentModel = PayuPaymentModel();

  final CashFreeController cashfreeController = Get.put(CashFreeController());
  CashfreeModel cashfreeModel = CashfreeModel();

  final ConfigController configController = Get.find();

  // Offer Code
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _offerCodeController = TextEditingController();
  RxString offerStatus = ''.obs;
  // Update offerStatus dynamically
  void updateOfferStatus(String status) {
    offerStatus.value = status;
  }

  @override
  void onInit() {
    super.onInit();
    CFPaymentGatewayService().setCallback(cashfreeController.onVerify, cashfreeController.onError);
  }

  void searchServiceCategory(String query) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(seconds: 1), () {
      searchQuery.value = query;
      offsetCount = 0;
      getServiceCategory("", query);
    });
  }

  Future<void> getServiceCategory(String offset, String search) async {
    isCategoryLoading(true);
    try {
      final response = await _dio.post(AppConstants.getServiceCategory,
          data: {'offset': offset, "search": search});
      if (response.statusCode == 200) {
        serviceCategoryModel = ServiceCategoryModel.fromJson(response.data);
        if (serviceCategoryModel.status == AppConstants.success) {
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

  Future<void> getServices(num offset, String categoryId, String search, {String slug = ''}) async {
    isServiceSuccess(false);
    isServiceLoading(true);
    try {
      final response = await _dio.post(AppConstants.getServices, data: {
        'offset': offset,
        'service_category_id': categoryId,
        "search": search,
        "slug": slug
      });

      AppLogger.d("request $offset $categoryId $search $slug");
      if (response.statusCode == 200) {
        serviceModel = ServicesModel.fromJson(response.data);
        if (serviceModel.status == AppConstants.success) {
          if (serviceModel.data!.isNotEmpty) {
            isServiceSuccess(true);
          } else {
            isServiceSuccess(false);
          }
        } else {
          isServiceSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isServiceSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isServiceLoading(false);
    }
  }

  Future<void> getAstrologer(num offset, String serviceId,{String astrologerUniId = ""}) async {
    if (offset == 0) {
      isAstrologerSuccess(false);
      astrologerOffsetCount = 0;
      astrologerIsNoMoreData = false;
      astrologerListData.clear();
    }
    isAstrologerLoading(true);
    try {
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getServiceAstrologers, data: {
        "user_uni_id": uniId,
        "offset": offset,
        "service_id": serviceId,
        "astrologer_uni_id" : astrologerUniId
      });

      AppLogger.d("Request $uniId $offset $serviceId");

      if (response.statusCode == 200) {
        astrologerModel = ServiceAstrologerListModel.fromJson(response.data);
        AppLogger.d("Response-> ${response.data.toString()}");
        if (astrologerModel.status == AppConstants.success) {
          astrologerOffsetCount = astrologerModel.offset!;

          for (var element in (astrologerModel.data ?? [])) {
            astrologerListData.add(element);
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

  Future<void> getServiceCalculation(String serviceAssignId,String astrologerId, int walletCheck,
      ServicesData serviceData, String action,String duration,String offerCode,BuildContext context) async {
    mContext = context;
    CustomProgressDialog.showDialog();
    isCalculationLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      // String? payMethod = await SharedPreferencesHelper.getData(AppConstants.paymentGateway);
      String? payMethod = configController.config.data?.payment?.defaultPaymentGateway.toString();

      final response = await _dio.post(AppConstants.manageService, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "service_assign_id": serviceAssignId,
        "astrologer_uni_id": astrologerId,
        "customer_uni_id": uniId,
        "wallet_check": walletCheck,
        "payment_method": payMethod,
        "offer_code": offerCode
      });

      if (response.statusCode == 200) {
        AppLogger.d("getServiceCalculation Response ${response.data.toString()} \n $serviceAssignId, $astrologerId, $payMethod");
        CustomProgressDialog.dismissDialog();
        serviceCalculationModel = ServiceCalculationModel.fromJson(response.data);
        if (serviceCalculationModel.status == AppConstants.success) {
          isCalculationSuccess(true);

          isWalletSelected.value = walletCheck;

          walletPayableAmount.value = serviceCalculationModel.data!.walletAmount.toString();

          gstAmount.value = serviceCalculationModel.data!.rechargeGstValue.toString();

          offerDiscount.value = serviceCalculationModel.data!.offerAmmount.toString();

          totalPayableAmount.value = serviceCalculationModel.data!.payableAmount.toString();

          offerMsg.value = serviceCalculationModel.msg.toString();

          updateOfferStatus(serviceCalculationModel.data!.couponStatus.toString());

          if (action == "Open") {
            birthDateController.text = "";
            birthTimeController.text = "";
            _offerCodeController.text = "";
            _showCalculationBottomSheet(serviceAssignId, astrologerId,duration,serviceCalculationModel.data, serviceData);
          }
        } else {
          updateOfferStatus(serviceCalculationModel.data!.couponStatus.toString());
          CustomSnackBar.showBottom(serviceCalculationModel.msg.toString());
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
      String serviceAssignId,
      String astrologerId,
      String duration,
      ServiceCalculationData? calculationData,
      ServicesData serviceData) {
    final OfferCodeController offerCodeController = Get.put(OfferCodeController());
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
                              AppStrings.serviceDetail.tr,
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
                                    AppStrings.name.tr,
                                    color: ColorResources.black1,
                                  ),
                                ),
                                Expanded(
                                  child: CustomTextRegular(
                                    serviceData.serviceName.toString(),
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
                                    AppStrings.duration.tr,
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
                                  AppStrings.price.tr,
                                  color: ColorResources.black1,
                                ),
                                CustomTextRegular(
                                  "${configController.currencySymbol} ${calculationData?.serviceAmount}",
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextRegular(
                                    AppStrings.wallet.tr,
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextRegular(
                                  AppStrings.offerDiscount.tr,
                                  color: ColorResources.colorPrimaryDark,
                                ),
                                Obx(() => CustomTextRegular(
                                  "-${configController.currencySymbol} ${offerDiscount.value}",
                                  color: ColorResources.colorPrimaryDark,
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
                                CustomTextMedium(AppStrings.totalPayable.tr,
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
        
                  const Gap(Dimensions.gapDefault),
                  CustomText(hintText: AppStrings.bookingDate.tr),
                  const Gap(Dimensions.gapExtraSmall),
                  GestureDetector(
                    onTap: () async {
                      CommonMethods().showFutureDatePickerDialog(
                          mContext!,
                          birthDateController);
                    },
                    child: CustomTextField(
                      controller: birthDateController,
                      hintText: AppStrings.selectDateForService.tr,
                      enabled: false,
                    ),
                  ),
        
                  const Gap(Dimensions.gapDefault),
                  const CustomText(hintText: AppStrings.bookingTime),
                  const SizedBox(height: Dimensions.gapExtraSmall),
                  GestureDetector(
                    onTap: () async {
                      CommonMethods().showTimerPickerDialog(
                          mContext!,
                          birthTimeController);
                    },
                    child: CustomTextField(
                      controller: birthTimeController,
                      hintText: AppStrings.selectTimeForService.tr,
                      enabled: false,
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                  // CustomTextRegular("Offer Code:"),
                  // const SizedBox(height: Dimensions.gapExtraSmall),
                  // Offer Code
                  Visibility(
                    visible: AppFeatures.offerCode,
                    child: Form(
                      key: _formKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: _offerCodeController,
                                style: const TextStyle(
                                  color: ColorResources.black,
                                  fontSize: Dimensions.fontSizeDefault,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: ColorResources.colorPrimary,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                  isDense: true,
                                  hintText: AppStrings.enterCouponCode.tr,
                                  prefixIcon: const IconTheme(
                                    data: IconThemeData(
                                      color: ColorResources.colorPrimaryDark,
                                      size: 18,
                                    ),
                                    child: Icon(Icons.discount_outlined),
                                  ),
                                  hintStyle: const TextStyle(
                                    fontSize: Dimensions.fontSizeDefault,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                    color: ColorResources.black4,
                                  ),
                                ),
                                textCapitalization: TextCapitalization.characters,
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return AppStrings.codeError.tr;
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                          ),
                          const Gap(8),
                          CustomButton(
                            AppStrings.apply.tr.toUpperCase(),
                            color: ColorResources.toolbarText,
                            onPressed: () {
                              if (FocusManager.instance.primaryFocus != null) {
                                FocusManager.instance.primaryFocus!.unfocus();
                              }
                              if(_offerCodeController.text.isNotEmpty){
                                getServiceCalculation(
                                    serviceAssignId,
                                    astrologerId,
                                    isWalletSelected.value,
                                    serviceData,
                                    "",
                                    duration,
                                    _offerCodeController.text.toString(),
                                    mContext!
                                );
                              }else{
                                CustomSnackBar.showBottom(AppStrings.codeError.tr);
                              }
                            },
                            minimumSize: const Size(45, 36),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Check Coupon Status
                  Obx((){
                    if(offerStatus.value == "1"){
                      return Padding(
                        padding: const EdgeInsets.only(left: 4.0,top: 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(Images.couponCode,height: 16,width: 16,color: Colors.green),
                            const Gap(6),
                            CustomTextMedium(
                              AppStrings.couponCodeApplied.tr,
                              color: Colors.green,
                              fontSize: Dimensions.fontSizeSmall,
                            ),
                            const Gap(2)
                          ],
                        ),
                      );
                    }else if(offerStatus.value == "0"){
                      return Padding(
                        padding: const EdgeInsets.only(left: 4.0,top: 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline,color: Colors.red,size: 16),
                            const Gap(6),
                            CustomTextMedium(
                              offerMsg.toString(),
                              color: Colors.red,
                              fontSize: Dimensions.fontSizeSmall,
                            ),
                            const Gap(2)
                          ],
                        ),
                      );
                    }else{
                      return const SizedBox();
                    }
                  }),
                  const Gap(10),
                  Visibility(
                    visible: AppFeatures.offerCode,
                    child: Container(
                      padding: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: ColorResources.colorPrimaryLight,
                        borderRadius: BorderRadius.circular(8.0),
                        // border: Border.all(color: ColorResources.colorPrimary)
                      ),
                      child: Row(
                        children: [
                          Image.asset(Images.offerCode,height: 20,width: 20),
                          const Gap(10),
                          Expanded(
                              child: CustomTextRegular(
                                AppStrings.availableOffer.tr,
                                color: ColorResources.black2,
                                fontSize: Dimensions.fontSizeSmall,
                              )
                          ),
                          InkWell(
                              onTap: (){
                                offerCodeController.offerCodeBottomSheet(mContext!,_offerCodeController,
                                    applyOffer:  (){
                                      getServiceCalculation(
                                          serviceAssignId,
                                          astrologerId,
                                          isWalletSelected.value,
                                          serviceData,
                                          "",
                                          duration,
                                          _offerCodeController.text.toString(),
                                          mContext!
                                      );
                                    });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CustomTextMedium(
                                    AppStrings.viewAll.tr,
                                    fontSize: Dimensions.fontSizeSmall,
                                    color: ColorResources.colorPrimaryDark
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
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
                              CustomTextRegular(AppStrings.wallet.tr),
                              CustomTextRegular(
                                "${AppStrings.availableForPayment.tr} ${configController.currencySymbol} ${calculationData?.myWalletAmount}",
                                color: ColorResources.black1,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                            ],
                          ),
                        ),
                        CustomCheckbox(
                          onChanged: (isChecked) {
                            if (isChecked) {
                              getServiceCalculation(
                                  serviceAssignId,
                                  astrologerId,
                                  1,
                                  serviceData,
                                  "Wallet",
                                  duration,
                                  _offerCodeController.text.toString(),
                              mContext!);
                            } else {
                              getServiceCalculation(
                                  serviceAssignId,
                                  astrologerId,
                                  0,
                                  serviceData,
                                  "Wallet",
                                  duration,
                                  _offerCodeController.text.toString(),
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
                  //             servicePurchaseRazorpay(serviceAssignId, astrologerId, CommonMethods().convertDateInput(birthDateController.text.toString()),CommonMethods().convertTimeInput(birthTimeController.text.toString()) ,isWalletSelected.value, payMethod.toString());
                  //           }else if (payMethod == AppConstants.payCCAvenue) {
                  //             servicePurchaseCCAvenue(serviceAssignId, astrologerId, CommonMethods().convertDateInput(birthDateController.text.toString()),CommonMethods().convertTimeInput(birthTimeController.text.toString()) ,isWalletSelected.value, payMethod.toString());
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
                              if(birthDateController.text.isNotEmpty && birthTimeController.text.isNotEmpty){
                                if(configController.phoneCode == AppConstants.defaultPhoneCode){
                                  servicePurchase(
                                      serviceAssignId,
                                      astrologerId,
                                      CommonMethods().convertDateInput(birthDateController.text.toString()),
                                      CommonMethods().convertTimeInput(birthTimeController.text.toString()),
                                      isWalletSelected.value,
                                      _offerCodeController.text.toString(),
                                      configController.paymentGatewayList[index].payMethod.toString()
                                  );
                                }else{
                                  servicePurchase(
                                      serviceAssignId,
                                      astrologerId,
                                      CommonMethods().convertDateInput(birthDateController.text.toString()),
                                      CommonMethods().convertTimeInput(birthTimeController.text.toString()),
                                      isWalletSelected.value,
                                      _offerCodeController.text.toString(),
                                      configController.internationalPaymentGatewayList[index].payMethod.toString()
                                  );
                                }
                              }else if(birthDateController.text.isEmpty){
                                CustomSnackBar.showBottom(AppStrings.pleaseSelectDate.tr);
                              }else if(birthTimeController.text.isEmpty){
                                CustomSnackBar.showBottom(AppStrings.pleaseSelectTime.tr);
                              }
                              }
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextRegular(
                                AppStrings.payUsing.tr,
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
                              if(birthDateController.text.isNotEmpty && birthTimeController.text.isNotEmpty){
                                String? defaultPayMethod = configController.config.data?.payment?.defaultPaymentGateway.toString();
                                String? defaultPayMethodInternational = configController.config.data?.paymentForOtherCountry?.defaultPaymentGateway.toString();
                                if(configController.phoneCode == AppConstants.defaultPhoneCode){
                                  servicePurchase(
                                      serviceAssignId,
                                      astrologerId,
                                      CommonMethods().convertDateInput(birthDateController.text.toString()),
                                      CommonMethods().convertTimeInput(birthTimeController.text.toString()),
                                      isWalletSelected.value,
                                      _offerCodeController.text.toString(),
                                      defaultPayMethod.toString()
                                  );
                                }else {
                                  servicePurchase(
                                      serviceAssignId,
                                      astrologerId,
                                      CommonMethods().convertDateInput(birthDateController.text.toString()),
                                      CommonMethods().convertTimeInput(birthTimeController.text.toString()),
                                      isWalletSelected.value,
                                      _offerCodeController.text.toString(),
                                      defaultPayMethodInternational.toString()
                                  );
                                }
                              }else if(birthDateController.text.isEmpty){
                                CustomSnackBar.showBottom(AppStrings.pleaseSelectDate.tr);
                              }else if(birthTimeController.text.isEmpty){
                                CustomSnackBar.showBottom(AppStrings.pleaseSelectTime.tr);
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
                              AppStrings.proceedToPay.tr,
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
                          CustomTextMedium(AppStrings.recharge.tr,
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

  Future<void> servicePurchaseRazorpay(String serviceAssignId,String astrologerId,String date,String time,int walletCheck,
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
        "service_assign_id": serviceAssignId,
        "astrologer_uni_id": astrologerId,
        "customer_uni_id": uniId,
        "date": date,
        "time": time,
        "wallet_check": walletCheck,
        "payment_method": paymentMethod
      });

      AppLogger.d("Req data $apiKey $uniId $serviceAssignId $astrologerId $uniId $date $time $walletCheck $paymentMethod");

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        razorpayModel = RazorpayModel.fromJson(response.data);
        if (razorpayModel.status == AppConstants.success) {
          isPurchaseSuccess(true);
          final RazorpayController razorpayController = Get.put(RazorpayController());
          if (razorpayModel.paymentGatewayStatus == AppConstants.success) {
            razorpayController.openCheckout(razorpayModel.paymentGateway!,"Service Purchase", uniId,AppConstants.serviceOrder);
          } else {
            AppDialog().showPaymentSuccessDialog(AppConstants.serviceOrder);
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

  Future<void> servicePurchaseCCAvenue(String serviceAssignId,String astrologerId,String date,String time,int walletCheck,
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
        "service_assign_id": serviceAssignId,
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
                AppConstants.serviceOrder);
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
                    AppConstants.serviceOrder);
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
            AppDialog().showPaymentSuccessDialog(AppConstants.serviceOrder);
            // ccAvenueController.showSuccessDialog(ccAvenueModel.orderId.toString(), AppConstants.serviceOrder);
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

  Future<void> servicePurchase(String serviceAssignId,String astrologerId,String date,String time,int walletCheck, String offerCode, String paymentMethod) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.purchaseService, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "service_assign_id": serviceAssignId,
        "astrologer_uni_id": astrologerId,
        "customer_uni_id": uniId,
        "date": date,
        "time": time,
        "wallet_check": walletCheck,
        "offer_code": offerCode,
        "payment_method": paymentMethod,
      });

      AppLogger.d("Req data $apiKey $uniId $serviceAssignId $astrologerId $uniId $date $time $walletCheck $paymentMethod");

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        if(paymentMethod == AppConstants.payRazorpay){
          razorpayModel = RazorpayModel.fromJson(response.data);
          if (razorpayModel.status == AppConstants.success) {
            final RazorpayController razorpayController = Get.put(RazorpayController());
            if (razorpayModel.paymentGatewayStatus == AppConstants.success) {
              razorpayController.openCheckout(razorpayModel.paymentGateway!,"Service Purchase", uniId,AppConstants.serviceOrder);
            } else {
              AppDialog().showPaymentSuccessDialog(AppConstants.serviceOrder);
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
              Get.to(() => PaymentWebViewScreen(AppConstants.appName,url,AppConstants.serviceOrder,"Service Purchase"));
              try {
                AppEvents().sendInitCheckoutEvent(ccAvenueModel.data!.amount.toString(), ccAvenueModel.ccavenueData!.orderId.toString(), uniId.toString(), AppConstants.serviceOrder);
              } catch (e) {
                AppLogger.d("Error Event openCheckout: $e");
              }
            }else{
              AppDialog().showPaymentSuccessDialog(AppConstants.serviceOrder);
            }
          } else {
            CustomSnackBar.showBottom(ccAvenueModel.msg.toString());
          }
        }
        else if(paymentMethod == AppConstants.payPayu){
          payuPaymentModel = PayuPaymentModel.fromJson(response.data);
          if (payuPaymentModel.status == AppConstants.success) {
            if (payuPaymentModel.paymentGatewayStatus == AppConstants.success) {
              Get.to(() => PaymentWebViewScreen(AppConstants.appName,payuPaymentModel.payuData!.paymentLink.toString(),AppConstants.serviceOrder,"Service Purchase"));
              try {
                AppEvents().sendInitCheckoutEvent(payuPaymentModel.paymentGateway!.amount.toString(), payuPaymentModel.orderId.toString(), uniId.toString(), AppConstants.serviceOrder);
              } catch (e) {
                AppLogger.d("Error Event openCheckout: $e");
              }
            }else{
              AppDialog().showPaymentSuccessDialog(AppConstants.serviceOrder);
            }
          } else {
            CustomSnackBar.showBottom(payuPaymentModel.msg.toString());
          }
        }
        else if(paymentMethod == AppConstants.payCashfree){
          cashfreeModel = CashfreeModel.fromJson(response.data);
          if (cashfreeModel.status == AppConstants.success) {
            if (cashfreeModel.paymentGatewayStatus == AppConstants.success) {
              cashfreeController.orderId.value = cashfreeModel.cashfreeData!.response!.orderId!;
              cashfreeController.sessionId.value = cashfreeModel.cashfreeData!.response!.paymentSessionId!;
              cashfreeController.webCheckout(cashfreeModel.paymentGateway!.amount!,uniId.toString(), AppConstants.serviceOrder);
            }else{
              AppDialog().showPaymentSuccessDialog(AppConstants.serviceOrder);
            }
          } else {
            CustomSnackBar.showBottom(cashfreeModel.msg.toString());
          }
        }
        // else if(paymentMethod == AppConstants.payPayPal){
        //   paypalModel = PaypalModel.fromJson(response.data);
        //   if (paypalModel.status == AppConstants.success) {
        //     if (paypalModel.paymentGatewayStatus == AppConstants.success) {
        //       Get.to(() => PaymentWebViewScreen(AppConstants.appName, paypalModel.paypalData!.url.toString(),AppConstants.serviceOrder,"Service Purchase"));
        //       try {
        //         AppEvents().sendInitCheckoutEvent(paypalModel.data!.amount.toString(), paypalModel.paypalData!.orderId.toString(), uniId.toString(), AppConstants.serviceOrder);
        //       } catch (e) {
        //         debugPrint("Error Event openCheckout: $e");
        //       }
        //     }else{
        //       AppDialog().showPaymentSuccessDialog(AppConstants.serviceOrder);
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
              phonePeController.startTransaction(phonePeModel.phonepeData!.encode.toString(),phonePeModel.phonepeData!.data!.callbackUrl.toString(),phonePeModel.phonepeData!.finalXHeader.toString(), AppConstants.serviceOrder,phonePeModel.phonepeData!.orderId.toString(),phonePeModel.phonepeData!.orderId.toString(),
                  num.parse(phonePeModel.paymentGatewayData!.amount.toString()),
                  phonePeModel.phonepeData!.data!.mobileNumber.toString(),
                  uniId.toString()
              );
            }
            else{
              AppDialog().showPaymentSuccessDialog(AppConstants.serviceOrder);
            }
          } else {
            CustomSnackBar.showBottom(phonePeModel.msg.toString());
          }
        }
        else {
          CustomSnackBar.showBottom(AppStrings.noPaymentGatewayFound.tr);
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
