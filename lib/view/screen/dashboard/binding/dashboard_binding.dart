import 'package:get/get.dart';

import '../../notification/controller/notification_controller.dart';
import '../controller/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController());
    Get.put<NotificationController>(NotificationController(), permanent: true);
  }
}
