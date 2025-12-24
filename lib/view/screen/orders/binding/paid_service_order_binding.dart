import 'package:get/get.dart';

import '../controller/paid_service_order_controller.dart';

class PaidServiceOrderBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<PaidServiceOrderController>(PaidServiceOrderController());
  }}