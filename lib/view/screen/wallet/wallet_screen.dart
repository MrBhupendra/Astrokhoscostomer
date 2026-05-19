import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:astro_brahmand/view/widget/simmer_widget/simmer_wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/wallet/controller/wallet_controller.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../splash/controller/config_controller.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    final WalletController walletController = Get.find<WalletController>();

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.myWallet.tr),
        body: Obx(
          () {
            if (walletController.isVoucherSuccess.isTrue) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeExtraSmall,
                        vertical: Dimensions.paddingSizeOverSmall,
                      ),
                      child: Container(
                        color: ColorResources.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: ColorResources.colorPrimary,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.borderRadiusDefault,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: Dimensions.sizedBoxExtraOverLarge,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeExtraLarge,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            AppConstants.appName.tr,
                                            style: const TextStyle(
                                              color: ColorResources.toolbarText,
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                              letterSpacing: 0.8,
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          Images.more,
                                          width: 24,
                                          height: 24,
                                          color: ColorResources.toolbarText,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                      height:
                                          Dimensions.sizedBoxExtraOverLarge),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "${configController.currencySymbol} ${walletController.walletModel.wallet.toString()}",
                                              style: const TextStyle(
                                                color:
                                                    ColorResources.toolbarText,
                                                fontWeight: FontWeight.w500,
                                                fontSize: Dimensions
                                                    .fontSizeOverLarge,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            CustomTextMedium(
                                              AppStrings.availableBalance.tr,
                                              color: ColorResources.toolbarText,
                                              fontSize:
                                                  Dimensions.fontSizeSmall,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                      height:
                                          Dimensions.sizedBoxExtraOverLarge),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeExtraLarge,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CustomTextMedium(
                                            "XXXX-XXXX-XXXX",
                                            color: ColorResources.toolbarText,
                                          ),
                                        ),
                                        Expanded(
                                          child: Image.asset(
                                            'assets/images/chip.png',
                                            width: 30,
                                            height: 30,
                                            alignment: Alignment.bottomRight,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                      height:
                                          Dimensions.sizedBoxExtraOverLarge),
                                ],
                              ),
                            ),
                            const Gap(10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4),
                              child: CustomTextMedium(
                                AppStrings.walletRecharge.tr,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, bottom: 10),
                              child: CustomTextRegular(
                                AppStrings.choosefromAvailableRechargePacks.tr,
                                fontSize: Dimensions.fontSizeSmall,
                                color: ColorResources.black2,
                              ),
                            ),

                            // voucher gridview
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 6),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  // crossAxisSpacing: 4,
                                  // childAspectRatio: 0.85
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                ),
                                // scrollDirection: Axis.horizontal,
                                itemCount:
                                    walletController.walletModel.data?.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      walletController.selectVoucher(index);
                                    },
                                    child: Obx(() => Stack(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: walletController
                                                            .selectedVoucherIndex
                                                            .value ==
                                                        index
                                                    ? ColorResources
                                                        .colorPrimary
                                                        .withOpacity(0.5)
                                                    : ColorResources
                                                        .walletVoucher,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    spreadRadius: 0,
                                                    blurRadius: 1,
                                                    offset: const Offset(0, 1),
                                                  )
                                                ],
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Gap(5),
                                                  CustomTextMedium(
                                                    "${configController.currencySymbol}${walletController.walletModel.data?[index].walletAmount}",
                                                    fontSize: Dimensions
                                                        .fontSizeLarge,
                                                    // color: ColorResources.black,
                                                    color: walletController
                                                                .selectedVoucherIndex
                                                                .value ==
                                                            index
                                                        ? ColorResources
                                                            .toolbarText
                                                        : ColorResources
                                                            .walletAmountUnselected,
                                                  ),
                                                  CustomTextRegular(
                                                    // "${AppStrings.get.tr} ${configController.currencySymbol}${walletController.walletModel.data?[index].mainAmount}",
                                                    "${AppStrings.extra.tr} ${configController.currencySymbol}${walletController.walletModel.data?[index].giftAmount}",
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                    // color: ColorResources.black1,
                                                    color: walletController
                                                                .selectedVoucherIndex
                                                                .value ==
                                                            index
                                                        ? ColorResources
                                                            .toolbarText
                                                        : ColorResources
                                                            .walletAmountUnselected,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (walletController
                                                    .walletModel
                                                    .data?[index]
                                                    .tag
                                                    ?.isNotEmpty ??
                                                false)
                                              Positioned(
                                                top: 0,
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  decoration: BoxDecoration(
                                                    color: walletController
                                                                .walletModel
                                                                .data?[index]
                                                                .tag ==
                                                            "new"
                                                        ? Colors.orange
                                                        : ColorResources.orange
                                                            .withOpacity(0.8),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(5.0),
                                                      topRight:
                                                          Radius.circular(5.0),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      // const Icon(
                                                      //     Icons
                                                      //         .star_rate_rounded,
                                                      //     size: 16,
                                                      //     color: ColorResources
                                                      //         .white),
                                                      CustomTextRegular(
                                                        "${walletController.walletModel.data?[index].tag?.toUpperCase()}",
                                                        fontSize: Dimensions
                                                            .fontSizeExtraSmall,
                                                        color: ColorResources
                                                            .white,
                                                        maxLines: 1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          ],
                                        )),
                                  );
                                },
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorResources.white,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.borderRadiusDefault),
                                  border:
                                      Border.all(color: ColorResources.black7),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 16),
                                  child: Column(
                                    children: [
                                      CustomTextMedium(
                                        AppStrings.packType.tr,
                                        fontSize: Dimensions.fontSizeLarge,
                                        color: ColorResources.black1,
                                        textAlign: TextAlign.center,
                                      ),
                                      const Divider(
                                          color: ColorResources.black7),
                                      const Gap(8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomTextRegular(
                                              AppStrings.amount.tr,
                                              color: ColorResources.black2),
                                          CustomTextRegular(
                                              "${configController.currencySymbol} ${walletController.amount}"),
                                        ],
                                      ),
                                      const Gap(8),
                                      Visibility(
                                        visible: (configController.phoneCode == AppConstants.defaultPhoneCode) ? true : false,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomTextRegular(
                                                "${AppStrings.gst.tr} @${walletController.gstPercent}%",
                                                color: ColorResources.black2),
                                            CustomTextRegular(
                                                "${configController.currencySymbol} ${walletController.gstAmount}"),
                                          ],
                                        ),
                                      ),
                                      const Gap(8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomTextRegular(
                                              AppStrings.giftPoints.tr,
                                              color: ColorResources.black2),
                                          CustomTextRegular(
                                              "${configController.currencySymbol} ${walletController.giftAmount}",
                                              color: ColorResources.orange),
                                        ],
                                      ),
                                      const Gap(8),
                                      const Divider(
                                          color: ColorResources.black7),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomTextMedium(AppStrings.pay.tr),
                                          CustomTextMedium(
                                              "${configController.currencySymbol} ${walletController.payAmount}",
                                              fontSize:
                                                  Dimensions.fontSizeDefault),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Gap(70),
                          ],
                        ),
                      ),
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
                                      walletController.proceedPaymentRequest(
                                          walletController.walletId.toString(),
                                          configController.paymentGatewayList[index].payMethod.toString());
                                    }else{
                                      walletController.proceedPaymentRequest(
                                          walletController.walletId.toString(),
                                          configController.internationalPaymentGatewayList[index].payMethod.toString());
                                    }
                              });
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
                                // Row(
                                //   children: [
                                //     CustomTextMedium(
                                //       configController.config.data!.paymentGateway.toString(),
                                //       fontSize: Dimensions.fontSizeSmall
                                //     ),
                                //     const Icon(Icons.arrow_drop_up)
                                //   ],
                                // ),
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
                                  walletController.proceedPaymentRequest(walletController.walletId.toString(),defaultPayMethod.toString());
                                }else{
                                  walletController.proceedPaymentRequest(walletController.walletId.toString(), defaultPayMethodInternational.toString());
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
                                "Pay ${configController.currencySymbol} ${walletController.payAmount}",
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
              );
            } else if (walletController.isVoucherLoading.isTrue) {
              return const SimmerWalletScreen();
            } else {
              return const EmptyScreen();
            }
          },
        ),
      ),
    );
  }

  String toCapitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
