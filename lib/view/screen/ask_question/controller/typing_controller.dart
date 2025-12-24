import 'dart:async';
import 'package:get/get.dart';

class TypingController extends GetxController {
  var displayedMessage = ''.obs;
  int charIndex = 0;
  Timer? _timer;
  var isTyping = false.obs;

  void startTypingEffect(String fullMessage) {
    _timer?.cancel();
    charIndex = 0;
    displayedMessage.value = '';
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (charIndex < fullMessage.length) {
        displayedMessage.value += fullMessage[charIndex];
        charIndex++;
      } else {
        isTyping(false);
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
