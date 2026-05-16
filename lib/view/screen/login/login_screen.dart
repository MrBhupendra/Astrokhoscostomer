import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/login/controller/login_controller.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';

import '../../../controller/app_update_controller.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../widget/custom_elevated_button.dart';
import '../splash/controller/config_controller.dart';
import '../webview/webview_screen.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

  final AppUpdateController appUpdateController =
      Get.put(AppUpdateController());
  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    // return SafeArea(
    //   child: Scaffold(
    //     backgroundColor: ColorResources.white,
    //     resizeToAvoidBottomInset: true,
    //     // Allow resizing when the keyboard opens
    //     body: LayoutBuilder(
    //       builder: (context, constraints) {
    //         double screenHeight = constraints.maxHeight;
    //         double screenWidth = constraints.maxWidth;
    //
    //         return SingleChildScrollView(
    //           child: ConstrainedBox(
    //             constraints: BoxConstraints(
    //               minHeight: screenHeight,
    //             ),
    //             child: IntrinsicHeight(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.end,
    //                     children: [
    //                       TextButton(
    //                         onPressed: () {
    //                           Get.toNamed('/dashboard');
    //                         },
    //                         child: Text(
    //                           AppStrings.skip.tr,
    //                           style: const TextStyle(
    //                               fontSize: Dimensions.fontSizeDefault,
    //                               decoration: TextDecoration.underline,
    //                               letterSpacing: 1,
    //                               color: ColorResources.black2),
    //                         ),
    //                       )
    //                     ],
    //                   ),
    //                   const Gap(10),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       Image.asset(
    //                         Images.logo,
    //                         width: screenWidth * 0.7,
    //                         height: screenWidth * 0.7,
    //                       ),
    //                     ],
    //                   ),
    //                   if (configController.config.data!.activeOffer
    //                       .toString()
    //                       .isNotEmpty)
    //                     Column(
    //                       children: [
    //                         const Gap(Dimensions.gapLarge),
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Container(
    //                               padding: const EdgeInsets.all(2),
    //                               decoration: const BoxDecoration(
    //                                 color: ColorResources.colorSecondaryLight,
    //                                 borderRadius:
    //                                     BorderRadius.all(Radius.circular(5)),
    //                               ),
    //                               child: CustomTextMedium(
    //                                 configController.config.data!.activeOffer
    //                                     .toString(),
    //                                 color: ColorResources.toolbarText,
    //                                 fontSize: Dimensions.fontSizeLarge,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   const Gap(Dimensions.gapExtraExtraLarge),
    //                   Expanded(
    //                     child: ClipRRect(
    //                       borderRadius: const BorderRadius.only(
    //                         topRight: Radius.circular(20.0),
    //                         topLeft: Radius.circular(20.0),
    //                       ),
    //                       child: Container(
    //                         color: ColorResources.colorPrimary,
    //                         padding: const EdgeInsets.only(
    //                             left: Dimensions.marginSizeDefault,
    //                             right: Dimensions.marginSizeDefault,
    //                             top: 20),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             CustomTextMedium(
    //                               AppStrings.loginSignUp.tr,
    //                               fontSize: Dimensions.fontSizeExtraLarge,
    //                               textAlign: TextAlign.start,
    //                               color: ColorResources.toolbarText,
    //                             ),
    //                             const Gap(Dimensions.gapExtraSmall),
    //                             CustomTextRegular(
    //                               AppStrings.pleasEnterMobileNumber.tr,
    //                               fontSize: Dimensions.fontSizeDefault,
    //                               textAlign: TextAlign.start,
    //                               color: ColorResources.toolbarText,
    //                             ),
    //                             const Gap(Dimensions.gapOverLarge),
    //                             Form(
    //                               child: Container(
    //                                 decoration: BoxDecoration(
    //                                   borderRadius: BorderRadius.circular(
    //                                       Dimensions.borderRadiusDefault),
    //                                   color: ColorResources
    //                                       .colorPrimaryLight, // Background color
    //                                 ),
    //                                 clipBehavior: Clip.antiAlias,
    //                                 child: Row(
    //                                   children: [
    //                                     CountryCodePicker(
    //                                       onChanged: (CountryCode code) {
    //                                         controller.updateCountryCode(code);
    //                                       },
    //                                       initialSelection: 'IN',
    //                                       favorite: const ['IN', 'US'],
    //                                     ),
    //                                     Expanded(
    //                                       child: TextFormField(
    //                                         controller:
    //                                             controller.mobileController,
    //                                         onChanged: (value) {
    //                                           if (controller
    //                                                   .countryCode.value ==
    //                                               "+91") {
    //                                             if (value.length == 10) {
    //                                               FocusManager
    //                                                   .instance.primaryFocus
    //                                                   ?.unfocus();
    //                                             }
    //                                           }
    //                                         },
    //                                         keyboardType: TextInputType.phone,
    //                                         decoration: InputDecoration(
    //                                           hintText: AppStrings
    //                                               .enterYourPhoneNumber.tr,
    //                                           hintStyle: const TextStyle(
    //                                               fontSize: Dimensions
    //                                                   .fontSizeDefault),
    //                                           border: InputBorder.none,
    //                                           filled: true,
    //                                           fillColor: ColorResources
    //                                               .colorPrimaryLight,
    //                                           enabledBorder: InputBorder.none,
    //                                           contentPadding:
    //                                               const EdgeInsets.symmetric(
    //                                             horizontal: Dimensions
    //                                                 .paddingSizeOverSmall,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ),
    //                             const Gap(Dimensions.gapDefault),
    //                             Obx(() {
    //                               return controller.isSendingOtp.value
    //                                   ? const Center(child: CircularProgressIndicator())
    //                                   : CustomElevatedButton(
    //                                       text: AppStrings.sendOTP.tr,
    //                                       onPressed: controller
    //                                               .isSendingOtp.value
    //                                           ? null // disable during sending
    //                                           : () {
    //                                               controller.loginClick();
    //                                             },
    //                                       backgroundColor: ColorResources.black,
    //                                       textColor: ColorResources.toolbarText,
    //                                     );
    //                             }),
    //
    //                             /*CustomElevatedButton(
    //                               text: AppStrings.sendOTP.tr,
    //                               onPressed: () {
    //                                 controller.loginClick();
    //                               },
    //                               backgroundColor: ColorResources.black,
    //                               textColor: ColorResources.toolbarText,
    //                             ),*/
    //                             const Gap(Dimensions.gapDefault),
    //                             const Spacer(),
    //                             Row(
    //                               mainAxisAlignment: MainAxisAlignment.center,
    //                               children: [
    //                                 Padding(
    //                                   padding: const EdgeInsets.only(
    //                                       right: 15, left: 15, bottom: 20),
    //                                   child: RichText(
    //                                     textAlign: TextAlign.center,
    //                                     text: TextSpan(
    //                                       style: const TextStyle(
    //                                           fontSize:
    //                                               Dimensions.fontSizeDefault,
    //                                           color: ColorResources.black1,
    //                                           fontFamily: "EuclidRegular"),
    //                                       children: [
    //                                         TextSpan(
    //                                           text:
    //                                               AppStrings.termsCondition1.tr,
    //                                         ),
    //                                         _buildClickableTerms(
    //                                           text:
    //                                               AppStrings.termsCondition2.tr,
    //                                           onTap: () {
    //                                             Get.to(WebViewScreen(
    //                                                 AppStrings
    //                                                     .termsCondition2.tr,
    //                                                 AppConstants.tncUrl));
    //                                           },
    //                                         ),
    //                                         TextSpan(
    //                                           text:
    //                                               AppStrings.termsCondition3.tr,
    //                                         ),
    //                                         _buildClickableTerms(
    //                                           text:
    //                                               AppStrings.termsCondition4.tr,
    //                                           onTap: () {
    //                                             Get.to(WebViewScreen(
    //                                                 AppStrings.privacyPolicy.tr,
    //                                                 AppConstants
    //                                                     .privacyPolicyUrl));
    //                                           },
    //                                         ),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // );-

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorResources.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height * 0.37,
                color: const Color(0xFF020015),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed('/dashboard');
                        },
                        child: Text(
                          AppStrings.skip.tr,
                          style: const TextStyle(
                            fontSize: Dimensions.fontSizeDefault,
                            decoration: TextDecoration.underline,
                            letterSpacing: 1,
                            color: ColorResources.white,
                            decorationColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                              width: 200,
                              height: 180,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextMedium(
                            AppStrings.loginSignUp.tr,
                            fontSize: 26,
                            color: ColorResources.white,
                            textAlign: TextAlign.start,
                          ),
                          const Gap(6),
                          Text(
                            AppStrings.pleasEnterMobileNumber.tr,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 14,
                              color: ColorResources.white,
                              letterSpacing: 0.5,
                            ),
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
                          "Phone Number",
                          fontSize: Dimensions.fontSizeDefault,
                          color: ColorResources.black2,
                        ),
                      ],
                    ),
                    const Gap(8),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                        color: ColorResources.white,
                        border: Border.all(
                          color: ColorResources.black7,
                          width: 1,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Row(
                        children: [
                          CountryCodePicker(
                            onChanged: (CountryCode code) {
                              controller.updateCountryCode(code);
                            },
                            initialSelection: 'IN',
                            favorite: const ['IN', 'US'],
                            textStyle: const TextStyle(
                              fontSize: Dimensions.fontSizeDefault,
                              color: ColorResources.black2,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeOverSmall,
                              vertical: 6,
                            ),
                            flagDecoration: const BoxDecoration(),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: controller.mobileController,
                              onChanged: (value) {
                                if (controller.countryCode.value == "+91" &&
                                    value.length == 10) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                }
                              },
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: AppStrings.enterYourPhoneNumber.tr,
                                hintStyle: const TextStyle(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: ColorResources.hintTextColor,
                                ),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: ColorResources.white,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeOverSmall,
                                  vertical: 8,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),

                    // Send OTP Button
                    Obx(() {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: controller.isSendingOtp.value
                              ? Colors.grey
                              : ColorResources.colorPrimary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          onPressed: controller.isSendingOtp.value
                              ? null
                              : () {
                            controller.loginClick();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            disabledBackgroundColor: Colors.transparent,
                            disabledForegroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: CustomTextRegular(
                            controller.isSendingOtp.value
                                ? "Sending..."
                                : AppStrings.sendOTP.tr,
                            fontSize: 16,
                            color: ColorResources.toolbarText,
                          ),
                        ),
                      );
                    }),

                    const Gap(Dimensions.gapLarge),
                    _buildDividerWithOr(),
                    const Gap(Dimensions.gapLarge),
                    _buildGoogleLoginButton(),
                    const Gap(Dimensions.gapLarge),


                    Gap(200),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: Dimensions.fontSizeDefault,
                              color: ColorResources.black,
                              fontFamily: "EuclidRegular",
                            ),
                            children: [
                              TextSpan(
                                text: AppStrings.termsCondition1.tr,
                              ),
                              _buildClickableTerms(
                                text: AppStrings.termsCondition2.tr,
                                onTap: () {
                                  Get.to(
                                    WebViewScreen(
                                      AppStrings.termsCondition2.tr,
                                      AppConstants.tncUrl,
                                    ),
                                  );
                                },
                              ),
                              TextSpan(
                                text: AppStrings.termsCondition3.tr,
                              ),
                              _buildClickableTerms(
                                text: AppStrings.termsCondition4.tr,
                                onTap: () {
                                  Get.to(
                                    WebViewScreen(
                                      AppStrings.privacyPolicy.tr,
                                      AppConstants.privacyPolicyUrl,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
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
    );
  }

  Widget _buildDividerWithOr() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeThirtyFive),
      child: Row(
        children: [
          const Flexible(
            child: Divider(
              color: ColorResources.black6,
            ),
          ),
          const SizedBox(width: Dimensions.sizedBoxSmall),
          Text(AppStrings.or.tr,style: const TextStyle(
              color: ColorResources.black4
          ),),
          const SizedBox(width: Dimensions.sizedBoxSmall),
          const Flexible(
            child: Divider(
              color: ColorResources.black6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleLoginButton() {
    return Center(
      child: SizedBox(
        width: Get.width * 0.8,
        child: ElevatedButton(
          onPressed: () async {
            if (FocusManager.instance.primaryFocus != null) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
            controller.checkLocationPermission();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorResources.black7,// controller.showMobileLogin.value ? ColorResources.colorPrimaryVariant : ColorResources.black8,
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.google,height: 20,width: 20),
              const Gap(10),
              CustomTextRegular(
                "Sign In With Google",
                color: ColorResources.black,// controller.showMobileLogin.value ? ColorResources.black8 : ColorResources.black
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextSpan _buildClickableTerms({required String text, required Function onTap}) {
    return TextSpan(
      text: text,
      style: const TextStyle(color: ColorResources.orange, fontFamily: "EuclidRegular"),
      recognizer: TapGestureRecognizer()..onTap = onTap as void Function(),
    );
  }
}
