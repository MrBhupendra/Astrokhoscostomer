import 'dart:async';

import 'package:flutter/material.dart';
import 'package:astro_brahmand/view/screen/chat/model/chat_success_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../model/success_model.dart';
import '../../../../../utill/app_constants.dart';
import '../../../../../utill/common_methods.dart';
import '../../../../../utill/shared_preference.dart';
import '../../../../widget/custom_progress_dialog.dart';
import '../../../../widget/custom_snack_bar.dart';

class SlotChatIntakeFormController extends GetxController {
  final Dio _dio = Dio();
  final isLoading = false.obs;
  final isSuccess = false.obs;
  ChatSuccessModel chatSuccessModel = ChatSuccessModel();

  //Intake Save
  final isSaveLoading = false.obs;
  final isSaveSuccess = false.obs;
  SuccessModel saveSuccessModel = SuccessModel();

  //Call
  ChatSuccessModel startVoiceCallModel = ChatSuccessModel();

  String? astrologerName = '';
  String? astrologerImage = '';
  String? astrologerUniId = '';
  String? callType = '';
  String? chatId = '';
  String? channelName = '';
  String? endTime = '';

  String? name = '';
  String? dob = '';
  String? tob = '';
  String? birthPlace = '';
  String? latitude = '';
  String? longitude = '';
  String? maritalStatus = '';
  String? occupation = '';
  String? topicOfConcernType = '';
  String? topicOfConcernDetail = '';

  //Init Data
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

  Future<void> initData() async {
    String? name =
        await SharedPreferencesHelper.getData(AppConstants.name) ?? "";
    String? dob =
        await SharedPreferencesHelper.getData(AppConstants.birthDate) ?? "";
    String? tob =
        await SharedPreferencesHelper.getData(AppConstants.birthTime) ?? "";
    String? pob =
        await SharedPreferencesHelper.getData(AppConstants.birthPlace) ?? "";
    String? latitude =
        await SharedPreferencesHelper.getData(AppConstants.latitude) ?? "";
    String? longitude =
        await SharedPreferencesHelper.getData(AppConstants.longitude) ?? "";

    nameController.text = name;
    birthDateController.text = dob;
    birthTimeController.text = tob;
    birthPlaceController.text = pob;
    latitudeController.text = latitude;
    longitudeController.text = longitude;
  }

  void setIntakeData(
      String name_,
      String dob_,
      String tob_,
      String birthPlace_,
      String latitude_,
      String longitude_,
      String maritalStatus_,
      String occupation_,
      String topicOfConcernType_,
      String topicOfConcernDetail_) {
    name = name_;
    dob = dob_;
    tob = tob_;
    birthPlace = birthPlace_;
    latitude = latitude_;
    longitude = longitude_;
    maritalStatus = maritalStatus_;
    occupation = occupation_;
    topicOfConcernType = topicOfConcernType_;
    topicOfConcernDetail = topicOfConcernDetail_;
  }

  void setAstrologerData(String astrologerName_, String astrologerImage_,
      String astrologerUniId_, String callType_, String endTime_) {
    astrologerName = astrologerName_;
    astrologerImage = astrologerImage_;
    astrologerUniId = astrologerUniId_;
    callType = callType_;
    endTime = endTime_;
  }

  Future<void> startChat(String? uniqueId) async {
    CustomProgressDialog.showDialog();
    isLoading(true);
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.architectStartChat, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'uniqeid': uniqueId,
        'start_from': "Customer"
      });

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        chatSuccessModel = ChatSuccessModel.fromJson(response.data);
        if (chatSuccessModel.status == AppConstants.success) {
          isSuccess(true);

         if(chatSuccessModel.joinStatus == 1 || chatSuccessModel.joinStatus == 2){
            String? customerUniUd =
            await SharedPreferencesHelper.getData(AppConstants.userUniId);
            String channelName = '$customerUniUd-$astrologerUniId';
            Get.toNamed('/chat_screen', arguments: {
              'channelName': channelName,
              'uniqueId': chatSuccessModel.data?.uniqeid.toString()
            });
          }else{
            CustomSnackBar.showBottom(chatSuccessModel.msg.toString());
          }

        } else {
          isSuccess(false);
          if(chatSuccessModel.errorCode == AppConstants.insufficientBalance){
            CommonMethods().showInsufficientBalancedDialog();
          }else{
            CustomSnackBar.showBottom(chatSuccessModel.msg.toString());
          }
        }
      } else {
        CustomProgressDialog.dismissDialog();
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isLoading(false);
    }
  }
}
