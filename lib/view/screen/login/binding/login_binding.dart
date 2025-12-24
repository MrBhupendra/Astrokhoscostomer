import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/login/controller/login_controller.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }

}