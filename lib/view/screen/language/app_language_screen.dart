import 'package:astro_brahmand/view/screen/language/controller/app_language_controller.dart';
import 'package:astro_brahmand/view/screen/language/widget/language_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_elevated_button.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';

class AppLanguageScreen extends GetView<AppLanguageController> {
  const AppLanguageScreen({super.key});
  // final AppLanguageController controller = Get.put(AppLanguageController());

  @override
  Widget build(BuildContext context) {
    final LocaleController localeController = Get.put(LocaleController());
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.chooseLanguage.tr),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Obx(() => LanguageItemWidget(
                      item: controller.items[index],
                      isSelected: controller.selectedValue.value == controller.items[index],
                      onTap: () {
                        controller.setSelectedLocale(controller.items[index].locale.toString());
                      },
                    ));
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: Dimensions.paddingSizeOverSmall,right: Dimensions.paddingSizeOverSmall,top: Dimensions.paddingSizeOverSmall),
                  child: CustomElevatedButton(
                    text: AppStrings.submit.tr,
                    onPressed: () async {
                      final selectedItem = controller.selectedValue.value;

                      if (selectedItem != null) {
                        if (selectedItem.name == 'English') {
                          Get.updateLocale(const Locale('en'));
                          controller.setSelectedLocale('en');
                          controller.setSelectedLocaleInSharedPreference('en');
                          Get.forceAppUpdate();
                          showDialog(AppStrings.appLanguageSuccessfullyUpdatedEnglish.tr);
                        }
                        else if (selectedItem.name == 'हिंदी') {
                          Get.updateLocale(const Locale('hi'));
                          controller.setSelectedLocale('hi');
                          controller.setSelectedLocaleInSharedPreference('hi');
                          Get.forceAppUpdate();
                          showDialog(AppStrings.appLanguageSuccessfullyUpdatedHindi.tr);
                        }
                        else if (selectedItem.name == 'મરાઠી') {
                          Get.updateLocale(const Locale('mr'));
                          controller.setSelectedLocale('mr');
                          controller.setSelectedLocaleInSharedPreference('mr');
                          Get.forceAppUpdate();
                          showDialog(AppStrings.appLanguageSuccessfullyUpdatedMarathi.tr);
                        }
                        else if (selectedItem.name == 'ગુજરાતી') {
                          Get.updateLocale(const Locale('gr'));
                          controller.setSelectedLocale('gr');
                          controller.setSelectedLocaleInSharedPreference('gr');
                          Get.forceAppUpdate();
                          showDialog(AppStrings.appLanguageSuccessfullyUpdatedGujarati.tr);
                        }
                        else if (selectedItem.name == 'తెలుగు') {
                          Get.updateLocale(const Locale('te'));
                          controller.setSelectedLocale('te');
                          controller.setSelectedLocaleInSharedPreference('te');
                          Get.forceAppUpdate();
                          showDialog(AppStrings.appLanguageSuccessfullyUpdatedTelugu.tr);
                        }
                        else if (selectedItem.name == 'বাংলা') {
                          Get.updateLocale(const Locale('be'));
                          controller.setSelectedLocale('be');
                          controller.setSelectedLocaleInSharedPreference('be');
                          Get.forceAppUpdate();
                          showDialog(AppStrings.appLanguageSuccessfullyUpdatedBengali.tr);
                        }
                        else if (selectedItem.name == 'ಕನ್ನಡ') {
                          Get.updateLocale(const Locale('ka'));
                          controller.setSelectedLocale('ka');
                          controller.setSelectedLocaleInSharedPreference('ka');
                          Get.forceAppUpdate();
                          showDialog(AppStrings.appLanguageSuccessfullyUpdatedKannada.tr);
                        }
                        else if (selectedItem.name == 'தமிழ்') {
                          Get.updateLocale(const Locale('ta'));
                          controller.setSelectedLocale('ta');
                          controller.setSelectedLocaleInSharedPreference('ta');
                          Get.forceAppUpdate();
                          showDialog(AppStrings.appLanguageSuccessfullyUpdatedTamil.tr);
                        }
                        else if (selectedItem.name == 'മലയാളം') {
                          Get.updateLocale(const Locale('ml'));
                          controller.setSelectedLocale('ml');
                          controller.setSelectedLocaleInSharedPreference('ml');
                          Get.forceAppUpdate();
                          showDialog(AppStrings.appLanguageSuccessfullyUpdatedMalayalam.tr);
                        }
                      }
                    },
                    backgroundColor: ColorResources.colorPrimary,
                    textColor: ColorResources.toolbarText,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showDialog(String text) {
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
                        Images.languageChange, // Image
                        height: 65,
                        width: 65,
                        color: ColorResources.colorPrimary,
                      ),
                    ],
                  ),
                  const Gap(8),
                  CustomTextMedium(
                    AppStrings.appLanguageChanged.tr,
                    fontSize: Dimensions.fontSizeExtraLarge,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(2),
                  CustomTextRegular(
                    text,
                    textAlign: TextAlign.center,
                    color: ColorResources.black4,
                  ),
                  const Gap(6),
                ],
              ),
            ),
          ),
        )
    );
    Future.delayed(const Duration(seconds: 1), () {
      Get.back();
      Get.back();
    });
  }
}


class LocaleController extends GetxController {
  RxString currentLocale = ''.obs; // Default to English locale

  void updateLocale(String locale) {
    currentLocale.value = locale;
  }
}