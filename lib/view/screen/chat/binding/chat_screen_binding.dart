import 'package:get/get.dart';

import '../controller/chat_screen_controller.dart';

class ChatScreenBinding extends Bindings{
  @override
  void dependencies() {
    // Always start a fresh controller so a previous ended session
    // (isChatEnd=true / dead listeners) cannot leak into the next chat.
    if (Get.isRegistered<ChatScreenController>()) {
      Get.delete<ChatScreenController>(force: true);
    }
    Get.put<ChatScreenController>(ChatScreenController());
  }}