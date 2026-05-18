import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../utill/app_strings.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderRadius? borderRadius;

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
        color: textColor ?? ColorResources.toolbarText,
        fontSize: 14,
        letterSpacing: 1,
    );

    return SizedBox(
      width: Get.width,
      child: ElevatedButton(
        onPressed: () async {

          bool isConnected = await _isConnectedToInternet();

          if (FocusManager.instance.primaryFocus != null) {
            FocusManager.instance.primaryFocus!.unfocus();
          }

          if (!isConnected) {
            showNoNetworkDialog();
          } else {
            onPressed?. call();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? ColorResources.colorPrimary,
          padding: const EdgeInsets.only(top: 13, bottom: 13),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<bool> _isConnectedToInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
  void showNoNetworkDialog() {
    Get.dialog(
        Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            width: Get.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10,top: 10,bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Images.noInternet, // Image
                        height: 65,
                        width: 65,
                        color: ColorResources.black5,
                      ),
                    ],
                  ),
                  const Gap(8),
                  CustomTextMedium(
                    AppStrings.noInternet.tr,
                    fontSize: Dimensions.fontSizeOverLarge,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(2),
                  CustomTextRegular(
                    AppStrings.noInternetMsg.tr,
                    textAlign: TextAlign.center,
                    color: ColorResources.black4,
                  ),
                  const Gap(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          AppSettings.openAppSettings(type: AppSettingsType.wifi);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeDefault,
                              vertical: Dimensions.paddingSizeOverSmall
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: ColorResources.green)
                            // color: ColorResources.colorPrimary,
                          ),
                          child: CustomTextRegular(
                            "Connect",
                            textAlign: TextAlign.center,
                            // fontSize: Dimensions.fontSizeSmall,
                            color: ColorResources.green,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false
    );
    // Get.defaultDialog(
    //   title: AppStrings.noInternet.tr,
    //   barrierDismissible: false,
    //   content: Text(AppStrings.noInternetMsg.tr),
    //   confirm: TextButton(
    //     onPressed: () {
    //       Get.back();
    //     },
    //     child: Container(
    //       decoration: BoxDecoration(
    //         color: ColorResources.colorPrimary,
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: Container(
    //           padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 14),
    //           decoration: BoxDecoration(
    //             color: ColorResources.colorPrimary,
    //             borderRadius: BorderRadius.circular(5),
    //           ),
    //           child: CustomTextRegular("Ok",color: ColorResources.toolbarText,)
    //       ),
    //     ),
    //   ),
    // );
  }
}
