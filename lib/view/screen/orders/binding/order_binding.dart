import 'package:astro_brahmand/view/screen/orders/controller/order_controller.dart';
import 'package:get/get.dart';

class OrderBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<OrderController>(OrderController());
  }}