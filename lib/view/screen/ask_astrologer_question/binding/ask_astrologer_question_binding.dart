import 'package:astro_brahmand/view/screen/ask_astrologer_question/controller/ask_astrologer_question_controller.dart';
import 'package:get/get.dart';

class AskAstrologerQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AskAstrologerQuestionController>(AskAstrologerQuestionController());
  }
}