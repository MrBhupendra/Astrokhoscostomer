import 'package:get/get.dart';
import '../controller/group_pooja_controller.dart';

class GroupPoojaBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<GroupPoojaController>(GroupPoojaController());
  }}