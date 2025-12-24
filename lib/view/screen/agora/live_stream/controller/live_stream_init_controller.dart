import 'package:get/get.dart';

class LiveStreamInitController extends GetxController {

  String? astrologerName;
  String? astrologerImage;
  String? callPrice;
  String? videoCallPrice;
  String? privateCallPrice;
  String? privateVideoCallPrice;
  String? callDuration;
  String? videoCallDuration;
  String? privateCallDuration;
  String? privateVideoCallDuration;
  String? type;

  void setAstrologerData(String astrologerName_, String astrologerImage_, String callPrice_,String videoCallPrice_, String callDuration_,String videoCallDuration_,
      String privateCallPrice_,String privateVideoCallPrice_, String privateCallDuration_,String privateVideoCallDuration_,
      String type_) {
    astrologerName = astrologerName_;
    astrologerImage = astrologerImage_;
    callPrice = callPrice_;
    videoCallPrice = videoCallPrice_;
    callDuration = callDuration_;
    videoCallDuration = videoCallDuration_;
    privateCallPrice = privateCallPrice_;
    privateVideoCallPrice = privateVideoCallPrice_;
    privateCallDuration = privateCallDuration_;
    privateVideoCallDuration = privateVideoCallDuration_;
    type = type_;
  }
}