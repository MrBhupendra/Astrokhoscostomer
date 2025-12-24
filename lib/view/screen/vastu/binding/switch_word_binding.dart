import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/vastu/controller/switch_word_controller.dart';

class SwitchWordBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<SwitchWordController>(SwitchWordController());
  }}