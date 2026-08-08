import 'dart:async';

import 'package:astro_brahmand/model/payu_payment_model.dart';
import 'package:astro_brahmand/model/success_model.dart';
import 'package:astro_brahmand/model/user_address_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/model/product_category_model.dart';
import 'package:astro_brahmand/model/products_model.dart';

import '../../../../controller/cash_free_controller.dart';
import '../../../../controller/phonepe_controller.dart';
import '../../../../controller/razorpay_controller.dart';
import '../../../../model/cashfree_model.dart';
import '../../../../model/ccavenue_wallet_recharge_model.dart';
import '../../../../model/offer_code_model.dart';
import '../../../../model/paypal_model.dart';
import '../../../../model/phonepe_model.dart';
import '../../../../model/razorpay_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_dialogs.dart';
import '../../../../utill/app_events.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../splash/controller/config_controller.dart';
import '../../webview/payment_webview_screen.dart';
import '../model/product_calculation_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class ProductsController extends GetxController {
  final Dio _dio = Dio();
  final isLoading = false.obs;
  final isSuccess = false.obs;

  // Product category
  final isProductCategoryLoading = false.obs;
  final isProductCategorySuccess = false.obs;
  ProductCategoryModel productCategoryModel = ProductCategoryModel();

  // Products
  final isProductsLoading = false.obs;
  final isProductsSuccess = false.obs;
  ProductsModel productsModel = ProductsModel();
  ProductsData productData = ProductsData();

  // Product Detail
  final isProductDetailLoading = false.obs;
  final isProductDetailSuccess = false.obs;

  List<ProductsData> productListData = [];
  num offsetCount = 0;
  bool isNoMoreData = false;
  ScrollController scrollController = ScrollController();

  // Search
  final searchQuery = ''.obs;
  Timer? debounce;
  String categoryId = '';

  // Address list
  final isAddressLoading = false.obs;
  final isAddressSuccess = false.obs;
  UserAddressModel userAddressModel = UserAddressModel();

  // Offer Code
  RxString offerStatus = ''.obs;
  // Update offerStatus dynamically
  void updateOfferStatus(String status) {
    offerStatus.value = status;
  }
  // final isOfferCodeLoading = false.obs;
  // final isOfferCodeSuccess = false.obs;
  // OfferCodeModel offerCodeModel = OfferCodeModel();

  // Save address
  SuccessModel saveAddressModel = SuccessModel();

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
  final isOutOfStock = false.obs;
  RxString subscriptionDiscountPercent = '0'.obs;
  RxInt isSubscription = 0.obs;
  ProductCalculationModel productCalculationModel = ProductCalculationModel();

  //Multiple PG
  final ConfigController configController = Get.find();

  //Purchase
  RazorpayModel razorpayModel = RazorpayModel();
  PaypalModel paypalModel = PaypalModel();
  PhonepeModel phonePeModel = PhonepeModel();
  CcAvenueWalletRechargeModel ccAvenueModel = CcAvenueWalletRechargeModel();
  PayuPaymentModel payuPaymentModel = PayuPaymentModel();

  final CashFreeController cashfreeController = Get.put(CashFreeController());
  CashfreeModel cashfreeModel = CashfreeModel();

  RxInt qtyCounter = 1.obs;
  RxInt productQty = 1.obs;

  @override
  void onInit() {
    super.onInit();
    CFPaymentGatewayService().setCallback(cashfreeController.onVerify, cashfreeController.onError);
  }

  void resetControllerValue(String productId, String vendorUniId,{bool isApi = true}) {
    qtyCounter.value = 1;
    productQty.value = 1;

    myWalletAmount.value = '0';
    walletPayableAmount.value = '0';
    totalPayableAmount.value = '0';
    subTotalAmount.value = '0';
    gstPercent.value = '0';
    gstAmount.value = '0';
    refDiscount.value = '0';
    offerDiscount.value = '0';
    refId.value = '0';

    if(isApi){
      getProductCalculation(productId, 0, qtyCounter.value, "", vendorUniId,"");
    }
  }


  void increment(String productId, String vendorUniId) {
    // Check if product is in stock and quantity is available
    if (productData.quantity != null && productQty.value < productData.quantity!.toInt()) {
      productQty.value = productQty.value + 1;
      qtyCounter.value = productQty.value;
    } else if (productData.quantity == null || productData.quantity!.toInt() == 0) {
      // Product is out of stock
      CustomSnackBar.showBottom("Product is out of stock");
    } else {
      // Maximum quantity reached
      CustomSnackBar.showBottom("Maximum quantity available: ${productData.quantity}");
    }
  }

  void decrement(String productId, String vendorUniId) {
    if (productQty.value > 1) {
      productQty.value = productQty.value - 1;
      qtyCounter.value = productQty.value;
    }
  }

  @override
  void onReady() {
    super.onReady();
    ever(isAddressSuccess, (callback) {
      if (callback == true) {
        getUserAddress();
      }
    });
  }

  void searchProductCategory(String query) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(seconds: 1), () {
      searchQuery.value = query;
      offsetCount = 0;
      getProductCategory("", query);
    });
  }

  Future<void> getProductCategory(String offset, String search) async {
    isProductCategoryLoading(true);
    try {
      final response = await _dio.post(AppConstants.getProductCategory,
          data: {'offset': offset, "search": search});
      if (response.statusCode == 200) {
        productCategoryModel = ProductCategoryModel.fromJson(response.data);
        if (productCategoryModel.status == AppConstants.success) {
          isProductCategorySuccess(true);
        } else {
          isProductCategorySuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isProductCategorySuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isProductCategoryLoading(false);
    }
  }

  Future<void> getProducts(num offset, String categoryId, String search) async {

    isProductsSuccess(false);
    isProductsLoading(true);
    try {
      final response = await _dio.post(AppConstants.getProducts, data: {
        'offset': offset,
        'category_id': categoryId,
        "search": search
      });
      if (response.statusCode == 200) {
        productsModel = ProductsModel.fromJson(response.data);
        if (productsModel.status == AppConstants.success) {
          if (productsModel.data!.isNotEmpty) {
            isProductsSuccess(true);
          } else {
            isProductsSuccess(false);
          }
        } else {
          isProductsSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isProductsSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isProductsLoading(false);
    }
  }

  Future<void> getProductDetail(String slug, String productId) async {
    isProductDetailLoading(true);
    try {
      final response = await _dio.post(AppConstants.getProductDetail,
          data: {'slug': slug, 'product_id': productId});

      if (response.statusCode == 200) {
        int status = response.data['status'];
        if (status == AppConstants.success) {
          productData = ProductsData.fromJson(response.data['data']);
          isProductDetailSuccess(true);
        } else {
          isProductDetailSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isProductDetailSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isProductDetailLoading(false);
    }
  }

  Future<void> getUserAddress() async {
    isAddressLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.userAddressList, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
      });
      if (response.statusCode == 200) {
        // print('API Response: ${response.data}');

        userAddressModel = UserAddressModel.fromJson(response.data);
        if (userAddressModel.status == AppConstants.success) {
          isAddressSuccess(true);
        } else {
          isAddressSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isAddressLoading(false);
    }
  }

  Future<void> saveUserAddress(
    String name,
    String email,
    String phone,
    String houseNo,
    String streetArea,
    String landmark,
    String city,
    String latitude,
    String longitude,
    String pinCode,
    String address,
    String country,
    String state,
  ) async {
    CustomProgressDialog.showDialog();
    isLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.addAddress, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'name': name,
        'email': email,
        'phone': phone,
        'house_no': houseNo,
        'street_area': streetArea,
        'landmark': landmark,
        'city': city,
        'latitude': latitude,
        'longitude': longitude,
        'pincode': pinCode,
        'address': address,
        'country': country,
        'state': state,
      });
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        saveAddressModel = SuccessModel.fromJson(response.data);
        if (saveAddressModel.status == AppConstants.success) {
          isSuccess(true);
          Get.back();
          getUserAddress();
        } else {
          isSuccess(false);
          CustomSnackBar.showBottom(saveAddressModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getProductCalculation(String productId, int walletCheck, int qty, String astroRefID, String vendorUniId,String offerCode) async {
    isCalculationLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? payMethod = configController.config.data?.payment?.defaultPaymentGateway.toString();

      final response = await _dio.post(AppConstants.manageProduct, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "product_id": productId,
        "item": qty,
        "vendor_uni_id": vendorUniId,
        "reference_id": astroRefID,
        "wallet_check": walletCheck,
        "payment_method": payMethod,
        "offer_code": offerCode
      });

      AppLogger.d("apiKey => $apiKey");
      AppLogger.d("uniId => $uniId");
      AppLogger.d("productId => $productId");
      AppLogger.d("qty => $qty");
      AppLogger.d("vendorUniId => $vendorUniId");
      AppLogger.d("astroRefID => $astroRefID");
      AppLogger.d("walletCheck => $walletCheck");
      AppLogger.d("payMethod => $payMethod");
      AppLogger.d("offerCode => $offerCode");
      AppLogger.d("response2 => $response");

      if (response.statusCode == 200) {
        productCalculationModel = ProductCalculationModel.fromJson(response.data);
        if (productCalculationModel.status == AppConstants.success) {
          AppLogger.d("getProductCalculation-> hit api 200");
          isCalculationSuccess(true);

          isWalletSelected.value = walletCheck;

          myWalletAmount.value = productCalculationModel.data!.myWalletAmount.toString();

          walletPayableAmount.value = productCalculationModel.data!.walletAmount.toString();

          refDiscount.value = productCalculationModel.data!.referenceAmount.toString();

          offerDiscount.value = productCalculationModel.data!.offerAmmount.toString();

          gstPercent.value = productCalculationModel.data!.rechargeGstPercent.toString();

          gstAmount.value = productCalculationModel.data!.rechargeGstValue.toString();

          subscriptionDiscountPercent.value = productCalculationModel.data!.subscriptionDiscountPercent.toString();

          // isSubscription.value = productCalculationModel.data!.isSubscription!.toInt();
          if (productCalculationModel.data != null &&
              productCalculationModel.data!.isSubscription != null) {
            isSubscription.value =
                productCalculationModel.data!.isSubscription!.toInt();
          } else {
            isSubscription.value = 0;
          }

          subTotalAmount.value = productCalculationModel.data!.subtotal.toString();

          totalPayableAmount.value = productCalculationModel.data!.payableAmount.toString();

          productQty.value = int.parse(productCalculationModel.data!.item.toString());

          offerMsg.value = productCalculationModel.msg.toString();

          updateOfferStatus(productCalculationModel.data!.couponStatus.toString());

        } else {
          AppLogger.d("getProductCalculation-> hit api else");
          isCalculationSuccess(false);
          CustomSnackBar.showBottom(productCalculationModel.msg.toString());
          updateOfferStatus(productCalculationModel.data!.couponStatus.toString());
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e, stackTrace) {
      isCalculationSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
        AppLogger.d('OnException==> ${stackTrace.toString()}');
    } finally {
      isCalculationLoading(false);
    }
  }

  Future<void> productPurchase(
      String qty,
      int walletCheck,
      String paymentMethod,
      String refId,
      String addressId,
      ProductsData productsData,
      String offerCode) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.purchaseProduct, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "product_id": productData.id.toString(),
        "item": qty,
        "vendor_uni_id": productData.vendorUniId.toString(),
        "reference_id": refId,
        "address_id": addressId,
        "wallet_check": walletCheck,
        "payment_method": paymentMethod,
        "offer_code": offerCode
      });

      AppLogger.d("Purchase Request $apiKey, $uniId, productId ${productData.id.toString()}, qty $qty, ${productData.vendorUniId.toString()}, referenceId $refId, addressId $addressId, $walletCheck,$paymentMethod");

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        if(paymentMethod == AppConstants.payRazorpay){
          razorpayModel = RazorpayModel.fromJson(response.data);
          if (razorpayModel.status == AppConstants.success) {
            final RazorpayController razorpayController = Get.put(RazorpayController());
            if (razorpayModel.paymentGatewayStatus == AppConstants.success) {
              razorpayController.openCheckout(razorpayModel.paymentGateway!, "Product Purchase", uniId, AppConstants.shop);
            } else {
              AppDialog().showPaymentSuccessDialog(AppConstants.shop);
            }
          }else{
            CustomSnackBar.showBottom(razorpayModel.msg.toString());
          }
        }
        else if(paymentMethod == AppConstants.payCCAvenue){
          ccAvenueModel = CcAvenueWalletRechargeModel.fromJson(response.data);
          if (ccAvenueModel.status == AppConstants.success) {
            if (ccAvenueModel.paymentGatewayStatus == AppConstants.success) {
              String url = "${AppConstants.ccAvenueUrl}&encRequest=${ccAvenueModel.ccavenueData!.encVal.toString()}&access_code=${ccAvenueModel.ccavenueData!.accessCode.toString()}";
              Get.to(() => PaymentWebViewScreen(AppConstants.appName,url,AppConstants.shop,"Product Purchase"));
              try {
                AppEvents().sendInitCheckoutEvent(ccAvenueModel.data!.amount.toString(), ccAvenueModel.ccavenueData!.orderId.toString(), uniId.toString(), AppConstants.shop);
              } catch (e) {
                AppLogger.d("Error Event openCheckout: $e");
              }
            }else{
              AppDialog().showPaymentSuccessDialog(AppConstants.shop);
            }
          } else {
            CustomSnackBar.showBottom(ccAvenueModel.msg.toString());
          }
        }
        else if(paymentMethod == AppConstants.payPayu){
          payuPaymentModel = PayuPaymentModel.fromJson(response.data);
          if (payuPaymentModel.status == AppConstants.success) {
            if (payuPaymentModel.paymentGatewayStatus == AppConstants.success) {
              Get.to(() => PaymentWebViewScreen(AppConstants.appName,payuPaymentModel.payuData!.paymentLink.toString(),AppConstants.shop,"Product Purchase"));
              try {
                AppEvents().sendInitCheckoutEvent(payuPaymentModel.paymentGateway!.amount.toString(), payuPaymentModel.orderId.toString(), uniId.toString(), AppConstants.shop);
              } catch (e) {
                AppLogger.d("Error Event openCheckout: $e");
              }
            }else{
              AppDialog().showPaymentSuccessDialog(AppConstants.shop);
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
              cashfreeController.webCheckout(cashfreeModel.paymentGateway!.amount!,uniId.toString(), AppConstants.shop);
            } else{
              AppDialog().showPaymentSuccessDialog(AppConstants.shop);
            }
          } else {
            CustomSnackBar.showBottom(cashfreeModel.msg.toString());
          }
        }
        // else if(paymentMethod == AppConstants.payPayPal){
        //   paypalModel = PaypalModel.fromJson(response.data);
        //   if (paypalModel.status == AppConstants.success) {
        //     if (paypalModel.paymentGatewayStatus == AppConstants.success) {
        //       Get.to(() => PaymentWebViewScreen(AppConstants.appName, paypalModel.paypalData!.url.toString(),AppConstants.shop,"Product Purchase"));
        //       try {
        //         AppEvents().sendInitCheckoutEvent(paypalModel.data!.amount.toString(), paypalModel.paypalData!.orderId.toString(), uniId.toString(), AppConstants.shop);
        //       } catch (e) {
        //         debugPrint("Error Event openCheckout: $e");
        //       }
        //     }else{
        //       AppDialog().showPaymentSuccessDialog(AppConstants.shop);
        //     }
        //   } else {
        //     CustomSnackBar.showBottom(paypalModel.msg.toString());
        //   }
        // }
        else if(paymentMethod == AppConstants.payPhonePe){
          String? phonePeId = configController.config.data?.phonepeMerchantId.toString();
          phonePeModel = PhonepeModel.fromJson(response.data);
          if (phonePeModel.status == AppConstants.success) {
            final PhonePeController phonePeController = Get.put(PhonePeController(phonePeId.toString()));
            if (phonePeModel.paymentGatewayStatus == AppConstants.success) {
              // Get.to(() => PaymentWebViewScreen(AppConstants.appName, phonePeModel.phonepeData!.url.toString(),AppConstants.shop,"Product Purchase"));
              // try {
              //   AppEvents().sendInitCheckoutEvent(phonePeModel.data!.amount.toString(), phonePeModel.phonepeData!.orderId.toString(), uniId.toString(), AppConstants.shop);
              // } catch (e) {
              //   debugPrint("Error Event openCheckout: $e");
              // }
              phonePeController.startTransaction(phonePeModel.phonepeData!.encode.toString(),phonePeModel.phonepeData!.data!.callbackUrl.toString(),phonePeModel.phonepeData!.finalXHeader.toString(), AppConstants.shop,phonePeModel.phonepeData!.orderId.toString(),phonePeModel.phonepeData!.orderId.toString(),
                  num.parse(phonePeModel.data!.payableAmount.toString()),
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
        else {
          CustomSnackBar.showBottom(AppStrings.noPaymentGatewayFound.tr);
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    }
  }

  // // Offer Code
  // Future<void> getOfferCode(String offerType) async {
  //   isOfferCodeLoading(true);
  //   try {
  //     String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
  //     String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
  //     final response = await _dio.post(AppConstants.getOfferCode, data: {
  //       "api_key": apiKey,
  //       "user_uni_id": uniId,
  //       "offer_type": offerType
  //     });
  //     if (response.statusCode == 200) {
  //       offerCodeModel = OfferCodeModel.fromJson(response.data);
  //       if (offerCodeModel.status == AppConstants.success) {
  //         isOfferCodeSuccess(true);
  //       } else {
  //         isOfferCodeSuccess(false);
  //       }
  //     } else {
  //       if (kDebugMode) {
  //         print('OnApiError');
  //       }
  //     }
  //   } catch (e) {
  //     isOfferCodeSuccess(false);
  //     if (kDebugMode) {
  //       print('OnException==> ${e.toString()}');
  //     }
  //   } finally {
  //     isOfferCodeLoading(false);
  //   }
  // }

}
