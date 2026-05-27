import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../splash/controller/config_controller.dart';

class MaintenanceScreen extends StatelessWidget {
  MaintenanceScreen({super.key});
  final ConfigController configController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              Images.maintenance,
              width: 250,
              height: 250,
            ),
            const Gap(20),
            CustomTextMedium("Maintenance Mode",color: ColorResources.colorPrimary,fontSize: Dimensions.fontSizeOverLarge,textAlign: TextAlign.center,),
            const Gap(10),
            CustomTextRegular("We are currently performing some schedule maintenance. We will be back as soon as possible. Please check back soon.",color: ColorResources.black1,fontSize: Dimensions.fontSizeLarge,textAlign: TextAlign.center,),
          ]),),
      ),
    );
  }
}
