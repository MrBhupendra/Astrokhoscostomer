import 'package:astro_brahmand/view/screen/architect/controller/architect_profile_controller.dart';
import 'package:get/get.dart';

class ArchitectProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ArchitectProfileController>(ArchitectProfileController());
  }}