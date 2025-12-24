import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/blog/controller/blog_controller.dart';

class BlogBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<BlogController>(BlogController());
  }}