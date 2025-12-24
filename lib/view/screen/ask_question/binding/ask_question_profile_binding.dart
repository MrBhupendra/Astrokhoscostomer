import 'package:astro_brahmand/view/screen/ask_question/controller/ask_question_profile_controller.dart';
import 'package:get/get.dart';

class AskQuestionProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AskQuestionProfileController>(AskQuestionProfileController());
  }
}