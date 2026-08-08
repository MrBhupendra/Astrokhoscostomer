import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../../splash/controller/config_controller.dart';
import '../model/horoscope_daily_jyotisham_astro_model.dart';
import '../model/horoscope_daily_vedic_astro_model.dart';
import '../model/horoscope_monthly_jyotisham_astro_model.dart';
import '../model/horoscope_weekly_jyotisham_astro_model.dart';
import '../model/horoscope_weekly_vedic_astro_model.dart';
import '../model/horoscope_yearly_model.dart';
import '../model/horoscope_yearly_vedic_astro_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class HoroscopeController extends GetxController {
  final Dio _dio = Dio();

  final ConfigController configController = Get.find();

  //Daily Horoscope
  final isDailyHoroscopeLoading = false.obs;
  final isDailyHoroscopeSuccess = false.obs;
  HoroscopeDailyJyotishamAstroModel dailyHoroscopeJyotishamAstroModel = HoroscopeDailyJyotishamAstroModel();
  HoroscopeDailyVedicAstroModel horoscopeDailyVedicAstroModel = HoroscopeDailyVedicAstroModel();

  //Weekly Horoscope
  final isWeeklyHoroscopeLoading = false.obs;
  final isWeeklyHoroscopeSuccess = false.obs;
  HoroscopeWeeklyJyotishamAstroModel weeklyHoroscopeJyotishamAstroModel = HoroscopeWeeklyJyotishamAstroModel();
  HoroscopeWeeklyVedicAstroModel horoscopeWeeklyVedicAstroModel = HoroscopeWeeklyVedicAstroModel();

  //Monthly
  final isMonthlyLoading = false.obs;
  final isMonthlySuccess = false.obs;
  HoroscopeMonthlyJyotishamAstroModel horoscopeMonthlyModel = HoroscopeMonthlyJyotishamAstroModel();

  //Yearly
  final isYearlyLoading = false.obs;
  final isYearlySuccess = false.obs;
  HoroscopeYearlyModel horoscopeYearlyModel = HoroscopeYearlyModel();
  HoroscopeYearlyVedicAstroModel horoscopeYearlyVedicAstroModel = HoroscopeYearlyVedicAstroModel();

  //Daily Horoscope
  Future<void> getDailyHoroscope(String zodiac,String day) async {
    isDailyHoroscopeLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroHoroscopeDaily}zodiac=$zodiac&day=$day&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          dailyHoroscopeJyotishamAstroModel = HoroscopeDailyJyotishamAstroModel.fromJson(response.data);
          if (dailyHoroscopeJyotishamAstroModel.status == AppConstants.vedicSuccess) {
            isDailyHoroscopeSuccess(true);
          } else {
            isDailyHoroscopeSuccess(false);
          }
        } else {
          AppLogger.d('[HoroscopeController] getDailyHoroscope->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        var showSame = true;
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroHoroscopeDaily}zodiac=$zodiac&date=$day&show_same=$showSame&lang=$language&api_key=$vedicApiKey');
        if (response.statusCode == AppConstants.vedicSuccess) {
          horoscopeDailyVedicAstroModel = HoroscopeDailyVedicAstroModel.fromJson(response.data);
          if (horoscopeDailyVedicAstroModel.status == AppConstants.vedicSuccess) {
            isDailyHoroscopeSuccess(true);
          } else {
            isDailyHoroscopeSuccess(false);
          }
        } else {
          AppLogger.d('OnApiError');
        }
      }
    } catch (e) {
      isDailyHoroscopeSuccess(false);
      AppLogger.d('[HoroscopeController] getDailyHoroscope->OnException:${e.toString()}');
    } finally {
      isDailyHoroscopeLoading(false);
    }
  }

  //Weekly Horoscope
  Future<void> getWeeklyHoroscope(String zodiac,week) async {
    isWeeklyHoroscopeLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();
      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroHoroscopeWeekly}zodiac=$zodiac&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          weeklyHoroscopeJyotishamAstroModel = HoroscopeWeeklyJyotishamAstroModel.fromJson(response.data);
          if (weeklyHoroscopeJyotishamAstroModel.status == AppConstants.vedicSuccess) {
            isWeeklyHoroscopeSuccess(true);
          } else {
            isWeeklyHoroscopeSuccess(false);
          }
        } else {
          AppLogger.d('[HoroscopeController] getWeeklyHoroscope->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        var showSame = true;
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroHoroscopeWeekly}zodiac=$zodiac&week=$week&show_same=$showSame&lang=$language&api_key=$vedicApiKey');
        if (response.statusCode == AppConstants.vedicSuccess) {
          horoscopeWeeklyVedicAstroModel = HoroscopeWeeklyVedicAstroModel.fromJson(response.data);
          if (horoscopeWeeklyVedicAstroModel.status == AppConstants.vedicSuccess) {
            isWeeklyHoroscopeSuccess(true);
          } else {
            isWeeklyHoroscopeSuccess(false);
          }
        } else {
          AppLogger.d('[HoroscopeController] getWeeklyHoroscope->OnApiError');
        }
      }
    } catch (e) {
      isWeeklyHoroscopeSuccess(false);
      AppLogger.d('[HoroscopeController] getWeeklyHoroscope->OnException:${e.toString()}');
    } finally {
      isWeeklyHoroscopeLoading(false);
    }
  }

  //Jyotisham Monthly Horoscope
  Future<void> getMonthlyHoroscope(String zodiac) async {
    isMonthlyLoading(true);
    try {
      String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
      String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
      setHeader(jyotishamApiKey.toString());
      final response = await _dio.get('${AppConstants.getJyotishamAstroHoroscopeMonthly}zodiac=$zodiac&lang=$language');

      if (response.statusCode == AppConstants.vedicSuccess) {
        horoscopeMonthlyModel = HoroscopeMonthlyJyotishamAstroModel.fromJson(response.data);
        if (horoscopeMonthlyModel.status == AppConstants.vedicSuccess) {
          isMonthlySuccess(true);
        } else {
          isMonthlySuccess(false);
        }
      } else {
        AppLogger.d('[HoroscopeController] getMonthlyHoroscope->OnApiError');
      }
    } catch (e) {
      isMonthlySuccess(false);
      AppLogger.d('[HoroscopeController] getMonthlyHoroscope->OnException:${e.toString()}');
    } finally {
      isMonthlyLoading(false);
    }
  }


  //Yearly
  Future<void> getYearlyHoroscope(String zodiac) async {
    final DateTime selectedDate = DateTime.now();
    final formattedDate = DateFormat('yyyy').format(selectedDate);

    isYearlyLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroHoroscopeYearly}zodiac=$zodiac&year=$formattedDate&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          horoscopeYearlyModel = HoroscopeYearlyModel.fromJson(response.data);
          if (horoscopeYearlyModel.status == AppConstants.vedicSuccess) {
            isYearlySuccess(true);
          } else {
            isYearlySuccess(false);
          }
        } else {
          AppLogger.d('[HoroscopeController] getYearlyHoroscope->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroHoroscopeYearly}year=$formattedDate&zodiac=$zodiac&lang=$language&api_key=$vedicApiKey');
        if (response.statusCode == AppConstants.vedicSuccess) {
          horoscopeYearlyVedicAstroModel = HoroscopeYearlyVedicAstroModel.fromJson(response.data);
          if (horoscopeYearlyVedicAstroModel.status == AppConstants.vedicSuccess) {
            isYearlySuccess(true);
          } else {
            isYearlySuccess(false);
          }
        } else {
          AppLogger.d('[HoroscopeController] getYearlyHoroscope->OnApiError');
        }
      }
    } catch (e) {
      isYearlySuccess(false);
      AppLogger.d('[HoroscopeController] getYearlyHoroscope->OnException:${e.toString()}');
    } finally {
      isYearlyLoading(false);
    }
  }

  void setHeader(String jyotishamApiKey) {
    _dio.options.headers = {
      'key': jyotishamApiKey,
    };
  }
}