import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../widget/custom_elevated_button.dart';
import '../../widget/custom_snack_bar.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../splash/controller/config_controller.dart';

class UpdateScreen extends StatelessWidget {
  UpdateScreen({super.key});
  final ConfigController configController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

            Image.asset(
              Images.update,
              width: 250,
              height: 250,
            ),
            const Gap(20),
            CustomTextMedium("Update",color: ColorResources.colorPrimary,fontSize: Dimensions.fontSizeOverLarge,textAlign: TextAlign.center,),
            const Gap(10),
            CustomTextRegular("The app you using is deprecated. A newer version of this app is available. Please update your app.",color: ColorResources.black1,fontSize: Dimensions.fontSizeLarge,textAlign: TextAlign.center,),
            const Gap(20),
            CustomElevatedButton(text: "Update Now",backgroundColor: ColorResources.colorPrimary,textColor: ColorResources.toolbarText,onPressed: () async {
              String? appUrl = 'https://google.com';
              if (Platform.isAndroid) {
                appUrl = configController.config.data?.customerPlayStoreUrl;
              } else if (Platform.isIOS) {
                appUrl = configController.config.data?.customerAppStoreUrl;
              }
              if (await canLaunchUrlString(appUrl!)) {
              launchUrlString(
              appUrl, mode: LaunchMode.externalApplication);
              } else {
                CustomSnackBar.showBottom("Can't launch $appUrl");
              }
            },),
          ]),),
      ),
    );
  }
}
