import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/vedic_data.dart';

class KundliIntakeFormController extends GetxController {

  late KundliData kundliData;
  // late KundliData kundliData;

  late KundliMatchData kundliMatchingdata;

  void setKundliData(KundliData data) {
    kundliData = data;
  }

  void setKundliMatchingData(KundliMatchData data) {
    kundliMatchingdata = data;
  }


}