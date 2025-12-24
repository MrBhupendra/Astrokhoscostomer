import 'package:astro_brahmand/view/screen/language/controller/app_language_controller.dart';
import 'package:get/get.dart';

class AppLanguageBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<AppLanguageController>(AppLanguageController());
  }}