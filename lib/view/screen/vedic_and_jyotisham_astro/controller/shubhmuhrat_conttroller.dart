
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../../splash/controller/config_controller.dart';
import '../model/shubhmuhrat_choghadiya_model.dart';
import '../model/shubhmuhrat_hora_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class ShubhmuhratController extends GetxController {
  final Dio _dio = Dio();
  final ConfigController configController = Get.find();

  //Hora
  final isHoraLoading = false.obs;
  final isHoraSuccess = false.obs;
  ShubhmuhratHoraModel horaModel = ShubhmuhratHoraModel();

  //Choghadiya
  final isChoghadiyaLoading = false.obs;
  final isChoghadiyaSuccess = false.obs;
  ShubhmuhratChoghadiyaModel choghadiyaModel = ShubhmuhratChoghadiyaModel();

  Future<void> getChoghadiya() async {
    final DateTime selectedDate = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);

    final currentTime = DateTime.now();
    final formattedTime = DateFormat.Hm().format(currentTime);

    isChoghadiyaLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();
     if(activeKundliApi == AppConstants.jyotisham){
       String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
       setHeader(jyotishamApiKey.toString());
       String? latitude = await SharedPreferencesHelper.getData(AppConstants.latitude);
       String? longitude = await SharedPreferencesHelper.getData(AppConstants.longitude);
       String? timezone = await SharedPreferencesHelper.getData(AppConstants.timeZone);
       String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
       final response = await _dio.get('${AppConstants.getJyotishamAstroShubhMuhratChoghadiya}date=$formattedDate&time=$formattedTime&latitude=$latitude&longitude=$longitude&tz=${AppConstants.staticTimezone}&lang=$language');
       if (response.statusCode == 200) {
         choghadiyaModel = ShubhmuhratChoghadiyaModel.fromJson(response.data);
         if (choghadiyaModel.status == AppConstants.vedicSuccess) {
           isChoghadiyaSuccess(true);
         } else {
           isChoghadiyaSuccess(false);
         }
       } else {
         AppLogger.d('OnApiError');
       }
     } else if(activeKundliApi == AppConstants.vedicastro){
       String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
       String? latitude = await SharedPreferencesHelper.getData(AppConstants.latitude);
       String? longitude = await SharedPreferencesHelper.getData(AppConstants.longitude);
       String? timezone = await SharedPreferencesHelper.getData(AppConstants.timeZone);
       String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
       final response = await _dio.get('${AppConstants.getVedicAstroShubhMuhratChoghadiya}api_key=$vedicApiKey&date=$formattedDate&tz=${AppConstants.staticTimezone}&lat=$latitude&lon=$longitude&time=$formattedTime&lang=$language');
       if (response.statusCode == 200) {
         choghadiyaModel = ShubhmuhratChoghadiyaModel.fromJson(response.data);
         if (choghadiyaModel.status == AppConstants.vedicSuccess) {
           isChoghadiyaSuccess(true);
         } else {
           isChoghadiyaSuccess(false);
         }
       } else {
         AppLogger.d('OnApiError');
       }
     }
    } catch (e) {
      isChoghadiyaSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isChoghadiyaLoading(false);
    }
  }

  Future<void> getHora() async {
    final DateTime selectedDate = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
    final currentTime = DateTime.now();
    final formattedTime = DateFormat.Hm().format(currentTime);
    isHoraLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();
      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        setHeader(jyotishamApiKey.toString());
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        String? latitude = await SharedPreferencesHelper.getData(AppConstants.latitude);
        String? longitude = await SharedPreferencesHelper.getData(AppConstants.longitude);
        String? timezone = await SharedPreferencesHelper.getData(AppConstants.timeZone);
        final response = await _dio.get('${AppConstants.getJyotishamAstroShubhMuhratHora}date=$formattedDate&time=$formattedTime&latitude=$latitude&longitude=$longitude&tz=${AppConstants.staticTimezone}&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          horaModel = ShubhmuhratHoraModel.fromJson(response.data);
          if (horaModel.status == AppConstants.vedicSuccess) {
            isHoraSuccess(true);
          } else {
            isHoraSuccess(false);
          }
        } else {
          AppLogger.d('OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        String? latitude = await SharedPreferencesHelper.getData(AppConstants.latitude);
        String? longitude = await SharedPreferencesHelper.getData(AppConstants.longitude);
        String? timezone = await SharedPreferencesHelper.getData(AppConstants.timeZone);
        final response = await _dio.get('${AppConstants.getVedicAstroShubhMuhratHora}api_key=$vedicApiKey&date=$formattedDate&tz=${AppConstants.staticTimezone}&lat=$latitude&lon=$longitude&time=$formattedTime&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          horaModel = ShubhmuhratHoraModel.fromJson(response.data);
          if (horaModel.status == AppConstants.vedicSuccess) {
            isHoraSuccess(true);
          } else {
            isHoraSuccess(false);
          }
        } else {
          AppLogger.d('OnApiError');
        }
      }
    } catch (e) {
      isHoraSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isHoraLoading(false);
    }


  }

  void setHeader(String jyotishamApiKey) {
    _dio.options.headers = {
      'key': jyotishamApiKey,
    };
  }

}