import 'package:get/get.dart';
import '../controller/service_controller.dart';

class ServiceBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ServiceController>(ServiceController());
  }}