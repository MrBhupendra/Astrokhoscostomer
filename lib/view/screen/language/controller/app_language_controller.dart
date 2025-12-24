import 'dart:ui';
import 'package:astro_brahmand/view/screen/language/widget/language_items_widget.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/images.dart';

class AppLanguageController extends GetxController {
  late SharedPreferences _prefs;
  RxString currentLocale = ''.obs;
  var selectedValue = Rxn<Item>(); // Reactive variable

  final List<Item> items = [
    Item(
      name: 'English',
      langName: 'English',
      imagePath: Images.forEnglishLanguage,
      locale: const Locale('en'),
    ),
    Item(
      name: 'हिंदी',
      langName: 'Hindi',
      imagePath: Images.forHindiLanguage,
      locale: const Locale('hi'),
    ),
    Item(
      name: 'મરાઠી',
      langName: 'Marathi',
      imagePath: Images.forMarathiLanguage,
      locale: const Locale('mr'),
    ),
    Item(
      name: 'ગુજરાતી',
      langName: 'Gujarati',
      imagePath: Images.forGujaratiLanguage,
      locale: const Locale('gr'),
    ),
    Item(
      name: 'తెలుగు',
      langName: 'Telugu',
      imagePath: Images.forTelguLanguage,
      locale: const Locale('te'),
    ),
    Item(
      name: 'বাংলা',
      langName: 'Bengali',
      imagePath: Images.forBengoliLanguage,
      locale: const Locale('be'),
    ),
    Item(
      name: 'ಕನ್ನಡ',
      langName: 'Kannada',
      imagePath: Images.forKannadaLanguage,
      locale: const Locale('ka'),
    ),
    Item(
      name: 'தமிழ்',
      langName: 'Tamil',
      imagePath: Images.forTamilLanguage,
      locale: const Locale('ta'),
    ),
    Item(
      name: 'മലയാളം',
      langName: 'Malayalam',
      imagePath: Images.forMalayamLanguage,
      locale: const Locale('ml'),
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _loadSelectedLanguage();
    // SharedPreferences.getInstance().then((prefs) {
    //   _prefs = prefs;
    //   String? selectedLanguage = _prefs.getString(AppConstants.appLanguage);
    //   if (selectedLanguage != null) {
    //       selectedValue = items.firstWhere(
    //               (item) => item.locale.toString() == selectedLanguage,
    //           orElse: () => items[0]);
    //   }
    // });
  }

  void _loadSelectedLanguage() async {
    _prefs = await SharedPreferences.getInstance();
    String? selectedLanguage = _prefs.getString(AppConstants.appLanguage);
    if (selectedLanguage != null) {
      selectedValue.value = items.firstWhere(
            (item) => item.locale.toString() == selectedLanguage,
        orElse: () => items[0],
      );
    }
  }

  Future<void> setSelectedLocale(String language) async {
    // await _prefs.setString(AppConstants.appLanguage, language); // Removed as this was issue causing
    selectedValue.value = items.firstWhere((item) => item.locale.toString() == language);
  }
  Future<void> setSelectedLocaleInSharedPreference(String language) async {
    await _prefs.setString(AppConstants.appLanguage, language);
  }

  void updateLocale(Locale locale) {
    Get.updateLocale(locale);
  }
}
