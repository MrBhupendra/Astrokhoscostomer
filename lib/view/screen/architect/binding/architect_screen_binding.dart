import 'package:get/get.dart';
import '../controller/architect_controller.dart';

class ArchitectScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ArchitectController>(ArchitectController());
  }}