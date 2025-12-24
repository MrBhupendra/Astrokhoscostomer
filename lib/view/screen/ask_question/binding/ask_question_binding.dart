import 'package:get/get.dart';
import '../controller/ask_question_controller.dart';

class AskQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AskQuestionController>(AskQuestionController());
  }
}