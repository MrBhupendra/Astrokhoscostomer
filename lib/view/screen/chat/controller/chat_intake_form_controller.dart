import 'dart:async';

import 'package:astro_brahmand/utill/app_dialogs.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/widget/custom_default_dialog.dart';
import 'package:flutter/material.dart';
import 'package:astro_brahmand/view/screen/chat/model/chat_success_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../model/success_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/common_methods.dart';
import '../../../../utill/images.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_call_connect_widget.dart';
import '../../../widget/custom_okdialog_widget.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class ChatIntakeFormController extends GetxController {
  final Dio _dio = Dio();
  final isLoading = false.obs;
  final isSuccess = false.obs;

  //Intake Save
  final isSaveLoading = false.obs;
  final isSaveSuccess = false.obs;
  SuccessModel saveSuccessModel = SuccessModel();

  //Chat
  ChatSuccessModel chatSuccessModel = ChatSuccessModel();
  ChatSuccessModel chatEmergencySuccessModel = ChatSuccessModel();

  //Call
  ChatSuccessModel startVoiceCallModel = ChatSuccessModel();
  ChatSuccessModel startEmergencyVoiceCallModel = ChatSuccessModel();

  //VideoCall
  ChatSuccessModel startVideoCallModel = ChatSuccessModel();
  ChatSuccessModel startEmergencyVideoCallModel = ChatSuccessModel();

  //VoiceCall
  ChatSuccessModel startInAppVoiceCallModel = ChatSuccessModel();
  ChatSuccessModel startEmergencyInAppVoiceCallModel = ChatSuccessModel();

  //AssistantChat
  ChatSuccessModel assistantChatSuccessModel = ChatSuccessModel();

  int isVirtualAstrologer = 0;
  String? astrologerName = '';
  String? astrologerImage = '';
  String? astrologerUniId = '';
  String? callType = '';
  String? chatId = '';
  String? channelName = '';

  String? name = '';
  String? gender = '';
  String? dob = '';
  String? tob = '';
  String? birthPlace = '';
  String? latitude = '';
  String? longitude = '';
  String? maritalStatus = '';
  String? occupation = '';
  String? topicOfConcernType = '';
  String? topicOfConcernDetail = '';

  //Partner Details
  String? partnerName = '';
  String? partnerGender = '';
  String? partnerDob = '';
  String? partnerTob = '';
  String? partnerBirthPlace = '';
  String? partnerLatitude = '';
  String? partnerLongitude = '';

  //Init Data
  RxString selectedGender = ''.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController birthTimeController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  final TextEditingController maritalStatusController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController concernController = TextEditingController();
  final TextEditingController concernOtherController = TextEditingController();

  //Partner Details
  RxString partnerSelectedGender = ''.obs;
  final TextEditingController partnerNameController = TextEditingController();
  final TextEditingController partnerBirthDateController = TextEditingController();
  final TextEditingController partnerBirthTimeController = TextEditingController();
  final TextEditingController partnerBirthPlaceController = TextEditingController();
  final TextEditingController partnerLatitudeController = TextEditingController();
  final TextEditingController partnerLongitudeController = TextEditingController();

  Future<void> initData() async {
    String? name = await SharedPreferencesHelper.getData(AppConstants.name) ?? "";
    String? gender = await SharedPreferencesHelper.getData(AppConstants.gender) ?? "";
    String? dob = await SharedPreferencesHelper.getData(AppConstants.birthDate) ?? "";
    String? tob = await SharedPreferencesHelper.getData(AppConstants.birthTime) ?? "";
    String? pob = await SharedPreferencesHelper.getData(AppConstants.birthPlace) ?? "";
    String? latitude = await SharedPreferencesHelper.getData(AppConstants.latitude) ?? "";
    String? longitude = await SharedPreferencesHelper.getData(AppConstants.longitude) ?? "";

    nameController.text = name;
    selectedGender.value = gender;
    birthDateController.text = dob;
    birthTimeController.text = tob;
    birthPlaceController.text = pob;
    latitudeController.text = latitude;
    longitudeController.text = longitude;
  }

  void setIntakeData(
      String name_,
      String gender_,
      String dob_,
      String tob_,
      String birthPlace_,
      String latitude_,
      String longitude_,
      String maritalStatus_,
      String occupation_,
      String topicOfConcernType_,
      String topicOfConcernDetail_,
  {
    String partnerName_ = "",
    String partnerGender_ = "",
    String partnerDob_ = "",
    String partnerTob_ = "",
    String partnerBirthPlace_ = "",
    String partnerLatitude_ = "",
    String partnerLongitude_ = ""
  }) {
    name = name_;
    gender = gender_;
    dob = dob_;
    tob = tob_;
    birthPlace = birthPlace_;
    latitude = latitude_;
    longitude = longitude_;
    maritalStatus = maritalStatus_;
    occupation = occupation_;
    topicOfConcernType = topicOfConcernType_;
    topicOfConcernDetail = topicOfConcernDetail_;
    partnerName = partnerName_;
    partnerGender = partnerGender_;
    partnerDob = partnerDob_;
    partnerTob = partnerTob_;
    partnerBirthPlace = partnerBirthPlace_;
    partnerLatitude = partnerLatitude_;
    partnerLongitude = partnerLongitude_;
  }

  void setAstrologerData(String astrologerName_, String astrologerImage_, String astrologerUniId_, String callType_, int isVirtualAstrologer_) {
    astrologerName = astrologerName_;
    astrologerImage = astrologerImage_;
    astrologerUniId = astrologerUniId_;
    callType = callType_;
    isVirtualAstrologer = isVirtualAstrologer_;
  }

  void updateGender(String gender) {
    selectedGender.value = gender;
  }

  void updatePartnerGender(String gender) {
    partnerSelectedGender.value = gender;
  }

  Future<void> startChat(String? astrologerUniId) async {
    CustomProgressDialog.showDialog();
    isLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? cusImage = await SharedPreferencesHelper.getData(AppConstants.profileImage);
      String? cusName = await SharedPreferencesHelper.getData(AppConstants.name);
      AppLogger.d("[CHAT] startChat request=> $apiKey $uniId $astrologerUniId $cusImage");
      final response = await _dio.post(AppConstants.startChat, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'astrologer_uni_id': astrologerUniId
      });
      AppLogger.d("[CHAT] startChat response=> ${response.data.toString()}");
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        chatSuccessModel = ChatSuccessModel.fromJson(response.data);
        if (chatSuccessModel.status == AppConstants.success) {
          isSuccess(true);
           AppLogger.d("ChatResponse->$response");
          if (chatSuccessModel.joinStatus == 0) {
            AppDialog().showCallDialog(chatSuccessModel.msg.toString(), "Queue",AppConstants.chat, cusImage.toString(), cusName.toString(), astrologerImage.toString(), astrologerName.toString());
          } else if (chatSuccessModel.joinStatus == 1 || chatSuccessModel.joinStatus == 2) {
            String? customerUniUd = await SharedPreferencesHelper.getData(AppConstants.userUniId);
            String channelName = '$customerUniUd-$astrologerUniId';
            Get.toNamed('/chat_screen', arguments: {
              'channelName': channelName,
              'uniqueId': chatSuccessModel.data?.uniqeid.toString()
            });
          } else {
            CustomSnackBar.showBottom(chatSuccessModel.msg.toString());
          }

          //Save intake data
          if (chatSuccessModel.intakeStatus == 1) {
            saveIntakeData(chatSuccessModel.data?.uniqeid.toString(), AppConstants.chat);
          }
        } else {
          isSuccess(false);
          if (chatSuccessModel.errorCode == AppConstants.insufficientBalance) {
            CommonMethods().showInsufficientBalancedDialog();
          } else {
            CustomSnackBar.showBottom(chatSuccessModel.msg.toString());
          }
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  //Emergency Chat
  Future<void> startEmergencyChat(String? astrologerUniId) async {
    CustomProgressDialog.showDialog();
    isLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? cusImage = await SharedPreferencesHelper.getData(AppConstants.profileImage);
      AppLogger.d("Request $apiKey $uniId $astrologerUniId");
      final response = await _dio.post(AppConstants.startEmergencyChat, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'astrologer_uni_id': astrologerUniId
      });

      AppLogger.d("[CHAT] startChat response=> ${response.data.toString()}");
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        chatEmergencySuccessModel = ChatSuccessModel.fromJson(response.data);
        if (chatEmergencySuccessModel.status == AppConstants.success) {
          isSuccess(true);

          if (chatEmergencySuccessModel.joinStatus == 0) {
            AppDialog().showCallSuccessDialog(chatEmergencySuccessModel.msg.toString(), "Queue");
            // AppDialog().showCallDialog(chatEmergencySuccessModel.msg.toString(), "Queue",  cusImage.toString(), chatEmergencySuccessModel.data!.name.toString(), astrologerImage.toString(), astrologerName.toString());

          } else if (chatEmergencySuccessModel.joinStatus == 1 || chatEmergencySuccessModel.joinStatus == 2) {
            String? customerUniUd = await SharedPreferencesHelper.getData(AppConstants.userUniId);
            String channelName = '$customerUniUd-$astrologerUniId';
            Get.toNamed('/chat_screen', arguments: {
              'channelName': channelName,
              'uniqueId': chatEmergencySuccessModel.data?.uniqeid.toString()
            });
          } else {
            CustomSnackBar.showBottom(chatEmergencySuccessModel.msg.toString());
          }

          //Save intake data
          if (chatEmergencySuccessModel.intakeStatus == 1) {
            saveIntakeData(chatEmergencySuccessModel.data?.uniqeid.toString(), AppConstants.emergencyChat);
          }
        } else {
          isSuccess(false);
          if (chatEmergencySuccessModel.errorCode == AppConstants.insufficientBalance) {
            CommonMethods().showInsufficientBalancedDialog();
          } else {
            CustomSnackBar.showBottom(chatEmergencySuccessModel.msg.toString());
          }
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> startVoiceCall(String? astrologerUniId) async {
    CustomProgressDialog.showDialog();
    isLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? cusImage = await SharedPreferencesHelper.getData(AppConstants.profileImage);
      String? cusName = await SharedPreferencesHelper.getData(AppConstants.name);
      final response = await _dio.post(AppConstants.startVoiceCall, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'astrologer_id': astrologerUniId,
      });
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        startVoiceCallModel = ChatSuccessModel.fromJson(response.data);
        if (startVoiceCallModel.status == AppConstants.success) {
          isSuccess(true);
          Get.back();

          if (startVoiceCallModel.joinStatus == 0) {
            // showCallDialog(startVoiceCallModel.msg.toString(), "Queue");
            AppDialog().showCallDialog(startVoiceCallModel.msg.toString(), "Queue",AppConstants.call,  cusImage.toString(), cusName.toString(), astrologerImage.toString(), astrologerName.toString());
          } else {
            // showCallDialog(startVoiceCallModel.msg.toString(), "Init");
            AppDialog().showCallDialog(startVoiceCallModel.msg.toString(), "Init",AppConstants.call,  cusImage.toString(), cusName.toString(), astrologerImage.toString(), astrologerName.toString());

          }

          //Save intake data
          if (startVoiceCallModel.intakeStatus == 1) {
            saveIntakeData(startVoiceCallModel.data?.uniqeid.toString(), AppConstants.call);
          }
        } else {
          isSuccess(false);

          //Handle error code here
          if (startVoiceCallModel.errorCode ==
              AppConstants.insufficientBalance) {
            CommonMethods().showInsufficientBalancedDialog();
          } else {
            CustomSnackBar.showBottom(startVoiceCallModel.msg.toString());
          }
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> startInAppVoiceCall(String? astrologerUniId) async {
    CustomProgressDialog.showDialog();
    isLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? cusImage = await SharedPreferencesHelper.getData(AppConstants.profileImage);
      String? cusName = await SharedPreferencesHelper.getData(AppConstants.name);
      final response = await _dio.post(AppConstants.startInAppVoiceCall, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'astrologer_uni_id': astrologerUniId,
      });

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        startInAppVoiceCallModel = ChatSuccessModel.fromJson(response.data);
        if (startInAppVoiceCallModel.status == AppConstants.success) {
          isSuccess(true);
          // Get.back();
          if (startInAppVoiceCallModel.joinStatus == 0) {
            // showCallDialog(startInAppVoiceCallModel.msg.toString(), "Queue");
            AppDialog().showCallDialog(startInAppVoiceCallModel.msg.toString(), "Queue",AppConstants.call,  cusImage.toString(), cusName.toString(), astrologerImage.toString(), astrologerName.toString());
          } else if (startInAppVoiceCallModel.joinStatus == 1 ||
              startInAppVoiceCallModel.joinStatus == 2) {
            String? customerUniUd =
                await SharedPreferencesHelper.getData(AppConstants.userUniId);
            String? agoraAppId =
                await SharedPreferencesHelper.getData(AppConstants.agoraAppId);
            String channelName = '$customerUniUd-$astrologerUniId-Call';

            AppLogger.d("StartInAppVoiceCall Data-> channel:$channelName uniqueId:${startInAppVoiceCallModel.data?.uniqeid.toString()} agoraAppId:$agoraAppId token:${startInAppVoiceCallModel.data!.agoraToken.toString()}");
            Get.toNamed('/voiceCallScreen', arguments: {
              'channelName': channelName,
              'uniqueId': startInAppVoiceCallModel.data?.uniqeid.toString(),
              'agoraAppId': agoraAppId,
              'token': startInAppVoiceCallModel.data!.agoraToken.toString(),
            });
          } else {
            CustomSnackBar.showBottom(startInAppVoiceCallModel.msg.toString());
          }

          //Save intake data
          if (startInAppVoiceCallModel.intakeStatus == 1) {
            saveIntakeData(startInAppVoiceCallModel.data?.uniqeid.toString(), AppConstants.call);
          }
        } else {
          isSuccess(false);

          //Handle error code here
          if (startInAppVoiceCallModel.errorCode == AppConstants.insufficientBalance) {
            CommonMethods().showInsufficientBalancedDialog();
          } else {
            CustomSnackBar.showBottom(startInAppVoiceCallModel.msg.toString());
          }
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  //Emergency Call
  Future<void> startEmergencyVoiceCall(String? astrologerUniId) async {
    CustomProgressDialog.showDialog();
    isLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.startEmergencyVoiceCall, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'astrologer_uni_id': astrologerUniId,
      });
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        startEmergencyVoiceCallModel = ChatSuccessModel.fromJson(response.data);
        if (startEmergencyVoiceCallModel.status == AppConstants.success) {
          isSuccess(true);
          Get.back();

          if (startEmergencyVoiceCallModel.joinStatus == 0) {
            AppDialog().showCallSuccessDialog(startEmergencyVoiceCallModel.msg.toString(), "Queue");
          } else {
            AppDialog().showCallSuccessDialog(startEmergencyVoiceCallModel.msg.toString(), "Init");
          }

          //Save intake data
          if (startEmergencyVoiceCallModel.intakeStatus == 1) {
            saveIntakeData(startEmergencyVoiceCallModel.data?.uniqeid.toString(), AppConstants.emergencyCall);
          }
        } else {
          isSuccess(false);

          //Handle error code here
          if (startEmergencyVoiceCallModel.errorCode == AppConstants.insufficientBalance) {
            CommonMethods().showInsufficientBalancedDialog();
          } else {
            CustomSnackBar.showBottom(startEmergencyVoiceCallModel.msg.toString());
          }
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> startEmergencyInAppVoiceCall(String? astrologerUniId) async {
    CustomProgressDialog.showDialog();
    isLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.startEmergencyInAppVoiceCall, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'astrologer_uni_id': astrologerUniId,
      });

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        startEmergencyInAppVoiceCallModel = ChatSuccessModel.fromJson(response.data);
        if (startEmergencyInAppVoiceCallModel.status == AppConstants.success) {
          isSuccess(true);
          Get.back();
          if (startEmergencyInAppVoiceCallModel.joinStatus == 0) {
            AppDialog().showCallSuccessDialog(startEmergencyInAppVoiceCallModel.msg.toString(), "Queue");
          } else if (startEmergencyInAppVoiceCallModel.joinStatus == 1 || startEmergencyInAppVoiceCallModel.joinStatus == 2) {
            String? customerUniUd = await SharedPreferencesHelper.getData(AppConstants.userUniId);
            String? agoraAppId = await SharedPreferencesHelper.getData(AppConstants.agoraAppId);
            String channelName = '$customerUniUd-$astrologerUniId-Call';

            AppLogger.d("StartInAppVoiceCall Data-> channel:$channelName uniqueId:${startEmergencyInAppVoiceCallModel.data?.uniqeid.toString()} agoraAppId:$agoraAppId token:${startEmergencyInAppVoiceCallModel.data!.agoraToken.toString()}");
            Get.toNamed('/voiceCallScreen', arguments: {
              'channelName': channelName,
              'uniqueId': startEmergencyInAppVoiceCallModel.data?.uniqeid.toString(),
              'agoraAppId': agoraAppId,
              'token': startEmergencyInAppVoiceCallModel.data!.agoraToken.toString(),
            });
          } else {
            CustomSnackBar.showBottom(startEmergencyInAppVoiceCallModel.msg.toString());
          }

          //Save intake data
          if (startEmergencyInAppVoiceCallModel.intakeStatus == 1) {
            saveIntakeData(startEmergencyInAppVoiceCallModel.data?.uniqeid.toString(), AppConstants.emergencyCall);
          }
        } else {
          isSuccess(false);

          //Handle error code here
          if (startEmergencyInAppVoiceCallModel.errorCode == AppConstants.insufficientBalance) {
            CommonMethods().showInsufficientBalancedDialog();
          } else {
            CustomSnackBar.showBottom(startEmergencyInAppVoiceCallModel.msg.toString());
          }
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
  //Emergency Call End

  Future<void> startVideoCall(String? astrologerUniId) async {
    CustomProgressDialog.showDialog();
    isLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? cusImage = await SharedPreferencesHelper.getData(AppConstants.profileImage);
      String? cusName = await SharedPreferencesHelper.getData(AppConstants.name);
      final response = await _dio.post(AppConstants.startVideoCall, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'astrologer_uni_id': astrologerUniId,
      });
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        startVideoCallModel = ChatSuccessModel.fromJson(response.data);
        if (startVideoCallModel.status == AppConstants.success) {
          isSuccess(true);
          // Get.back();

          if (startVideoCallModel.joinStatus == 0) {
            // showCallDialog(startVideoCallModel.msg.toString(), "Queue");
            AppDialog().showCallDialog(startVideoCallModel.msg.toString(), "Queue",AppConstants.video,  cusImage.toString(), cusName.toString(), astrologerImage.toString(), astrologerName.toString());

          } else if (startVideoCallModel.joinStatus == 1 || startVideoCallModel.joinStatus == 2) {
            String? customerUniUd = await SharedPreferencesHelper.getData(AppConstants.userUniId);
            String? agoraAppId = await SharedPreferencesHelper.getData(AppConstants.agoraAppId);
            String channelName = '$customerUniUd-$astrologerUniId-Video';

            AppLogger.d("StartVideoCall Data-> channel:$channelName uniqueId:${startVideoCallModel.data?.uniqeid.toString()} agoraAppId:$agoraAppId token:${startVideoCallModel.data!.agoraToken.toString()}");
            Get.toNamed('/videoCallScreen', arguments: {
              'channelName': channelName,
              'uniqueId': startVideoCallModel.data?.uniqeid.toString(),
              'agoraAppId': agoraAppId,
              'token': startVideoCallModel.data!.agoraToken.toString(),
            });
          } else {
            CustomSnackBar.showBottom(startVideoCallModel.msg.toString());
          }

          //Save intake data
          if (startVideoCallModel.intakeStatus == 1) {
            saveIntakeData(startVideoCallModel.data?.uniqeid.toString(),
                AppConstants.video);
          }
        } else {
          isSuccess(false);

          //Handle error code here
          if (startVideoCallModel.errorCode ==
              AppConstants.insufficientBalance) {
            CommonMethods().showInsufficientBalancedDialog();
          } else {
            CustomSnackBar.showBottom(startVideoCallModel.msg.toString());
          }
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  //Emergency Video Call
  Future<void> startEmergencyVideoCall(String? astrologerUniId) async {
    CustomProgressDialog.showDialog();
    isLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.startEmergencyVideoCall, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'astrologer_uni_id': astrologerUniId,
      });
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        startEmergencyVideoCallModel = ChatSuccessModel.fromJson(response.data);
        if (startEmergencyVideoCallModel.status == AppConstants.success) {
          isSuccess(true);
          Get.back();

          if (startEmergencyVideoCallModel.joinStatus == 0) {
            AppDialog().showCallSuccessDialog(startEmergencyVideoCallModel.msg.toString(), "Queue");
          } else if (startEmergencyVideoCallModel.joinStatus == 1 || startEmergencyVideoCallModel.joinStatus == 2) {
            String? customerUniUd = await SharedPreferencesHelper.getData(AppConstants.userUniId);
            String? agoraAppId = await SharedPreferencesHelper.getData(AppConstants.agoraAppId);
            String channelName = '$customerUniUd-$astrologerUniId-Video';

            AppLogger.d("StartVideoCall Data-> channel:$channelName uniqueId:${startEmergencyVideoCallModel.data?.uniqeid.toString()} agoraAppId:$agoraAppId token:${startEmergencyVideoCallModel.data!.agoraToken.toString()}");
            Get.toNamed('/videoCallScreen', arguments: {
              'channelName': channelName,
              'uniqueId': startEmergencyVideoCallModel.data?.uniqeid.toString(),
              'agoraAppId': agoraAppId,
              'token': startEmergencyVideoCallModel.data!.agoraToken.toString(),
            });
          } else {
            CustomSnackBar.showBottom(startEmergencyVideoCallModel.msg.toString());
          }

          //Save intake data
          if (startEmergencyVideoCallModel.intakeStatus == 1) {
            saveIntakeData(startEmergencyVideoCallModel.data?.uniqeid.toString(), AppConstants.emergencyVideoCall);
          }
        } else {
          isSuccess(false);

          //Handle error code here
          if (startEmergencyVideoCallModel.errorCode == AppConstants.insufficientBalance) {
            CommonMethods().showInsufficientBalancedDialog();
          } else {
            CustomSnackBar.showBottom(startEmergencyVideoCallModel.msg.toString());
          }
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> startAssistantChat(String? astrologerUniId) async {
    CustomProgressDialog.showDialog();
    isLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      AppLogger.d("[ASSISTANT-CHAT] startAssistantChat request=> $apiKey $uniId $astrologerUniId");
      final response = await _dio.post(AppConstants.startAssistantChat, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'astrologer_uni_id': astrologerUniId
      });
      AppLogger.d("[ASSISTANT-CHAT] startAssistantChat response=> ${response.data.toString()}");
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        assistantChatSuccessModel = ChatSuccessModel.fromJson(response.data);
        if (assistantChatSuccessModel.status == AppConstants.success) {
          isSuccess(true);
          String? customerUniUd = await SharedPreferencesHelper.getData(AppConstants.userUniId);
          String channelName = '$customerUniUd-$astrologerUniId';

          Get.toNamed('/assistantChatScreen', arguments: {
            'channelName': channelName,
            'uniqueId': assistantChatSuccessModel.data?.uniqeid.toString()
          });
        } else {
          isSuccess(false);
          Get.dialog(
              CustomOkdialogWidget(
                imagePath: Images.alertDialog,
                title: AppStrings.alert2.tr,
                imageColor: ColorResources.colorPrimary,
                onPressed: () {
                  Get.back();
                },
                description: assistantChatSuccessModel.msg.toString(),
              ),
              barrierDismissible: false
          );
          // CustomDefaultDialog.showOkDialog(
          //     "Alert",
          //     assistantChatSuccessModel.msg.toString(), () {
          //   Get.back();
          // });
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> saveIntakeData(String? uniqueId, String type) async {
    isSaveLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.saveIntakeData, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'uniqeid': uniqueId,
        'name': nameController.text.toString(),
        'gender': selectedGender.value.toString(),
        'dob': birthDateController.text.toString(),
        'tob': birthTimeController.text.toString(),
        'birth_place': birthPlaceController.text.toString(),
        'marital_status': maritalStatusController.text.toString(),
        'occupation': occupationController.text.toString(),
        'topic': concernController.text.toString(),
        'other': concernController.text.toString(),
        'lat': latitude.toString(),
        'long': longitude.toString(),
        'intake_type': type,
        'partner_name': partnerNameController.text.toString(),
        'partner_gender' : partnerSelectedGender.value.toString(),
        'partner_dob' : partnerBirthDateController.text.toString(),
        'partner_tob' : partnerBirthTimeController.text.toString(),
        'partner_birth_place' : partnerBirthPlaceController.text.toString(),
        'partner_lat' : partnerLatitude.toString(),
        'partner_long' : partnerLongitude.toString()
      });
      if (response.statusCode == 200) {
        AppLogger.d('SaveIntakeData ${response.data.toString()}');
        saveSuccessModel = SuccessModel.fromJson(response.data);
        if (saveSuccessModel.status == AppConstants.success) {
          isSaveSuccess(true);
        } else {
          isSaveSuccess(false);
          CustomSnackBar.showBottom(saveSuccessModel.msg.toString());
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isSaveLoading(false);
    }
  }

}
