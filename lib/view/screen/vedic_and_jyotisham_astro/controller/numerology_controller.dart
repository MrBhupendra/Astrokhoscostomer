import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../../splash/controller/config_controller.dart';
import '../model/numerology_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class NumerologyController extends GetxController {
  final Dio _dio = Dio();

  final ConfigController configController = Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  //Numerology
  final isNumerologyLoading = false.obs;
  final isNumerologySuccess = false.obs;
  NumerologyModel numerologyModel = NumerologyModel();

  Future<void> initData() async {

    String? name = await SharedPreferencesHelper.getData(AppConstants.name) ?? "";
    String? dob = await SharedPreferencesHelper.getData(AppConstants.birthDate) ?? "";

    nameController.text = name;
    dobController.text = dob;
  }

  Future<void> getNumerology(String name, String dob) async {

    isNumerologyLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();
      if (activeKundliApi == AppConstants.jyotisham) {
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        setHeader(jyotishamApiKey.toString());
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getJyotishamAstroNumerology}date=$dob&name=$name&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          numerologyModel = NumerologyModel.fromJson(response.data);
          if (numerologyModel.status == AppConstants.vedicSuccess) {
            isNumerologySuccess(true);
          } else {
            isNumerologySuccess(false);
          }
        } else {
          isNumerologyLoading(false);
          AppLogger.d('[KundliController] getAvakhada->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroNumerology}name=$name&date=$dob&api_key=$vedicApiKey&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          numerologyModel = NumerologyModel.fromJson(response.data);
          if (numerologyModel.status == AppConstants.vedicSuccess) {
            isNumerologySuccess(true);
          } else {
            isNumerologySuccess(false);
          }
        } else {
          isNumerologyLoading(false);
          AppLogger.d('[KundliController] getAvakhada->OnApiError');
        }
      }
    } catch (e) {
      AppLogger.d('[KundliController] getCharts->OnException:${e.toString()}');
    } finally {
      isNumerologyLoading(false);
    }
  }
  void setHeader(String jyotishamApiKey) {
    _dio.options.headers = {
      'key': jyotishamApiKey,
    };
  }

}