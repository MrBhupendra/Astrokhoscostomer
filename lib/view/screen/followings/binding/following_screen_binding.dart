import 'package:astro_brahmand/view/screen/followings/controller/following_controller.dart';
import 'package:get/get.dart';

class FollowingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FollowingController>(FollowingController());
  }
}
