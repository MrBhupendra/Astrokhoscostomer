import 'package:get/get.dart';

class GroupPoojaLiveStreamInitController extends GetxController {

  String? astrologerName;
  String? astrologerImage;

  void setAstrologerData(String astrologerName_, String astrologerImage_) {
    astrologerName = astrologerName_;
    astrologerImage = astrologerImage_;
  }
}