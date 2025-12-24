import 'package:astro_brahmand/view/screen/architect/controller/architect_orders_controller.dart';
import 'package:get/get.dart';

class ArchitectOrderBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ArchitectOrdersController>(ArchitectOrdersController());
  }}