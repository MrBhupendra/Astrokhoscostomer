import 'package:astro_brahmand/view/screen/queue_list/controller/queue_controller.dart';
import 'package:get/get.dart';


class QueueBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<QueueController>(QueueController());
  }
}
