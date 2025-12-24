import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_default_indicator.dart';
import '../../widget/custom_progress_indicator.dart';
import '../../widget/custom_status_switch.dart';
import 'controller/setting_controller.dart';

class SettingScreen extends StatelessWidget {
   SettingScreen({super.key});

  final SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar:  CustomAppBar(title:AppStrings.settings.tr),
          body: Obx(
                () => controller.isBalanceSuccess.isFalse
                ? const CustomDefaultProgressIndicator()
                : Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorResources.white,
                            borderRadius: BorderRadius.circular(
                                Dimensions.borderRadiusDefault),
                            border: Border.all(
                                color: ColorResources.colorPrimaryLight,
                                width: 1.5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextMedium("Privacy",fontSize: Dimensions.fontSizeLarge,),
                              const Gap(10),
                              Row(
                                children: [
                                  Expanded(child: CustomTextRegular("Show my name in reviews section of astrologer's profile",)),
                                  const Gap(5),
                                  Obx(() {
                                    return CustomStatusSwitch(
                                      value: controller.anonymousReviewStatus.value, // Pass the boolean value, not RxBool
                                      onChanged: (value) {
                                        controller.updateAnonymousReviewStatus(
                                            controller.anonymousReviewStatus.value ? "0" : "1"
                                        );
                                      },
                                    );
                                  }),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(
                      () => controller.isAnonymousStatusLoading.value
                      ? const CustomProgressIndicator()
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          )
        )
    );
  }
}
