import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/astro_shop/controller/products_controller.dart';

class ProductsBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ProductsController>(ProductsController());
  }}