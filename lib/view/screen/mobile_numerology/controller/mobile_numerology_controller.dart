import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';

class MobileNumerologyController extends GetxController {
  final RxString countryCode = '+91'.obs;
  final RxString phoneNumber = ''.obs;

  void updateCountryCode(CountryCode code) {
    countryCode.value = code.dialCode!;
  }

  void updatePhoneNumber(String number) {
    phoneNumber.value = number;
  }
}
