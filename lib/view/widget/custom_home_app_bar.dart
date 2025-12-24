import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/utill/color_resources.dart';

import '../../utill/images.dart';
import '../../utill/shared_preference.dart';
import '../screen/dashboard/controller/dashboard_controller.dart';
import '../screen/splash/controller/config_controller.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  DashboardController controller;
  final double height;

  CustomHomeAppBar(
    this.controller, {
    super.key,
    this.height = kToolbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: ColorResources.colorPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.only(right: 12.0, left: 10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: SizedBox(
              width: 30,
              height: 30,
              child: Image.asset(
                Images.menu,
                height: 20,
                color: ColorResources.toolbarText,
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            // flex: 2,
            child: CustomTextMedium(
              AppConstants.appName.tr,
              fontSize: Dimensions.fontSizeLarge,
                color: ColorResources.toolbarText,
              textAlign: TextAlign.start,
              // style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: ColorResources.toolbarText),
              // overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    bool isLogin = await SharedPreferencesHelper.getIsLogin();
                    if(isLogin){
                      Get.toNamed("/wallet");
                    }else{
                      Get.toNamed('/login');
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorResources.toolbarText,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 4),
                    child: Row(
                      children: [
                        Image.asset(
                          Images.walletBalance,
                          height: 25,
                          color: ColorResources.toolbarText,
                        ),
                        const Gap(5),
                        Obx(() {
                          if (controller.isBalanceLoading.value) {
                            return const SizedBox(
                                width: 20.0, // Set your desired width
                                height: 20.0,
                                child: CircularProgressIndicator(
                                  color: ColorResources.colorSecondary,
                                  strokeWidth: 1.0,
                                ));
                          } else if (controller.isBalanceSuccess.value) {
                            return CustomTextMedium(
                                '${configController.currencySymbol}${controller.walletBalanceModel.data.toString()}',
                                color: ColorResources.toolbarText);
                          } else {
                            return const Text('***',
                                style: TextStyle(fontSize: 14,color: ColorResources.toolbarText));
                          }
                        }),
                      ],
                    ),
                  ),
                ),
                const Gap(8),
                GestureDetector(
                  onTap: () async {
                    bool isLogin = await SharedPreferencesHelper.getIsLogin();
                    if(isLogin){
                      Get.toNamed("/language_screen");
                    }else{
                      Get.toNamed('/login');
                    }
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorResources.toolbarText,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        Image.asset(
                          Images.language,
                          height: 25,
                          color: ColorResources.toolbarText,
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(8),
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/search");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorResources.toolbarText,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        Image.asset(
                          Images.search,
                          height: 25,
                          color: ColorResources.toolbarText,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
