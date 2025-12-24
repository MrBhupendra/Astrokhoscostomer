import 'dart:ui';

import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:astro_brahmand/view/screen/login/controller/login_controller.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../widget/custom_elevated_button.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';

class VerifyOtpScreen extends GetView<LoginController> {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorResources.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height * 0.37,
                color: Color(0xFF020015),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              Images.logo,
                              width: 150,
                              height: 150,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextMedium(
                            AppStrings.verifyOTP.tr,
                            fontSize: 23,
                            color: ColorResources.white,
                            textAlign: TextAlign.start,
                          ),
                          const Gap(2),
                          Text(
                            AppStrings.otpSentYourNumber.tr,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 13,
                              color: ColorResources.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          CustomTextMedium(
                            controller.mobileNumber.toString(),
                            fontSize: Dimensions.fontSizeSmall,
                            textAlign: TextAlign.start,
                            color: ColorResources.black7,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomTextMedium(
                          "Enter OTP",
                          fontSize: Dimensions.fontSizeDefault,
                          color: ColorResources.black2,
                        ),
                      ],
                    ),
                    const Gap(8),
                    PinInputTextField(
                      pinLength: 6,
                      keyboardType: TextInputType.number,
                      autoFocus: true,
                      controller: controller.otpController,
                      onChanged: (value) {
                        if (value.length == 6) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Future.microtask(() {
                            controller.otpTextEditController.stopListen();
                          });
                          controller.verifyClick(controller.mobileNumber);
                        }
                      },
                      cursor: Cursor(
                        color: ColorResources.black6,
                        width: 1.5,
                        height: 24.0,
                        radius: const Radius.circular(1),
                        enabled: true,
                      ),
                      decoration: BoxLooseDecoration(
                        strokeWidth: 1,
                        gapSpace: 5,
                        strokeColorBuilder: PinListenColorBuilder(
                          ColorResources.colorPrimary,
                          ColorResources.black6,
                        ),
                      ),
                    ),
                    const Gap(20),

                    // Verify OTP Button
                    Obx(() {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorResources.colorPrimary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          onPressed: (){
                            controller.verifyClick(controller.mobileNumber);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: controller.isVerifying.value
                              ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                              : CustomTextRegular(
                            AppStrings.verifyOTP.tr,
                            fontSize: 16,
                            color: ColorResources.toolbarText,
                          ),
                        ),
                      );
                    }),

                    const Gap(40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomTextRegular(
                        AppStrings.youReceiveAnyCode.tr,
                        color: ColorResources.black5,
                      ),
                    ),
                    const Gap(Dimensions.gapExtraSmall),
                    GestureDetector(
                      onTap: () {
                        if (controller.canResendOtp.value) {
                          controller.sendOtp(controller.countryCode.value.toString(),controller.mobileNumber.toString());
                          // controller.startTimer();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.refresh,size: 20,color: controller.canResendOtp.value
                                ? ColorResources.colorPrimary
                                : ColorResources.colorPrimary.withOpacity(0.5),),
                            Gap(5),
                            CustomTextMedium(
                              AppStrings.resendNewCode.tr,
                              color: controller.canResendOtp.value
                                  ? ColorResources.colorPrimary
                                  : ColorResources.colorPrimary.withOpacity(0.5),
                              fontSize: Dimensions.fontSizeLarge,
                              // textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                      ),
                    ),
                    Obx(() => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
                      child: CustomTextMedium(
                        "${controller.remainingTime.value} Seconds",
                        fontSize: Dimensions.fontSizeSmall,
                        color: ColorResources.black4,
                      ),
                    )),

                  ],
                ),
              )



            ],
          ),
        ),
      ),
    );
  }
}