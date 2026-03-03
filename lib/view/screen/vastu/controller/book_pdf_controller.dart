import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/controller/razorpay_controller.dart';
import 'package:astro_brahmand/model/razorpay_model.dart';
import 'package:astro_brahmand/view/screen/vastu/model/book_pdf_calculation_model.dart';
import 'package:astro_brahmand/view/screen/vastu/model/book_pdf_catgeory_model.dart';
import 'package:astro_brahmand/view/screen/vastu/model/book_pdf_list_model.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';

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
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../splash/controller/config_controller.dart';

class BookPdfController extends GetxController {
  final Dio _dio = Dio();
  final isCategoryLoading = false.obs;
  final isCategorySuccess = false.obs;
  BookPdfCategoryModel bookPdfCategoryModel = BookPdfCategoryModel();

  final isProductsLoading = false.obs;
  final isProductsSuccess = false.obs;
  BookPdfListModel bookPdfListModel = BookPdfListModel();
  List<BookPdfData> booksList = [];
  num offsetCount = 0;
  bool isNoMoreData = false;
  ScrollController scrollController = ScrollController();

  // Search
  final searchQuery = ''.obs;
  Timer? debounce;
  String categoryId = '';

  final isCalculationLoading = false.obs;
  final isCalculationSuccess = false.obs;
  final isWalletSelected = 0.obs;
  RxString walletPayableAmount = '0'.obs;
  RxString totalPayableAmount = '0'.obs;
  RxString gstAmount = '0'.obs;
  BookPdfCalculationModel bookPdfCalculation = BookPdfCalculationModel();

  final isPurchaseLoading = false.obs;
  final isPurchaseSuccess = false.obs;
  RazorpayModel razorpayModel = RazorpayModel();

  final ConfigController configController = Get.find();


  Future<void> getBooksCategoryList() async {
    isCategoryLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getBooksCategory,
          data: {'api_key': apiKey, "user_uni_id": uniId});
      if (response.statusCode == 200) {
        bookPdfCategoryModel = BookPdfCategoryModel.fromJson(response.data);
        if (bookPdfCategoryModel.status == AppConstants.success) {
          isCategorySuccess(true);
        } else {
          isCategorySuccess(false);
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      isCategorySuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isCategoryLoading(false);
    }
  }

  Future<void> getBooksList(String categoryId, num offset, String search) async {
    if(offset == 0){
      offsetCount = 0;
      isNoMoreData = false;
      booksList.clear();
      // if (search != searchQuery.value) {
      //   booksList.clear();
      // }
    }

    isProductsLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getBooksList, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "pdf_book_category_id": categoryId,
        "offset" : offset,
        "search" : search
      });
      if (response.statusCode == 200) {
        bookPdfListModel = BookPdfListModel.fromJson(response.data);
        if (bookPdfListModel.status == AppConstants.success) {
          offsetCount = bookPdfListModel.offset!;
          isProductsSuccess(true);

          for (var element in (bookPdfListModel.data ?? [])) {
            booksList.add(element);
          }
        } else {
          if (offset == 0 && search.isEmpty) {
            isProductsSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }

    } catch (e) {
      isProductsSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isProductsLoading(false);
    }
  }

  Future<void> getBookCalculation(String bookId, int walletCheck,
      BookPdfData bookPdfData, String action) async {
    CustomProgressDialog.showDialog();
    isCalculationLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? payMethod = await SharedPreferencesHelper.getData(AppConstants.paymentGateway);

      final response = await _dio.post(AppConstants.booksCalculation, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "pdf_book_id": bookId,
        "wallet_check": walletCheck,
        "payment_method": payMethod
      });

      print('AS1 $payMethod  $walletCheck ');

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        bookPdfCalculation = BookPdfCalculationModel.fromJson(response.data);
        print('AS1 -> Data ${bookPdfCalculation.data}');
        if (bookPdfCalculation.status == AppConstants.success) {
          isCalculationSuccess(true);

          isWalletSelected.value = walletCheck;

          walletPayableAmount.value = bookPdfCalculation.data!.walletAmount.toString();

          gstAmount.value = bookPdfCalculation.data!.rechargeGstValue.toString();

          totalPayableAmount.value = bookPdfCalculation.data!.payableAmount.toString();

          if (action == "Open") {
            _showCalculationBottomSheet(
                bookId, bookPdfCalculation.data, bookPdfData);
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

  Future<void> bookPdfPurchase(
      String bookId, int walletCheck, String paymentMethod) async {
    isPurchaseLoading(true);
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.bookPurchase, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "pdf_book_id": bookId,
        "wallet_check": walletCheck,
        "payment_method": paymentMethod
      });
      if (response.statusCode == 200) {
        if(paymentMethod == AppConstants.payRazorpay) {
        razorpayModel = RazorpayModel.fromJson(response.data);
          if (razorpayModel.status == AppConstants.success) {
            isPurchaseSuccess(true);
            Get.back(); //Hide payment info bottom sheet
            final RazorpayController razorpayController = Get.put(RazorpayController());
            if (razorpayModel.paymentGatewayStatus == AppConstants.success) {
              razorpayController.openCheckout(razorpayModel.paymentGateway!, "PDF BOOK Purchase",uniId, AppConstants.pdfBook);
            } else {
              AppDialog().showPaymentSuccessDialog(AppConstants.pdfBook);
            }
          } else {
            isPurchaseSuccess(false);
            CustomSnackBar.showBottom(razorpayModel.msg.toString());
          }
        }else {
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

  void _showCalculationBottomSheet(String bookId,
      BookPdfCalculationData? calculationData, BookPdfData bookPdfData) {
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
                              "${AppStrings.ebook} Detail",
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
                                    bookPdfData.title.toString(),
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
                                  "${configController.currencySymbol} ${calculationData?.pdfBookAmount}",
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
                              getBookCalculation(
                                  bookPdfData.id.toString(),
                                  1,
                                  bookPdfData,
                                  "Wallet");
                            } else {
                              getBookCalculation(
                                  bookPdfData.id.toString(),
                                  0,
                                  bookPdfData,
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
                  //             await SharedPreferencesHelper.getData(
                  //                 AppConstants.paymentGateway);
                  //         if (payMethod == AppConstants.payRazorpay ||
                  //             payMethod == AppConstants.payCCAvenue) {
                  //           bookPdfPurchase(bookId, isWalletSelected.value, payMethod!);
                  //         } else {
                  //           CustomSnackBar.showBottom('No Payment Gateway Found');
                  //         }
                  //         // final RazorpayController razorpayController =
                  //         //     Get.put(RazorpayController());
                  //         // razorpayController.openCheckout(0,'');
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
                                    bookPdfPurchase(bookId, isWalletSelected.value, configController.paymentGatewayList[index].payMethod.toString());
                                  }else{
                                    bookPdfPurchase(bookId, isWalletSelected.value, configController.internationalPaymentGatewayList[index].payMethod.toString());
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
                                bookPdfPurchase(
                                    bookId,
                                    isWalletSelected.value,
                                    defaultPayMethod.toString()
                                );
                              }else {
                                bookPdfPurchase(
                                    bookId,
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
