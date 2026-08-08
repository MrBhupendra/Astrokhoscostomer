import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../../splash/controller/config_controller.dart';
import '../model/panchang_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class PanchangController extends GetxController {
  final Dio _dio = Dio();

  final ConfigController configController = Get.find();

  //Panchang
  final isPanchangLoading = false.obs;
  final isPanchangSuccess = false.obs;
  PanchangModel panchangModel = PanchangModel();

  // Language selection
  var selectedLanguage = 'en'.obs;

  Future<void> getPanchang({String? latitude, String? longitude, String? date,String? language}) async {
    final DateTime selectedDate = date != null ? DateFormat('yyyy-MM-dd').parse(date) : DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
    final currentTime = DateTime.now();
    final formattedTime = DateFormat.Hm().format(currentTime);

    isPanchangLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        setHeader(jyotishamApiKey.toString());
        language ??= await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        latitude ??= await SharedPreferencesHelper.getData(AppConstants.latitude);
        longitude ??= await SharedPreferencesHelper.getData(AppConstants.longitude);
        String? timezone = await SharedPreferencesHelper.getData(AppConstants.timeZone);
        final response = await _dio.get('${AppConstants.getJyotishamAstroPanchang}date=$formattedDate&time=$formattedTime&latitude=$latitude&longitude=$longitude&lang=$language&tz=${AppConstants.staticTimezone}');
        if (response.statusCode == AppConstants.vedicSuccess) {
          panchangModel = PanchangModel.fromJson(response.data);
          if (panchangModel.status == AppConstants.vedicSuccess) {
            isPanchangSuccess(true);
          } else {
            isPanchangSuccess(false);
          }
        } else {
          AppLogger.d('OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        language ??= await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        latitude ??= await SharedPreferencesHelper.getData(AppConstants.latitude);
        longitude ??= await SharedPreferencesHelper.getData(AppConstants.longitude);
        String? timezone = await SharedPreferencesHelper.getData(AppConstants.timeZone);
        final response = await _dio.get('${AppConstants.getVedicAstroPanchang}&date=$formattedDate&tz=${AppConstants.staticTimezone}&lat=$latitude&lon=$longitude&time=$formattedTime&lang=$language&api_key=$vedicApiKey');
        if (response.statusCode == AppConstants.vedicSuccess) {
          panchangModel = PanchangModel.fromJson(response.data);
          if (panchangModel.status == AppConstants.vedicSuccess) {
            isPanchangSuccess(true);
          } else {
            isPanchangSuccess(false);
          }
        } else {
          AppLogger.d('OnApiError');
        }
      }
    } catch (e) {
      isPanchangSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isPanchangLoading(false);
    }
  }

  void setHeader(String jyotishamApiKey) {
    _dio.options.headers = {
      'key': jyotishamApiKey,
    };
  }

}

