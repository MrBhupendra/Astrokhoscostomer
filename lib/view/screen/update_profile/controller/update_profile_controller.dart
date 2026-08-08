import 'dart:io';
import 'package:astro_brahmand/utill/app_events.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show BoolExtension, Get, GetNavigation, GetxController, RxString, StringExtension;
import 'package:dio/dio.dart' show Dio, FormData, MultipartFile;
import 'package:flutter/foundation.dart';
import 'package:astro_brahmand/model/verify_customer_model.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/common_methods.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_snack_bar.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class UpdateProfileController extends GetxController {
  final Dio _dio = Dio();
  final isLoading = false.obs;
  final isSuccess = false.obs;
  RxString selectedGender = ''.obs;
  VerifyCustomerModel updateProfileModel = VerifyCustomerModel();

  //Input
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController birthTimeController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final TextEditingController latitude = TextEditingController();
  final TextEditingController longitude = TextEditingController();
  final TextEditingController timezone = TextEditingController();
  String genderValue = "";
  String profileImage = "";

  final RxString countryCode = '+91'.obs;

  Future<void> initData() async {

    String? name = await SharedPreferencesHelper.getData(AppConstants.name) ?? "";
    String? email = await SharedPreferencesHelper.getData(AppConstants.email) ?? "";
    String? gender = await SharedPreferencesHelper.getData(AppConstants.gender) ?? "";
    String? dob = await SharedPreferencesHelper.getData(AppConstants.birthDate) ?? "";
    String? tob = await SharedPreferencesHelper.getData(AppConstants.birthTime) ?? "";
    String? birthPlace = await SharedPreferencesHelper.getData(AppConstants.birthPlace) ?? "";
    String? lat = await SharedPreferencesHelper.getData(AppConstants.latitude) ?? "";
    String? longi= await SharedPreferencesHelper.getData(AppConstants.longitude) ?? "";
    String? tz= await SharedPreferencesHelper.getData(AppConstants.timeZone) ?? "";
    String? profile =  await SharedPreferencesHelper.getData(AppConstants.profileImage) ?? "";

    nameController.text = name;
    emailController.text = email;
    birthDateController.text = dob;
    birthTimeController.text = tob;
    birthPlaceController.text = birthPlace;
    latitude.text = lat;
    longitude.text = longi;
    timezone.text = tz;
    genderValue = gender;
    profileImage = profile;
    selectedGender.value = gender;
  }

  void setGender(String gender) {
    selectedGender.value = gender;
    AppLogger.d('AS1 ${selectedGender.value}');
  }

  Future<void> updateProfile(
      File? customerImg,
      String name,
      String email,
      String phone,
      String birthDate,
      String birthTime,
      String birthPlace,
      String latitude,
      String longitude,
      String timezone,
      String gender,
      String type
      ) async {
    isLoading(true);
    String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
    String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
    String? phoneCode = await SharedPreferencesHelper.getData(AppConstants.phoneCode);

    AppLogger.d("customerImg-> $customerImg");
    try {
      final Map<String, dynamic> payload = {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "name": name,
        "email": email,
        "phone": phone,
        "birth_date": birthDate,
        "birth_time": birthTime,
        "birth_place": birthPlace,
        "gender": gender,
        "latitude": latitude,
        "longitude": longitude,
        "time_zone": timezone,
      };

      // Only attach customer_img when user picked a new image, otherwise
      // backend treats a null/empty value as "remove existing image".
      if (customerImg != null) {
        payload["customer_img"] = await MultipartFile.fromFile(
          customerImg.path,
          filename: 'profile.png',
        );
      }

      FormData formData = FormData.fromMap(payload);

      AppLogger.d("updateProfile Request-> ${formData.fields}");

      final response = await _dio.post(AppConstants.updateProfileUri, data: formData);

      if (response.statusCode == 200) {
        updateProfileModel = VerifyCustomerModel.fromJson(response.data);

        if (updateProfileModel.status == AppConstants.success) {
          if(type == "Register"){
            await AppEvents().sendSignupEvent("mobile",uniId.toString(),phone.toString());
          }
          await CommonMethods().saveLoginSharedPrefData(updateProfileModel,phoneCode.toString(),true);
          isSuccess(true);
          Get.offAndToNamed('/dashboard');
        } else {
          isSuccess(false);
          CustomSnackBar.showBottom(updateProfileModel.msg.toString());
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateCountryCode(CountryCode code) async {
    countryCode.value = code.dialCode!;
  }

}