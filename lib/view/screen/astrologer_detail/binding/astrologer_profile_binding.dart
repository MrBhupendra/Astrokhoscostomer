import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/astrologer_detail/controller/astrologer_profile_controller.dart';

class AstrologerProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<AstrologerProfileController>(AstrologerProfileController());
  }}