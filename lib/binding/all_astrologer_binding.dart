import 'package:astro_brahmand/controller/all_astrologer_controller.dart';
import 'package:get/get.dart';

class AllAstrologerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<AllAstrologerController>(AllAstrologerController());
  }}