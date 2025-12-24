import 'package:astro_brahmand/view/screen/video_section/controller/video_controller.dart';
import 'package:get/get.dart';

class VideoBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<VideoController>(VideoController());
  }}