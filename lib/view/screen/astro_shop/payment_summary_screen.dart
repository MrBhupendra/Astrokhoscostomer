import 'package:astro_brahmand/utill/app_features.dart';
import 'package:astro_brahmand/view/screen/offer_code/controller/offer_code_controller.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/common_methods.dart';
import '../../../utill/images.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_checkbox.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../splash/controller/config_controller.dart';
import 'controller/products_controller.dart';

class PaymentSummaryScreen extends GetView<ProductsController> {
  PaymentSummaryScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _offerCodeController = TextEditingController();
  final OfferCodeController offerCodeController = Get.put(OfferCodeController());

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();


    dynamic arguments = Get.arguments;
    String addressId = '';

    if (arguments is Map<String, dynamic>) {
      addressId = arguments['addressId'] ?? '';
    }

    controller.getProductCalculation(
        controller.productData.id.toString(),
        0,
        controller.productQty.toInt(),
        "",
        controller.productData.vendorUniId.toString(),
        ""
    );

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: "Payment Summary"),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraSmall,
                      vertical: Dimensions.paddingSizeExtraOverSmall),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: ColorResources.white,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.borderRadiusDefault),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(0, 1),
                                      )
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: CustomTextMedium(
                                          "Product Detail",
                                          color:
                                              ColorResources.colorPrimaryDark,
                                          fontSize: Dimensions.fontSizeLarge,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: CustomTextRegular(
                                                "Product Name",
                                                color: ColorResources.black1,
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomTextRegular(
                                                controller
                                                    .productData.productName
                                                    .toString(),
                                                color: ColorResources.black1,
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomTextRegular(
                                              "Price",
                                              color: ColorResources.black1,
                                            ),
                                            CustomTextRegular(
                                              "${configController.currencySymbol} ${controller.productData.price.toString()}",
                                              color: ColorResources.black1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomTextRegular(
                                              "Quantity",
                                              color: ColorResources.black1,
                                            ),
                                            CustomTextRegular(
                                              "${AppStrings.crossSign} ${controller.productQty.toString()}",
                                              color: ColorResources.black1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Obx(() => Visibility(
                                            visible: controller.isWalletSelected.value == 1,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 4),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomTextRegular(
                                                    "Wallet",
                                                    color:
                                                        ColorResources.black1,
                                                  ),
                                                  Obx(() => CustomTextRegular(
                                                        "${configController.currencySymbol} ${controller.walletPayableAmount.value}",
                                                        color: ColorResources
                                                            .black1,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          )),
                                      Obx(() => Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomTextRegular(
                                                  "GST ${controller.gstPercent.toString()}%",
                                                  color:
                                                      ColorResources.black1,
                                                ),
                                                CustomTextRegular(
                                                  "${configController.currencySymbol} ${controller.gstAmount.toString()}",
                                                  color:
                                                      ColorResources.black1,
                                                ),
                                              ],
                                            ),
                                          )),
                                      Obx(() => Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomTextRegular(
                                                  "Reference Discount",
                                                  color: ColorResources
                                                      .black1,
                                                ),
                                                CustomTextRegular(
                                                  "-${configController.currencySymbol} ${controller.refDiscount.toString()}",
                                                  color: ColorResources
                                                      .black1,
                                                ),
                                              ],
                                            ),
                                          )),
                                          Visibility(
                                            visible: controller.isSubscription.toInt() == 1,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 4),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  CustomTextRegular(
                                                    "Subscription Discount Percent",
                                                    color:
                                                    ColorResources.black1,
                                                  ),
                                                  Obx(() => CustomTextRegular(
                                                    "${controller.subscriptionDiscountPercent.toString()}%",
                                                    color: ColorResources
                                                        .black1,
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),

                                      Obx(() => Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            CustomTextRegular(
                                              "Offer Discount",
                                              color: ColorResources
                                                  .colorPrimaryDark,
                                            ),
                                            CustomTextRegular(
                                              "-${configController.currencySymbol} ${controller.offerDiscount.toString()}",
                                              color: ColorResources
                                                  .colorPrimaryDark,
                                            ),
                                          ],
                                        ),
                                      )),
                                      const Divider(),
                                      Obx(() => Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomTextMedium(
                                                    "Total Payable",
                                                    color:
                                                        ColorResources.black),
                                                CustomTextMedium(
                                                    "${configController.currencySymbol} ${controller.totalPayableAmount.toString()}",
                                                    color: ColorResources
                                                        .colorPrimaryDark),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: false,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              filled: true,
                                              fillColor: ColorResources
                                                  .colorPrimaryLight,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0),
                                                borderSide: BorderSide.none,
                                              ),
                                              hintText: 'Astro Reference ID',
                                              hintStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      ColorResources.black4)),
                                        ),
                                      ),
                                      const Gap(10),
                                      CustomButton(
                                        "APPLY",
                                        color: ColorResources.toolbarText,
                                        onPressed: () {},
                                        minimumSize: const Size(45, 35),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(10),
                              // Wallet
                              Visibility(
                                visible: AppFeatures.shopWallet,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: ColorResources.white,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.borderRadiusDefault),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(0, 1),
                                        )
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: CustomTextMedium(
                                            "Payment Method",
                                            color: ColorResources
                                                .colorPrimaryDark,
                                            fontSize:
                                                Dimensions.fontSizeLarge,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 8),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                Images.walletBalance,
                                                height: 26,
                                                color: ColorResources
                                                    .colorPrimaryDark,
                                              ),
                                              const Gap(15),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    CustomTextRegular(
                                                        "Wallet"),
                                                    CustomTextRegular(
                                                      "Available for payment ${configController.currencySymbol} ${controller.myWalletAmount.toString()}",
                                                      color: ColorResources
                                                          .black1,
                                                      fontSize: Dimensions
                                                          .fontSizeSmall,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              CustomCheckbox(
                                                onChanged: (isChecked) {
                                                  if (isChecked) {
                                                    controller
                                                        .getProductCalculation(
                                                            controller
                                                                .productData
                                                                .id
                                                                .toString(),
                                                            1,
                                                            controller
                                                                .productQty
                                                                .toInt(),
                                                            "",
                                                            controller
                                                                .productData
                                                                .vendorUniId
                                                                .toString(),
                                                    _offerCodeController.text.toString()
                                                    );
                                                  } else {
                                                    controller
                                                        .getProductCalculation(
                                                            controller
                                                                .productData
                                                                .id
                                                                .toString(),
                                                            0,
                                                            controller
                                                                .productQty
                                                                .toInt(),
                                                            "",
                                                            controller
                                                                .productData
                                                                .vendorUniId
                                                                .toString(),
                                                        _offerCodeController.text.toString());
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(8),

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
                                              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
                                            controller.getProductCalculation(
                                                controller.productData.id.toString(),
                                                controller.isWalletSelected.value,
                                                controller.productQty.toInt(),
                                                "",
                                                controller.productData.vendorUniId.toString(),
                                                _offerCodeController.text.toString()
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
                              // if(controller.offerDiscount.value == "0")
                              Obx((){
                                if(controller.offerStatus.value == "1"){
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
                                }else if(controller.offerStatus.value == "0"){
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 4.0,top: 0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.error_outline,color: Colors.red,size: 16),
                                        const Gap(6),
                                        CustomTextMedium(
                                          // AppStrings.invalidCode.tr,
                                          controller.offerMsg.toString(),
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
                                            offerCodeController.offerCodeBottomSheet(
                                                context,
                                                _offerCodeController,
                                                applyOffer:(){
                                                  controller.getProductCalculation(
                                                    controller.productData.id.toString(),
                                                    0,
                                                    controller.productQty.toInt(),
                                                    "",
                                                    controller.productData.vendorUniId.toString(),
                                                    _offerCodeController.text.toString()
                                                );});
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: ColorResources.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeMediumSmall,
                    vertical: Dimensions.paddingSizeExtraSmall
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        CommonMethods().showPaymentMethodBottomSheet(configController.phoneCode == AppConstants.defaultPhoneCode ? false : true,
                            onItemSelected: (int index){
                              if(configController.phoneCode == AppConstants.defaultPhoneCode){
                                controller.productPurchase(
                                    controller.productQty.toString(),
                                    controller.isWalletSelected.value,
                                    configController.paymentGatewayList[index].payMethod.toString(),
                                    controller.refId.toString(),
                                    addressId.toString(),
                                    controller.productData,
                                    _offerCodeController.text.toString()
                                );
                              }else{
                                controller.productPurchase(
                                    controller.productQty.toString(),
                                    controller.isWalletSelected.value,
                                    configController.internationalPaymentGatewayList[index].payMethod.toString(),
                                    controller.refId.toString(),
                                    addressId.toString(),
                                    controller.productData,
                                    _offerCodeController.text.toString()
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
                          String? defaultPayMethod = configController.config.data?.payment?.defaultPaymentGateway.toString();
                          String? defaultPayMethodInternational = configController.config.data?.paymentForOtherCountry?.defaultPaymentGateway.toString();
                          if(configController.phoneCode == AppConstants.defaultPhoneCode){
                            controller.productPurchase(
                                controller.productQty.toString(),
                                controller.isWalletSelected.value,
                                defaultPayMethod.toString(),
                                controller.refId.toString(),
                                addressId,
                                controller.productData,
                                _offerCodeController.text.toString()
                            );
                          }else{
                            controller.productPurchase(
                                controller.productQty.toString(),
                                controller.isWalletSelected.value,
                                defaultPayMethodInternational.toString(),
                                controller.refId.toString(),
                                addressId,
                                controller.productData,
                                _offerCodeController.text.toString()
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
            ),
          ],
        ),
      ),
    );
  }
}
