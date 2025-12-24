import 'package:astro_brahmand/view/screen/subscription/controller/subscription_controller.dart';
import 'package:get/get.dart';

class SubscriptionBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<SubscriptionController>(SubscriptionController());
  }

}