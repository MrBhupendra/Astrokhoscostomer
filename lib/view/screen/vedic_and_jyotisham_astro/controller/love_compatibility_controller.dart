import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../../splash/controller/config_controller.dart';
import '../model/love_comaptibility_model.dart';


import 'package:astro_brahmand/utill/app_logger.dart';
class LoveCompatibilityController extends GetxController {
  final Dio _dio = Dio();

  final ConfigController configController = Get.find();

  final isLoading = false.obs;
  final isSuccess = false.obs;
  var boySelectedNumber = (-1).obs;
  var girlSelectedNumber = (-1).obs;
  RxBool showButton = true.obs;
  LoveComaptibilityModel loveCompatModel = LoveComaptibilityModel();

  void updateBoySelectedNumber(int selectedIndex) {
    boySelectedNumber.value = selectedIndex;
  }

  void updateGirlSelectedNumber(int selectedIndex) {
    girlSelectedNumber.value = selectedIndex;
  }

  Future<void> getLoveCompat(String girlSelectedIndex, String boySelectedIndex) async {
    isLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        setHeader(jyotishamApiKey.toString());
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getJyotishamAstroLoveCompat}boy_sign=$boySelectedIndex&girl_sign=$girlSelectedIndex&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          loveCompatModel = LoveComaptibilityModel.fromJson(response.data);
          if (loveCompatModel.status == AppConstants.vedicSuccess) {
            isSuccess(true);
          } else {
            isSuccess(false);
          }
        } else {
          isLoading(false);
          AppLogger.d('[KundliController] getAvakhada->OnApiError');
        }
      }else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroLoveCompat}boy_sign=$boySelectedIndex&girl_sign=$girlSelectedIndex&api_key=$vedicApiKey&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          loveCompatModel = LoveComaptibilityModel.fromJson(response.data);
          if (loveCompatModel.status == AppConstants.vedicSuccess) {
            isSuccess(true);
          } else {
            isSuccess(false);
          }
        } else {
          isLoading(false);
          AppLogger.d('[KundliController] getAvakhada->OnApiError');
        }
      }
    }catch (e) {
      isSuccess(false);
      AppLogger.d('[KundliController] getAvakhada->OnException:${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  void setHeader(String jyotishamApiKey) {
    _dio.options.headers = {
      'key': jyotishamApiKey,
    };
  }

}