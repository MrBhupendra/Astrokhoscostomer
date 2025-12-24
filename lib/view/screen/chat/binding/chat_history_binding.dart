import 'package:get/get.dart';

import '../controller/chat_history_controller.dart';

class ChatHistoryBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ChatHistoryController>(ChatHistoryController());
  }}