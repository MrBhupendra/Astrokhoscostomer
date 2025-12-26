import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../model/success_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/common_methods.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../splash/controller/config_controller.dart';
import '../model/matching_aggregate_model.dart';
import '../model/matching_ashtakoot_model.dart';
import '../model/matching_dashakoot_model.dart';
import '../model/matching_nakshatra_model.dart';
import '../model/matching_saved_kundli.dart';
import '../model/vedic_data.dart';
import 'kundli_intake_form_controller.dart';

class MatchingController extends GetxController {
  final Dio _dio = Dio();

  final ConfigController configController = Get.find();

  //SaveNewKundli
  SuccessModel saveNewKundli = SuccessModel();

  //SavedKundli
  final isSavedLoading = false.obs;
  final isSavedSuccess = false.obs;
  MatchingSavedKundli savedKundliData = MatchingSavedKundli();
  ScrollController scrollController = ScrollController();
  num offsetCount = 0;
  List<MatchingSavedKundliData> matchingsavedKundliListData = [];
  bool isNoMoreData = false;

  //Update
  SuccessModel updateModel = SuccessModel();

  //Delete
  SuccessModel deleteModel = SuccessModel();

  //Ashtakoot
  final isAsthakootLoading = false.obs;
  final isAsthakootSuccess = false.obs;
  MatchingAshtakootModel asthakootModel = MatchingAshtakootModel();
  KundliMatchData? _currentAsthakootData;

  //Dashakoot
  final isDashakootLoading = false.obs;
  final isDashakootSuccess = false.obs;
  MatchingDashakootModel dashakootModel = MatchingDashakootModel();
  KundliMatchData? _currentDashakootData;

  //Aggregate
  final isAggregateLoading = false.obs;
  final isAggregateSuccess = false.obs;
  MatchingAggregateModel aggregateModel = MatchingAggregateModel();
  KundliMatchData? _currentAggregateData;

  //Nakshatra
  final isNakshatraLoading = false.obs;
  final isNakshatraSuccess = false.obs;
  var boySelectedNumber = (-1).obs;
  var girlSelectedNumber = (-1).obs;
  RxBool showButton = true.obs;
  MatchingNakshatraModel nakshatraModel = MatchingNakshatraModel();
  KundliMatchData? _currentNakshatraData;

  // Reset methods for each tab
  void resetAsthakootState() {
    isAsthakootSuccess(false);
    isAsthakootLoading(false);
    _currentAsthakootData = null;
  }

  void resetDashakootState() {
    isDashakootSuccess(false);
    isDashakootLoading(false);
    _currentDashakootData = null;
  }

  void resetAggregateState() {
    isAggregateSuccess(false);
    isAggregateLoading(false);
    _currentAggregateData = null;
  }

  void resetNakshatraState(KundliMatchData? newData) {
    // Check if data has changed
    if (newData != null && _isDataDifferent(_currentNakshatraData, newData)) {
      isNakshatraSuccess(false);
      isNakshatraLoading(false);
      boySelectedNumber(-1);
      girlSelectedNumber(-1);
      showButton(true);
      _currentNakshatraData = newData;
    }
  }

  void updateBoySelectedNumber(int selectedIndex) {
    boySelectedNumber.value = selectedIndex;
  }

  void updateGirlSelectedNumber(int selectedIndex) {
    girlSelectedNumber.value = selectedIndex;
  }

  //Edit
  late KundliMatchData updateMatchingData;
  String updateId = "";

  final isRefresh = false.obs;

  void setMatchingEditData(KundliMatchData data, String id) {
    updateMatchingData = data;
    updateId = id;
  }

  //Save
  Future<void> saveKundliMatching(String method, String type, KundliMatchData data) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.saveKundli, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "kundali_method": method,
        "kundali_type": type,
        "boy_name": data.boyName,
        "boy_dob": data.boyDob,
        "boy_tob": data.boyTob,
        "boy_lat": data.boyLat,
        "boy_lon": data.boyLong,
        "boy_tz": data.boyTz,
        "boy_place": data.boyPlace,
        "girl_name": data.girlName,
        "girl_dob": data.girlDob,
        "girl_tob": data.girlTob,
        "girl_lat": data.girlLat,
        "girl_lon": data.girlLong,
        "girl_tz": data.girlTz,
        "girl_place": data.girlPlace,
        "language": data.language
      });

      if (response.statusCode == AppConstants.vedicSuccess) {
        CustomProgressDialog.dismissDialog();
        saveNewKundli = SuccessModel.fromJson(response.data);
        if (saveNewKundli.status == AppConstants.success) {
          isRefresh(true);
          KundliIntakeFormController kundliIntakeFormController = Get.put(KundliIntakeFormController(),permanent: true);
          kundliIntakeFormController.setKundliMatchingData(data);
          Get.offNamed('/matchingTabScreen');
        } else {
          CustomSnackBar.showBottom(savedKundliData.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        debugPrint('[MatchingController] saveKundliMatching->OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      debugPrint('[MatchingController] saveKundliMatching->OnException:${e.toString()}');
    }
  }

  //SavedKundli
  Future<void> getSavedKundli(num offset, String method) async {

    if(offset == 0){
      offsetCount = 0;
      isNoMoreData = false;
      matchingsavedKundliListData.clear();
    }
    isSavedLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getSavedKundli, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "for_id": uniId,
        "kundali_method": method,
        "kundali_type": AppConstants.kundliMatching,
        "offset": offset
      });
      isRefresh(false);
      if (response.statusCode == AppConstants.vedicSuccess) {
        savedKundliData = MatchingSavedKundli.fromJson(response.data);
        if(savedKundliData.status == AppConstants.success){
          offsetCount = savedKundliData.offset!;
          isSavedSuccess(true);
          for (var element in (savedKundliData.data ?? [])) {
            matchingsavedKundliListData.add(element);
          }
        }
        else{
          if(offset == 0){
            isSavedSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        debugPrint('[MatchingController] getSavedKundli->OnApiError');
      }
    } catch (e) {
      isSavedSuccess(false);
      debugPrint('[MatchingController] getSavedKundli->OnException:${e.toString()}');
    } finally {
      isSavedLoading(false);
    }
  }

  //UpdateKundli
  Future<void> updateKundliMatching(String id, String method,String type, KundliMatchData data) async   {
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.updateKundli, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'id': id,
        "kundali_method": method,
        "kundali_type": type,
        "boy_name": data.boyName,
        "boy_dob": data.boyDob,
        "boy_tob": data.boyTob,
        "boy_lat": data.boyLat,
        "boy_lon": data.boyLong,
        "boy_tz": data.boyTz,
        "boy_place": data.boyPlace,
        "girl_name": data.girlName,
        "girl_dob": data.girlDob,
        "girl_tob": data.girlTob,
        "girl_lat": data.girlLat,
        "girl_lon": data.girlLong,
        "girl_tz": data.girlTz,
        "girl_place": data.girlPlace,
        "language": data.language
      });

      if (response.statusCode == AppConstants.vedicSuccess) {
        CustomProgressDialog.dismissDialog();
        updateModel = SuccessModel.fromJson(response.data);
        if (updateModel.status == AppConstants.success) {
          isRefresh(true);
          KundliIntakeFormController kundliIntakeFormController = Get.put(KundliIntakeFormController(),permanent: true);
          kundliIntakeFormController.setKundliMatchingData(data);
          Get.offNamed('/matchingTabScreen');
        } else {
          CustomSnackBar.showBottom(updateModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        debugPrint('[KundliController] updateKundli->OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      debugPrint('[KundliController] updateKundli->OnException:${e.toString()}');
    }
  }

  //DeleteKundli
  Future<void> matchingSaveDataDelete(String id, int index) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.deleteKundli, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "id": id
      });
      if (response.statusCode == AppConstants.vedicSuccess) {
        CustomProgressDialog.dismissDialog();
        deleteModel = SuccessModel.fromJson(response.data);
        if (deleteModel.status == AppConstants.success) {
          isRefresh(true);
        } else {
          CustomSnackBar.showBottom(deleteModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        debugPrint('[MatchingController] deleteKundli->OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      debugPrint('[MatchingController] deleteKundli->OnException:${e.toString()}');
    }
  }

  // Helper method to check if data is different
  bool _isDataDifferent(KundliMatchData? currentData, KundliMatchData newData) {
    if (currentData == null) return true;
    return currentData.boyName != newData.boyName ||
        currentData.boyDob != newData.boyDob ||
        currentData.boyTob != newData.boyTob ||
        currentData.girlName != newData.girlName ||
        currentData.girlDob != newData.girlDob ||
        currentData.girlTob != newData.girlTob;
  }

  //Ashtakoot
  Future<void> getAsthakoot(KundliMatchData data) async {
    // Check if data has changed, if yes reset state
    if (_isDataDifferent(_currentAsthakootData, data)) {
      isAsthakootSuccess(false);
      isAsthakootLoading(false);
      _currentAsthakootData = data;
    } else if (isAsthakootSuccess.isTrue) {
      // If same data and already loaded, don't reload
      return;
    }
    
    isAsthakootLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroMatchingAshtakoot}boy_dob=${data.boyDob}&boy_tob=${CommonMethods().convertTimeInputVedic(data.boyTob)}&boy_lat=${data.boyLat}&boy_lon=${data.boyLong}&boy_tz=${data.boyTz}&girl_dob=${data.girlDob}&girl_tob=${CommonMethods().convertTimeInputVedic(data.girlTob)}&girl_lat=${data.girlLat}&girl_lon=${data.girlLong}&girl_tz=${data.girlTz}&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          asthakootModel = MatchingAshtakootModel.fromJson(response.data);
          if (asthakootModel.status == AppConstants.vedicSuccess) {
            isAsthakootSuccess(true);
          } else {
            isAsthakootSuccess(false);
          }
        } else {
          debugPrint('[MatchingController] getAsthakoot->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroMatchingAshtakoot}&boy_dob=${data.boyDob}&boy_tob=${CommonMethods().convertTimeInputVedic(data.boyTob)}&boy_tz=${data.boyTz}&boy_lat=${data.boyLat}&boy_lon=${data.boyLong}&girl_dob=${data.girlDob}4&girl_tob=${CommonMethods().convertTimeInputVedic(data.girlTob)}&girl_tz=${data.girlTz}&girl_lat=${data.girlLat}&girl_lon=${data.girlLong}&lang=$language&api_key=$vedicApiKey');

        if (response.statusCode == AppConstants.vedicSuccess) {
          asthakootModel = MatchingAshtakootModel.fromJson(response.data);
          if (asthakootModel.status == AppConstants.vedicSuccess) {
            isAsthakootSuccess(true);
          } else {
            isAsthakootSuccess(false);
          }
        } else {
          debugPrint('[MatchingController] getAsthakoot->OnApiError');
        }
      }

    } catch (e) {
      isAsthakootSuccess(false);
      debugPrint('[MatchingController] getAsthakoot->OnException:${e.toString()}');
    } finally {
      isAsthakootLoading(false);
    }
  }

  //Dashakoot
  Future<void> getDashakoot(KundliMatchData data) async {
    // Check if data has changed, if yes reset state
    if (_isDataDifferent(_currentDashakootData, data)) {
      isDashakootSuccess(false);
      isDashakootLoading(false);
      _currentDashakootData = data;
    } else if (isDashakootSuccess.isTrue) {
      // If same data and already loaded, don't reload
      return;
    }
    
    isDashakootLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroMatchingDashakoot}boy_dob=${data.boyDob}&boy_tob=${CommonMethods().convertTimeInputVedic(data.boyTob)}&boy_tz=${data.boyTz}&boy_lat=${data.boyLat}&boy_lon=${data.boyLong}&girl_dob=${data.girlDob}&girl_tob=${CommonMethods().convertTimeInputVedic(data.girlTob)}&girl_tz=${data.girlTz}&girl_lat=${data.girlLat}&girl_lon=${data.girlLong}&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          dashakootModel = MatchingDashakootModel.fromJson(response.data);
          if (dashakootModel.status == AppConstants.vedicSuccess) {
            isDashakootSuccess(true);
          } else {
            isDashakootSuccess(false);
          }
        } else {
          debugPrint('[MatchingController] getDashakoot->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroMatchingDashakoot}&boy_dob=${data.boyDob}&boy_tob=${CommonMethods().convertTimeInputVedic(data.boyTob)}&boy_tz=${data.boyTz}&boy_lat=${data.boyLat}&boy_lon=${data.boyLong}&girl_dob=${data.girlDob}4&girl_tob=${CommonMethods().convertTimeInputVedic(data.girlTob)}&girl_tz=${data.girlTz}&girl_lat=${data.girlLat}&girl_lon=${data.girlLong}&lang=$language&api_key=$vedicApiKey');
        if (response.statusCode == AppConstants.vedicSuccess) {
          dashakootModel = MatchingDashakootModel.fromJson(response.data);
          if (dashakootModel.status == AppConstants.vedicSuccess) {
            isDashakootSuccess(true);
          } else {
            isDashakootSuccess(false);
          }
        } else {
          debugPrint('[MatchingController] getDashakoot->OnApiError');
        }
      }
    } catch (e) {
      isDashakootSuccess(false);
      debugPrint(
          '[MatchingController] getDashakoot->OnException:${e.toString()}');
    } finally {
      isDashakootLoading(false);
    }
  }

  //Aggregate
  Future<void> getAggregate(KundliMatchData data) async {
    // Check if data has changed, if yes reset state
    if (_isDataDifferent(_currentAggregateData, data)) {
      isAggregateSuccess(false);
      isAggregateLoading(false);
      _currentAggregateData = data;
    } else if (isAggregateSuccess.isTrue) {
      // If same data and already loaded, don't reload
      return;
    }
    
    isAggregateLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());

        final response = await _dio.get('${AppConstants.getJyotishamAstroMatchingAggregate}boy_dob=${data.boyDob}&boy_tob=${CommonMethods().convertTimeInputVedic(data.boyTob)}&boy_tz=${data.boyTz}&boy_lat=${data.boyLat}&boy_lon=${data.boyLong}&girl_dob=${data.girlDob}&girl_tob=${CommonMethods().convertTimeInputVedic(data.girlTob)}&girl_tz=${data.girlTz}&girl_lat=${data.girlLat}&girl_lon=${data.girlLong}&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          aggregateModel = MatchingAggregateModel.fromJson(response.data);
          if (aggregateModel.status == AppConstants.vedicSuccess) {
            isAggregateSuccess(true);
          } else {
            isAggregateSuccess(false);
          }
        } else {
          debugPrint('[MatchingController] getAggregate->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroMatchingAggregate}&boy_dob=${data.boyDob}&boy_tob=${CommonMethods().convertTimeInputVedic(data.boyTob)}&boy_tz=${data.boyTz}&boy_lat=${data.boyLat}&boy_lon=${data.boyLong}&girl_dob=${data.girlDob}4&girl_tob=${CommonMethods().convertTimeInputVedic(data.girlTob)}&girl_tz=${data.girlTz}&girl_lat=${data.girlLat}&girl_lon=${data.girlLong}&lang=$language&api_key=$vedicApiKey');
        if (response.statusCode == AppConstants.vedicSuccess) {
          aggregateModel = MatchingAggregateModel.fromJson(response.data);
          if (aggregateModel.status == AppConstants.vedicSuccess) {
            isAggregateSuccess(true);
          } else {
            isAggregateSuccess(false);
          }
        } else {
          debugPrint('[MatchingController] getAggregate->OnApiError');
        }
      }
    } catch (e) {
      isAggregateSuccess(false);
      debugPrint(
          '[MatchingController] getAggregate->OnException:${e.toString()}');
    } finally {
      isAggregateLoading(false);
    }
  }

  //Nakshatra
  Future<void> getNakshatra(int girlSelectedIndex, int boySelectedIndex) async {
    isNakshatraLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroMatchingNakshatra}boy_nakshatra=$boySelectedIndex&girl_nakshatra=$girlSelectedIndex&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          nakshatraModel = MatchingNakshatraModel.fromJson(response.data);
          if (nakshatraModel.status == AppConstants.vedicSuccess) {
            isNakshatraSuccess(true);
            showButton.value = true;
          } else {
            isNakshatraSuccess(false);
          }
        } else {
          debugPrint('[MatchingController] getNakshatra->OnApiError');
        }
      }else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroMatchingNakshatra}boy_star=$boySelectedIndex&girl_star=$girlSelectedIndex&api_key=$vedicApiKey&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          nakshatraModel = MatchingNakshatraModel.fromJson(response.data);
          if (nakshatraModel.status == AppConstants.vedicSuccess) {
            isNakshatraSuccess(true);
            showButton.value = true;
          } else {
            isNakshatraSuccess(false);
          }
        } else {
          debugPrint('[MatchingController] getNakshatra->OnApiError');
        }
      }
    } catch (e) {
      isNakshatraSuccess(false);
      debugPrint('[MatchingController] getNakshatra->OnException:${e.toString()}');
    } finally {
      isNakshatraLoading(false);
    }
  }

  void setHeader(String jyotishamApiKey) {
    _dio.options.headers = {
      'key': jyotishamApiKey,
    };
  }

  @override
  void onClose() {
    super.onClose();
    Get.delete<KundliIntakeFormController>();
  }
}
