import 'package:astro_brahmand/model/success_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_snack_bar.dart';
import '../model/question_profile_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class AskQuestionProfileController extends FullLifeCycleController
    with FullLifeCycleMixin {
  String? perQuestionPrice;
  String? userUniId;

  final Dio _dio = Dio();
  final isUpdateLoading = false.obs;
  final isUpdateSuccess = false.obs;
  SuccessModel updateProfileSuccess = SuccessModel();

  final isDeleteLoading = false.obs;
  final isDeleteSuccess = false.obs;
  SuccessModel deleteProfileSuccess = SuccessModel();

  final isProfileLoading = false.obs;
  final isProfileSuccess = false.obs;
  QuestionProfileModel profileModel = QuestionProfileModel();

  RxString selectedGender = ''.obs;
  RxString selectedLanguage = ''.obs;

  //Input
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController birthTimeController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final TextEditingController latitude = TextEditingController();
  final TextEditingController longitude = TextEditingController();

  void setGender(String gender) {
    selectedGender.value = gender;
    AppLogger.d('AS1 ${selectedGender.value}');
  }

  void setLanguage(String language) {
    selectedLanguage.value = language;
    AppLogger.d('AS1 ${selectedLanguage.value}');
  }

  @override
  void onInit() {
    super.onInit();
    perQuestionPrice = Get.arguments["price"];
    userUniId = Get.arguments["uniId"];
  }

  Future<void> getProfile(String profileId) async {
    isProfileLoading(true);
    String? apiKey =
        await SharedPreferencesHelper.getData(AppConstants.userApiKey);
    String? uniId =
        await SharedPreferencesHelper.getData(AppConstants.userUniId);
    AppLogger.d("AS1 Request $apiKey $uniId");
    try {
      final response = await _dio.post(AppConstants.getOpenAiProfile, data: {'api_key': apiKey, "user_uni_id": uniId,"open_ai_profile_id" : profileId});
      AppLogger.d("AS1 Response ${response.data.toString()}");
      if (response.statusCode == 200) {
        profileModel = QuestionProfileModel.fromJson(response.data);

        if (profileModel.status == AppConstants.success) {
          nameController.text = profileModel.data!.name.toString();
          selectedGender.value = profileModel.data!.gender.toString();
          selectedLanguage.value = profileModel.data!.lang.toString();
          birthDateController.text = profileModel.data!.dob.toString();
          birthTimeController.text = profileModel.data!.tob.toString();
          birthPlaceController.text = profileModel.data!.pob.toString();
          latitude.text = profileModel.data!.lat.toString();
          longitude.text = profileModel.data!.lon.toString();
          isProfileSuccess(true);
        } else {
          isProfileSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isProfileSuccess(false);
      AppLogger.d('OnException==> $e');
    } finally {
      isProfileLoading(false);
    }
  }

  Future<void> addProfile(
      String name,
      String birthDate,
      String birthTime,
      String birthPlace,
      String latitude,
      String longitude,
      String gender,
      String language) async {
    isUpdateLoading(true);
    String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
    String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

    try {
      final response = await _dio.post(AppConstants.addOpenAiProfile, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "name": name,
        "dob": birthDate,
        "tob": birthTime,
        "pob": birthPlace,
        "gender": gender,
        "lat": latitude,
        "lon": longitude,
        "lang": language,
        "is_selected" : 0//1 if you want to show selected
      });

      if (response.statusCode == 200) {
        updateProfileSuccess = SuccessModel.fromJson(response.data);
        if (updateProfileSuccess.status == AppConstants.success) {
          isUpdateSuccess(true);
          Get.offNamed('/ask_question_screen_new',arguments: {
            "price": perQuestionPrice,
            "uniId": userUniId,
          });

          CustomSnackBar.showBottom("Profile Added Successfully.");
        } else {
          isUpdateSuccess(false);
          CustomSnackBar.showBottom(updateProfileSuccess.msg.toString());
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> $e');
    } finally {
      isUpdateLoading(false);
    }
  }

  Future<void> updateProfile(
      String id,
      String name,
      String birthDate,
      String birthTime,
      String birthPlace,
      String latitude,
      String longitude,
      String gender,
      String language) async {
    isUpdateLoading(true);
    String? apiKey =
        await SharedPreferencesHelper.getData(AppConstants.userApiKey);
    String? uniId =
        await SharedPreferencesHelper.getData(AppConstants.userUniId);

    try {
      final response = await _dio.post(AppConstants.updateOpenAiProfile, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "open_ai_profile_id" : id,
        "name": name,
        "dob": birthDate,
        "tob": birthTime,
        "pob": birthPlace,
        "gender": gender,
        "lat": latitude,
        "lon": longitude,
        "lang": language
      });

      if (response.statusCode == 200) {
        updateProfileSuccess = SuccessModel.fromJson(response.data);
        if (updateProfileSuccess.status == AppConstants.success) {
          isUpdateSuccess(true);
          Get.offNamed('/ask_question_screen_new',arguments: {
            "price": perQuestionPrice,
            "uniId": userUniId,
          });

          CustomSnackBar.showBottom("Profile Updated Successfully.");
        } else {
          isUpdateSuccess(false);
          CustomSnackBar.showBottom(updateProfileSuccess.msg.toString());
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> $e');
    } finally {
      isUpdateLoading(false);
    }
  }

  Future<void> deleteProfile(String id) async {
    isDeleteLoading(true);
    String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
    String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

    try {
      final response = await _dio.post(AppConstants.deleteOpenAiProfile, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "open_ai_profile_id" : id,
      });

      if (response.statusCode == 200) {
        deleteProfileSuccess = SuccessModel.fromJson(response.data);
        if (deleteProfileSuccess.status == AppConstants.success) {
          isDeleteSuccess(true);
          Get.offNamed('/ask_question_screen_new',arguments: {
            "price": perQuestionPrice,
            "uniId": userUniId,
          });

          CustomSnackBar.showBottom("Profile Deleted Successfully.");
        } else {
          isDeleteSuccess(false);
          CustomSnackBar.showBottom(deleteProfileSuccess.msg.toString());
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> $e');
    } finally {
      isDeleteLoading(false);
    }
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
