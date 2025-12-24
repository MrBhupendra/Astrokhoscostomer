import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_checkbox.dart';
import '../../widget/custom_elevated_button.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../splash/controller/config_controller.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    return  SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: "Payment Information"),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraSmall,
                      vertical: Dimensions.paddingSizeExtraOverSmall),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal:10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: CustomTextMedium(
                                            "Product Detail",
                                            color: ColorResources.colorPrimary,
                                            fontSize: Dimensions.fontSizeLarge,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomTextRegular(
                                                "Product Name",
                                                color: ColorResources.black1,
                                              ),
                                              CustomTextRegular(
                                                "moti mala",
                                                color: ColorResources.black1,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomTextRegular(
                                                "Price",
                                                color: ColorResources.black1,
                                              ),
                                              CustomTextRegular(
                                                "${configController.currencySymbol} 400",
                                                color: ColorResources.black1,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomTextRegular(
                                                "Quantity",
                                                color: ColorResources.black1,
                                              ),
                                              CustomTextRegular(
                                                "${AppStrings.crossSign} 1",
                                                color: ColorResources.black1,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomTextRegular(
                                                "GST 18%",
                                                color: ColorResources.black1,
                                              ),
                                              CustomTextRegular(
                                                "${configController.currencySymbol} 72.0",
                                                color: ColorResources.black1,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomTextRegular(
                                                "Reference Discount",
                                                color: ColorResources.colorPrimary,
                                              ),
                                              CustomTextRegular(
                                                "-${configController.currencySymbol}0.0",
                                                color: ColorResources.colorPrimary,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomTextMedium("Total Payable",
                                                  color: ColorResources.black),
                                              CustomTextMedium("${configController.currencySymbol} 472.0",
                                                  color: ColorResources.colorPrimary),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
                                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4),
                                          child: CustomTextMedium(
                                            "Payment Method",
                                            color: ColorResources.colorPrimary,
                                            fontSize: Dimensions.fontSizeLarge,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2,bottom: 2,left: 12),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                Images.walletBalance,
                                                height: 30,
                                                color: ColorResources.colorPrimary,
                                              ),
                                              const Gap(15),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    CustomTextMedium("Wallet"),
                                                    CustomTextRegular(
                                                      "Available for payment ${configController.currencySymbol}566.0",
                                                      color: ColorResources.black1,
                                                      fontSize: Dimensions.fontSizeSmall,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              CustomCheckbox(
                                                onChanged: (isChecked) {
                                                  print('Checkbox is checked: $isChecked');
                                                  // Add your registration logic here
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // const Gap(10),

                              ],
                            ),
                          ),
                        ),
                      ),
                      const Gap(70),
                    ],
                  )
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: ColorResources.white,
                child: Padding(
                  padding:
                  const EdgeInsets.all(Dimensions.paddingSizeMediumSmall),
                  child: CustomElevatedButton(
                    onPressed: (){},
                    text: "PROCEED TO PAY",
                    backgroundColor: ColorResources.colorPrimary,
                    textColor: ColorResources.toolbarText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
