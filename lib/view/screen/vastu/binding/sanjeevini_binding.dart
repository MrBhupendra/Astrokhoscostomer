import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/vastu/controller/sanjeevini_controller.dart';

class SanjeeviniBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<SanjeeviniController>(SanjeeviniController());
  }}