import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../model/daily_tarot_model.dart';

class DailyTarotController extends GetxController {
  final Dio _dio = Dio();

  final isTarotLoading = false.obs;
  final isTarotSuccess = false.obs;
  DailyTarotModel tarotModel = DailyTarotModel();


  Future<void> getDailyTarot(int tarotNum) async {

    isTarotLoading(true);
    try {
      String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
      setHeader(jyotishamApiKey.toString());
      String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
      final response = await _dio.get('${AppConstants.getTarot}tarot_no=$tarotNum&lang=$language');
      if (response.statusCode == AppConstants.vedicSuccess) {
        tarotModel = DailyTarotModel.fromJson(response.data);
        if (tarotModel.status == AppConstants.vedicSuccess) {
          isTarotSuccess(true);
        } else {
          isTarotSuccess(false);
        }
      } else {
        isTarotLoading(false);
        debugPrint('[KundliController] getAvakhada->OnApiError');
      }
    }catch (e) {
      isTarotSuccess(false);
      debugPrint('[KundliController] getAvakhada->OnException:${e.toString()}');
    } finally {
      isTarotLoading(false);
    }
  }

  void setHeader(String jyotishamApiKey) {
    _dio.options.headers = {
      'key': jyotishamApiKey,
    };
  }

}