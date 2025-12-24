import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../model/menu_model.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_text_medium.dart';
import '../controller/love_compatibility_controller.dart';
import '../widget/matching_nakshtra_custom_bottom.dart';

class LoveCompatibilitySubmitScreen extends StatelessWidget {
  LoveCompatibilitySubmitScreen({super.key});
  final List<MenuModel> horoscopeListCo = [];

  final LoveCompatibilityController controller = Get.put(LoveCompatibilityController());

  @override
  Widget build(BuildContext context) {
    getHoroscopeList();
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.loveCompatibility.tr,
        ),
        body: ListView(
          children: [
            Column(
              children: [
                const Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomBottomSheet(
                              horoscopeListCo: horoscopeListCo,
                              onItemSelected: (selectedIndex) {
                                controller.updateBoySelectedNumber(selectedIndex);
                              },
                            );
                          },
                        );
                      },
                      child: controller.boySelectedNumber.value != -1
                          ? Row(
                        children: [
                          Column(
                            children: [
                              const Gap(Dimensions.gapExtraLarge),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                                  color: ColorResources.colorPrimaryLight,
                                  border: Border.all(
                                    color: ColorResources.colorPrimaryVariant,
                                    width: 2.0,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(Dimensions.borderRadiusRoundedall),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        horoscopeListCo[controller.boySelectedNumber.value].image,
                                        width: 50,
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(Dimensions.gapDefault),
                              CustomTextMedium(horoscopeListCo[controller.boySelectedNumber.value].title.toString()),
                            ],
                          ),
                          const Gap(Dimensions.gapSizeFifty),
                        ],
                      )
                          : Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              color: ColorResources.colorPrimaryLight,
                              border: Border.all(
                                color: ColorResources.colorPrimaryVariant,
                                width: 2.0,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(Dimensions.borderRadiusRoundedall),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
                              child: Column(
                                children: [
                                  Image.asset(
                                    Images.male,
                                    width: 50,
                                    height: 30,
                                  ),
                                  Text(AppStrings.male.tr)
                                ],
                              ),
                            ),
                          ),
                          const Gap(30),
                        ],
                      ),
                    )),
                    Obx(() => GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomBottomSheet(
                              horoscopeListCo: horoscopeListCo,
                              onItemSelected: (selectedIndex) {
                                controller.updateGirlSelectedNumber(selectedIndex);
                              },
                            );
                          },
                        );
                      },
                      child: controller.girlSelectedNumber.value != -1
                          ? Row(
                        children: [
                          Column(
                            children: [
                              const Gap(Dimensions.gapExtraLarge),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                                  color: ColorResources.colorPrimaryLight,
                                  border: Border.all(
                                    color: ColorResources.colorPrimaryVariant,
                                    width: 2.0,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(Dimensions.borderRadiusRoundedall),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        horoscopeListCo[controller.girlSelectedNumber.value].image,
                                        width: 50,
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(Dimensions.gapDefault),
                              CustomTextMedium(horoscopeListCo[controller.girlSelectedNumber.value].title.toString()),
                            ],
                          ),
                        ],
                      )
                          : Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              color: ColorResources.colorPrimaryLight,
                              border: Border.all(
                                color: ColorResources.colorPrimaryVariant,
                                width: 2.0,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(Dimensions.borderRadiusRoundedall),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
                              child: Column(
                                children: [
                                  Image.asset(
                                    Images.female,
                                    width: 50,
                                    height: 30,
                                  ),
                                  Text(AppStrings.female.tr)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),

                  ],
                ),
                const Gap(Dimensions.gapOverLarge),
                Obx(() => Visibility(
                  visible: controller.boySelectedNumber.value != -1 &&
                      controller.girlSelectedNumber.value != -1 &&
                      controller.showButton.value,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorResources.colorPrimary,
                    ),

                    onPressed: () {

                      Get.toNamed('/Love_compatibility');
                    },

                    child: Text(AppStrings.showNow.tr,
                      style: const TextStyle(
                        color: ColorResources.toolbarText ,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                    ),
                  ),
                )),
                Visibility(
                  visible: controller.showButton.isFalse &&
                      controller.isLoading.isFalse &&
                      controller.loveCompatModel.status != 200,
                  child: const Center(child: Text('No data available')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getHoroscopeList() {
    horoscopeListCo.clear();
    horoscopeListCo.add(MenuModel(AppStrings.aries.tr, Images.aries, '1'));
    horoscopeListCo.add(MenuModel(AppStrings.taurus.tr, Images.taurus, '2'));
    horoscopeListCo.add(MenuModel(AppStrings.gemini.tr, Images.gemini, '3'));
    horoscopeListCo.add(MenuModel(AppStrings.cancer.tr, Images.cancer, '4'));
    horoscopeListCo.add(MenuModel(AppStrings.leo.tr, Images.leo, '5'));
    horoscopeListCo.add(MenuModel(AppStrings.virgo.tr, Images.virgo, '6'));
    horoscopeListCo.add(MenuModel(AppStrings.libra.tr, Images.libra, '7'));
    horoscopeListCo.add(MenuModel(AppStrings.scorpio.tr, Images.scorpio, '8'));
    horoscopeListCo.add(MenuModel(AppStrings.sagittarius.tr, Images.sagittarius, '9'));
    horoscopeListCo.add(MenuModel(AppStrings.capricorn.tr, Images.capricorn, '10'));
    horoscopeListCo.add(MenuModel(AppStrings.aquarius.tr, Images.aquarius, '11'));
    horoscopeListCo.add(MenuModel(AppStrings.pisces.tr, Images.pisces, '12'));
  }
}