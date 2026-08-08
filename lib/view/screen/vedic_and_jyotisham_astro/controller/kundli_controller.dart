import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xml/xml.dart' as xml;
import '../../../../model/success_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/common_methods.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../splash/controller/config_controller.dart';
import '../model/kundli_ascendants_model.dart';
import '../model/kundli_ashtakvarga_model.dart';
import '../model/kundli_basics_avkhada_model.dart';
import '../model/kundli_currentmaha_dashafull_model.dart';
import '../model/kundli_friend_model.dart';
import '../model/kundli_gemsuggestions_model.dart';
import '../model/kundli_kaalsarpDosh_model.dart';
import '../model/kundli_kp_model.dart';
import '../model/kundli_mahadasha_full_model.dart';
import '../model/kundli_mahadasha_model.dart';
import '../model/kundli_mangalDosh_model.dart';
import '../model/kundli_manglik_model.dart';
import '../model/kundli_pitraDosh_model.dart';
import '../model/kundli_planets_model.dart';
import '../model/kundli_rudraksha_Suggestions_model.dart';
import '../model/kundli_rudraksha_suggestions_vedic_astro_model.dart';
import '../model/kundli_save_data_model.dart';
import '../model/vedic_data.dart';
import 'kundli_intake_form_controller.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class KundliController extends GetxController {
  final Dio _dio = Dio();

  final ConfigController configController = Get.find();

  //SaveNewKundli
  SuccessModel saveNewKundli = SuccessModel();

  //SavedKundliData
  final isSavedLoading = false.obs;
  final isSavedSuccess = false.obs;
  KundliSaveDataModel savedataModel = KundliSaveDataModel();
  ScrollController scrollController = ScrollController();
  num offsetCount = 0;
  List<KundliSavedData> savedKundliListData = [];
  bool isNoMoreData = false;

  //Update
  SuccessModel updateModel = SuccessModel();

  //Delete
  SuccessModel deleteModel = SuccessModel();

  //Charts
  RxInt chartChannelSelectedIndex = 0.obs;
  RxInt chartSelectedIndex = 0.obs;
  final isChartLoading = false.obs;
  final isChartSuccess = false.obs;
  final RxString chartSvg = ''.obs;

  //BasicsAva
  final isBasicsDetailsLoading = false.obs;
  final isBasicsDetailsSuccess = false.obs;
  KundliBasicsAvakhadaModel basicsDetailsModel = KundliBasicsAvakhadaModel();


  //Planetas
  final isPlanetasLoading = false.obs;
  final isPlanetasSuccess = false.obs;
  KundliPlanetsModel planetasModel = KundliPlanetsModel();

  //CurrentMahadasha
  final isDashaLoading = false.obs;
  final isDashaSuccess = false.obs;
  KundliMahadashaModel mahadashaModel = KundliMahadashaModel();

  //SpecificDasha
  RxString dashaSelectedType = 'Current Mahadasha'.obs;
  final RxBool isMahaDashaLoading = false.obs;

  KundliMahadashaFullModel dashaMahadasha = KundliMahadashaFullModel();
  final RxBool mahadashaSuccess = false.obs;

  CurrentDashaAntardasha dashaAntardasha = CurrentDashaAntardasha();
  final RxBool antardashaSuccess = false.obs;

  CurrentDashaParyantardasha dashaParyantardasha = CurrentDashaParyantardasha();
  final RxBool paryantardashaSuccess = false.obs;

  CurrentDashaShookshamadasha dashaShookshamadasha = CurrentDashaShookshamadasha();
  final RxBool shookshamadashaSuccess = false.obs;

  CurrentDashaPranadasha dashaPranadasha = CurrentDashaPranadasha();
  final RxBool pranadashaSuccess = false.obs;

  //CurrentMahaDashaFull
  final isCurrentMahaDashaFullLoading = false.obs;
  final isCurrentMahaDashaFullSuccess = false.obs;
  KundliCurrentmahaDashafullModel mahadashafullModel = KundliCurrentmahaDashafullModel();

  //friendship
  final isFriendshipLoading = false.obs;
  final isFriendshipSuccess = false.obs;
  KundliFriendModel friendshipModel = KundliFriendModel();

  //Ashtakvarga
  final isAshtakvargaLoading = false.obs;
  final isAshtakvargaSuccess = false.obs;
  KundliAshtakvargaModel ashtakvargaModel = KundliAshtakvargaModel();

  //Ascendants
  final isAscendantsLoading = false.obs;
  final isAscendantsSuccess = false.obs;
  KundliAscendantsModel ascendantsModel = KundliAscendantsModel();

  //Mangal Dosh
  final isMangalDoshLoading = false.obs;
  final isMangalDoshSuccess = false.obs;
  KundliMangalDoshModel mangalDoshModel = KundliMangalDoshModel();

  //Kaalsarp Dosh
  final isKaalsarpDoshLoading = false.obs;
  final isKaalsarpDoshSuccess = false.obs;
  KundliKaalsarpDoshModel kaalsarpDoshModel = KundliKaalsarpDoshModel();

  //Manglik Dosh
  final isManglikDoshLoading = false.obs;
  final isManglikDoshSuccess = false.obs;
  KundliManglikModel manglikModel = KundliManglikModel();

  //Pitra Dosh
  final isPitraDoshLoading = false.obs;
  final isPitraDoshSuccess = false.obs;
  KundliPitraDoshModel pitraDoshModel = KundliPitraDoshModel();

  //KpChart
  final isKpChartLoading = false.obs;
  final isKpChartSuccess = false.obs;

  //KpPlanet
  final isKpPlanetLoading = false.obs;
  final isKpPlanetSuccess = false.obs;
  KundliKpModel  kundliKpModel = KundliKpModel();

  //RudrakshaSuggestion
  final isRudrakshaSuggestionsLoading = false.obs;
  final isRudrakshaSuggestionsSuccess = false.obs;
  KundliRudrakshaSuggestionsModel rudrakshaSuggestionsModel = KundliRudrakshaSuggestionsModel();
  KundliRudrakshaSuggestionsVedicAstroModel kundliRudrakshaSuggestionsVedicAstroModel = KundliRudrakshaSuggestionsVedicAstroModel();


  //GemSuggestion
  final isGemSuggestionsLoading = false.obs;
  final isGemSuggestionsSuccess = false.obs;
  KundliGemsuggestionsModel gemSuggestionsModel = KundliGemsuggestionsModel();

  //Edit
  late KundliData updateKundliData;
  String updateId = "";

  final isRefresh = false.obs;

  void setKundliEditData(KundliData data, String id) {
    updateKundliData = data;
    updateId = id;
  }

  //Save
  Future<void> saveKundli(String method, String type, KundliData data) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.saveKundli, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "kundali_method": method,
        "kundali_type": type,
        "name": data.name,
        "dob": data.dob,
        "tob": data.tob,
        "lat": data.latitude,
        "lon": data.longitude,
        "timezone": data.timeZone,
        "place": data.place,
        "language": data.language
      });
      if (response.statusCode == AppConstants.vedicSuccess) {
        CustomProgressDialog.dismissDialog();
        saveNewKundli = SuccessModel.fromJson(response.data);
        if (saveNewKundli.status == AppConstants.success) {
          isRefresh(true);
          KundliIntakeFormController kundliIntakeFormController = Get.put(KundliIntakeFormController(),permanent: true);
          kundliIntakeFormController.setKundliData(data);
          Get.offNamed('/kundliTabScreen');
        } else {
          CustomSnackBar.showBottom(saveNewKundli.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('[KundliController] saveKundli->OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('[KundliController] saveKundli->OnException:${e.toString()}');
    }
  }

  //SavedKundli
  Future<void> getSavedKundli(num offset, String method) async {
    if (offset == 0) {
      offsetCount = 0;
      isNoMoreData = false;
      savedKundliListData.clear();
    }

    isSavedLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getSavedKundli, data: {
        "api_key": apiKey,
        "user_uni_id": uniId,
        "offset": offset,
        "for_id": uniId,
        "kundali_method": method,
        "kundali_type": AppConstants.kundli
      });
      isRefresh(false);
      if (response.statusCode == AppConstants.vedicSuccess) {
        savedataModel = KundliSaveDataModel.fromJson(response.data);
        if (savedataModel.status == AppConstants.success) {
          offsetCount = savedataModel.offset!;
          isSavedSuccess(true);
          for (var element in (savedataModel.data ?? [])) {
            savedKundliListData.add(element);
          }
        } else {
          if (offset == 0) {
            isSavedSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        AppLogger.d('[KundliController] getSavedKundli->OnApiError');
      }
    } catch (e) {
      isSavedSuccess(false);
      AppLogger.d('[KundliController] getSavedKundli->OnException:${e.toString()}');
    } finally {
      isSavedLoading(false);
    }
  }

  //UpdateKundli
  Future<void> updateKundli(String id, String method,String type, KundliData data) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.updateKundli, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "id": id,
        "kundali_method": method,
        "kundali_type": type,
        "name": data.name,
        "dob": data.dob,
        "tob": data.tob,
        "lat": data.latitude,
        "lon": data.longitude,
        "timezone": data.timeZone,
        "place": data.place,
        "language": data.language
      });

      if (response.statusCode == AppConstants.vedicSuccess) {
        CustomProgressDialog.dismissDialog();
        updateModel = SuccessModel.fromJson(response.data);
        if (updateModel.status == AppConstants.success) {
          isRefresh(true);
          KundliIntakeFormController kundliIntakeFormController = Get.put(KundliIntakeFormController(),permanent: true);
          kundliIntakeFormController.setKundliData(data);
          Get.offNamed('/kundliTabScreen');
        } else {
          CustomSnackBar.showBottom(updateModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('[KundliController] updateKundli->OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('[KundliController] updateKundli->OnException:${e.toString()}');
    }
  }

  //DeleteKundli
  Future<void> deleteKundli(String id, int index) async {
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
        AppLogger.d('[KundliController] deleteKundli->OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('[KundliController] deleteKundli->OnException:${e.toString()}');
    }
  }

  //Charts
  Future<void> getCharts(String type, KundliData data, String style) async {
    AppLogger.d("getCharts->$type, $style");
    isChartLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();
      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        setHeader(jyotishamApiKey.toString());
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getJyotishamAstroKundliChart}$type?date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&style=$style&lang=$language&colored_planets=false&color=%230b0932');
        if (response.statusCode == AppConstants.vedicSuccess) {
          var decodedData = xml.XmlDocument.parse(response.data);
          isChartSuccess(true);
          chartSvg.value = decodedData.toString(); // Update the value of chartSvg
        } else {
          AppLogger.d('[KundliController] getCharts->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroKundliChart}dob=${data.dob}&tob=${CommonMethods().convertTimeInputVedic(data.tob)}&lat=${data.latitude}&lon=${data.longitude}&tz=${data.timeZone}&div=$type&color=%23ff3366&style=$style&api_key=$vedicApiKey&lang=$language&font_size=12&font_style=roboto&colorful_planets=0&size=300&stroke=2&format=utf8');
        if (response.statusCode == AppConstants.vedicSuccess) {
          var decodedData = xml.XmlDocument.parse(response.data);
          isChartSuccess(true);
          chartSvg.value = decodedData.toString(); // Update the value of chartSvg
        } else {
          AppLogger.d('[KundliController] getCharts->OnApiError');
        }
      }
    } catch (e) {
      AppLogger.d('[KundliController] getCharts->OnException:${e.toString()}');
    } finally {
      isChartLoading(false);
    }
  }

  // Transit Chart
  Future<void> getTransitChart(String type, KundliData data, String style) async {
    AppLogger.d("getTransitChart->$type, $style");

    isChartLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();
      final now = DateTime.now();
      final formattedDate = DateFormat('dd/MM/yyyy').format(now);
      final formattedTime = DateFormat.Hm().format(now);

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        setHeader(jyotishamApiKey.toString());
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getJyotishamAstroKundliChart}$type?date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&style=$style&lang=$language&transit_time=$formattedTime&transit_date=$formattedDate');
        if (response.statusCode == AppConstants.vedicSuccess) {
          var decodedData = xml.XmlDocument.parse(response.data);
          isChartSuccess(true);
          chartSvg.value = decodedData.toString(); // Update the value of chartSvg
        } else {
          AppLogger.d('[KundliController] getCharts->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroKundliChart}dob=${data.dob}&tob=${CommonMethods().convertTimeInputVedic(data.tob)}&lat=${data.latitude}&lon=${data.longitude}&tz=${data.timeZone}&div=$type&color=%23ff3366&style=$style&api_key=$vedicApiKey&lang=$language&font_size=12&font_style=roboto&colorful_planets=0&size=300&stroke=2&format=utf8');
        if (response.statusCode == AppConstants.vedicSuccess) {
          var decodedData = xml.XmlDocument.parse(response.data);
          isChartSuccess(true);
          chartSvg.value = decodedData.toString(); // Update the value of chartSvg
        } else {
          AppLogger.d('[KundliController] getCharts->OnApiError');
        }
      }
    } catch (e) {
      AppLogger.d('[KundliController] getCharts->OnException:${e.toString()}');
    } finally {
      isChartLoading(false);
    }
  }

  //Basics
  Future<void> getAvakhada(KundliData data) async {
    isBasicsDetailsLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();
      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroKundliBasicsDetails}date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          basicsDetailsModel = KundliBasicsAvakhadaModel.fromJson(response.data);
          if (basicsDetailsModel.status == AppConstants.vedicSuccess) {
            isBasicsDetailsSuccess(true);
          } else {
            isBasicsDetailsSuccess(false);
          }
        } else {
          isBasicsDetailsLoading(false);
          AppLogger.d('[KundliController] getAvakhada->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroKundliBasicsDetails}dob=${data.dob}&tob=${CommonMethods().convertTimeInputVedic(data.tob)}&lat=${data.latitude}&lon=${data.longitude}&tz=${data.timeZone}&api_key=$vedicApiKey&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          basicsDetailsModel = KundliBasicsAvakhadaModel.fromJson(response.data);
          if (basicsDetailsModel.status == AppConstants.vedicSuccess) {
            isBasicsDetailsSuccess(true);
          } else {
            isBasicsDetailsSuccess(false);
          }
        } else {
          isBasicsDetailsLoading(false);
          AppLogger.d('[KundliController] getAvakhada->OnApiError');
        }
      }
    }
    catch (e) {
      isBasicsDetailsSuccess(false);
      AppLogger.d('[KundliController] getAvakhada->OnException:${e.toString()}');
    } finally {
      isBasicsDetailsLoading(false);
    }
  }


  //Planetas
  Future<void> getPlanets(KundliData data) async {
    isPlanetasLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();
      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroKundliplanets}date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          planetasModel = KundliPlanetsModel.fromJson(response.data);
          if (planetasModel.status == AppConstants.vedicSuccess) {
            isPlanetasSuccess(true);
          } else {
            isPlanetasSuccess(false);
          }
        } else {
          AppLogger.d('[KundliController] getPlanets->OnApiError');
        }
      }else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroKundliplanets}dob=${data.dob}&tob=${CommonMethods().convertTimeInputVedic(data.tob)}&lat=${data.latitude}&lon=${data.longitude}&tz=${data.timeZone}&api_key=$vedicApiKey&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          planetasModel = KundliPlanetsModel.fromJson(response.data);
          if (planetasModel.status == AppConstants.vedicSuccess) {
            isPlanetasSuccess(true);
          } else {
            isPlanetasSuccess(false);
          }
        } else {
          AppLogger.d('[KundliController] getPlanets->OnApiError');
        }
      }
    } catch (e) {
      isPlanetasSuccess(false);
      AppLogger.d('[KundliController] getPlanets->OnException:${e.toString()}');
    } finally {
      isPlanetasLoading(false);
    }
  }

  //CurrentMahadasha
  Future<void> getMahaDasha(KundliData data) async {
    isDashaLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroKundliMahadasha}date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          mahadashaModel = KundliMahadashaModel.fromJson(response.data);
          if (mahadashaModel.status == AppConstants.vedicSuccess) {
            isDashaSuccess(true);
          } else {
            isDashaSuccess(false);
          }
        } else {
          AppLogger.d('[KundliController] getMahaDasha->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroKundliMahadasha}dob=${data.dob}&tob=${CommonMethods().convertTimeInputVedic(data.tob)}&lat=${data.latitude}&lon=${data.longitude}&tz=${data.timeZone}&api_key=$vedicApiKey&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          mahadashaModel = KundliMahadashaModel.fromJson(response.data);
          if (mahadashaModel.status == AppConstants.vedicSuccess) {
            isDashaSuccess(true);
          } else {
            isDashaSuccess(false);
          }
        } else {
          AppLogger.d('[KundliController] getMahaDasha->OnApiError');
        }
      }

    } catch (e) {
      isDashaSuccess(false);
      AppLogger.d('[KundliController] getMahaDasha->OnException:${e.toString()}');
    } finally {
      isDashaLoading(false);
    }
  }

  //SpecificDasha
  Future<void> getSpecificDasha(KundliData data, String? md, String? ad, String? pd, String? sd, String type) async {
    isMahaDashaLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroKundliSpecificDasha}date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&md=$md&ad=$ad&pd=$pd&sd=$sd&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          if (type == "mahadasha") {
            dashaMahadasha = KundliMahadashaFullModel.fromJson(response.data);
            if (dashaMahadasha.status == AppConstants.vedicSuccess) {
              mahadashaSuccess(true);
            }
          }
          if (type == "antardasha") {
            dashaAntardasha = CurrentDashaAntardasha.fromJson(response.data);
            if (dashaAntardasha.status == AppConstants.vedicSuccess) {
              mahadashaSuccess(false);
              antardashaSuccess(true);
            }
          }
          if (type == "paryatnadasha") {
            dashaParyantardasha =
                CurrentDashaParyantardasha.fromJson(response.data);
            if (dashaParyantardasha.status == AppConstants.vedicSuccess) {
              antardashaSuccess(false);
              paryantardashaSuccess(true);
            }
          }
          if (type == "shookshamadasha") {
            dashaShookshamadasha =
                CurrentDashaShookshamadasha.fromJson(response.data);
            if (dashaShookshamadasha.status == AppConstants.vedicSuccess) {
              paryantardashaSuccess(false);
              shookshamadashaSuccess(true);
            }
          }
          if (type == "pranadasha") {
            dashaPranadasha = CurrentDashaPranadasha.fromJson(response.data);
            if (dashaPranadasha.status == AppConstants.vedicSuccess) {
              shookshamadashaSuccess(false);
              pranadashaSuccess(true);
            }
          }
        }
        else {
          AppLogger.d('[KundliController] getSpecificDasha->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroKundliSpecificDasha}dob=${data.dob}&tob=${CommonMethods().convertTimeInputVedic(data.tob)}&lat=${data.latitude}&lon=${data.longitude}&tz=${data.timeZone}&api_key=$vedicApiKey&md=$md&ad=$ad&pd=$pd&sd=$sd&lang=$language');

        if (response.statusCode == AppConstants.vedicSuccess) {
          if (type == "mahadasha") {
            dashaMahadasha = KundliMahadashaFullModel.fromJson(response.data);
            if (dashaMahadasha.status == AppConstants.vedicSuccess) {
              mahadashaSuccess(true);
            }
          }
          if (type == "antardasha") {
            dashaAntardasha = CurrentDashaAntardasha.fromJson(response.data);
            if (dashaAntardasha.status == AppConstants.vedicSuccess) {
              mahadashaSuccess(false);
              antardashaSuccess(true);
            }
          }
          if (type == "paryatnadasha") {
            dashaParyantardasha =
                CurrentDashaParyantardasha.fromJson(response.data);
            if (dashaParyantardasha.status == AppConstants.vedicSuccess) {
              antardashaSuccess(false);
              paryantardashaSuccess(true);
            }
          }
          if (type == "shookshamadasha") {
            dashaShookshamadasha =
                CurrentDashaShookshamadasha.fromJson(response.data);
            if (dashaShookshamadasha.status == AppConstants.vedicSuccess) {
              paryantardashaSuccess(false);
              shookshamadashaSuccess(true);
            }
          }
          if (type == "pranadasha") {
            dashaPranadasha = CurrentDashaPranadasha.fromJson(response.data);
            if (dashaPranadasha.status == AppConstants.vedicSuccess) {
              shookshamadashaSuccess(false);
              pranadashaSuccess(true);
            }
          }
        }
        else {
          AppLogger.d('[KundliController] getSpecificDasha->OnApiError');
        }
      }
    } catch (e) {
      AppLogger.d('[KundliController] getSpecificDasha->OnException:${e.toString()}');
    } finally {
      isMahaDashaLoading(false);
    }
  }

  //CurrentMahaDashaFull
  Future<void> getCurrentMahaDashaFull(KundliData data) async {
    isCurrentMahaDashaFullLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroKundliMahaDashaFull}date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          mahadashafullModel = KundliCurrentmahaDashafullModel.fromJson(response.data);
          if (mahadashafullModel.status == AppConstants.vedicSuccess) {
            isCurrentMahaDashaFullSuccess(true);
          } else {
            isCurrentMahaDashaFullSuccess(false);
          }
        } else {
          AppLogger.d('[KundliController] getCurrentMahaDashaFull->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroKundliMahadashaFull}dob=${data.dob}&tob=${CommonMethods().convertTimeInputVedic(data.tob)}&lat=${data.latitude}&lon=${data.longitude}&tz=${data.timeZone}&api_key=$vedicApiKey&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          mahadashafullModel = KundliCurrentmahaDashafullModel.fromJson(response.data);
          if (mahadashafullModel.status == AppConstants.vedicSuccess) {
            isCurrentMahaDashaFullSuccess(true);
          } else {
            isCurrentMahaDashaFullSuccess(false);
          }
        } else {
          AppLogger.d('[KundliController] getCurrentMahaDashaFull->OnApiError');
        }
      }
    } catch (e) {
      isCurrentMahaDashaFullSuccess(false);
      AppLogger.d('[KundliController] getCurrentMahaDashaFull->OnException:${e.toString()}');
    } finally {
      isCurrentMahaDashaFullLoading(false);
    }
  }


  //friendship
  Future<void> getFriendship(KundliData data) async {
    isFriendshipLoading(true);
    try {
      String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
      String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
      setHeader(jyotishamApiKey.toString());
      final response = await _dio.get('${AppConstants.getJyotishamAstroFriendShip}date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&lang=$language');

      if (response.statusCode == AppConstants.vedicSuccess) {
        friendshipModel = KundliFriendModel.fromJson(response.data);
        if (friendshipModel.status == AppConstants.vedicSuccess) {
          isFriendshipSuccess(true);
        } else {
          isFriendshipSuccess(false);
        }
      } else {
        isFriendshipLoading(false);
        AppLogger.d('[KundliController] getAvakhada->OnApiError');
      }
    }
    catch (e) {
      isFriendshipSuccess(false);
      AppLogger.d('[KundliController] getAvakhada->OnException:${e.toString()}');
    } finally {
      isFriendshipLoading(false);
    }
  }

  //Ashtakvarga
  Future<void> getAshtakvarga(KundliData data) async {

    isAshtakvargaLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroKundliAshtakvarga}date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          ashtakvargaModel = KundliAshtakvargaModel.fromJson(response.data);
          if (ashtakvargaModel.status == AppConstants.vedicSuccess) {
            isAshtakvargaSuccess(true);
          } else {
            isAshtakvargaSuccess(false);
          }
        } else {
          AppLogger.d('OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroKundliAshtakvarga}dob=${data.dob}&tob=${CommonMethods().convertTimeInputVedic(data.tob)}&lat=${data.latitude}&lon=${data.longitude}&tz=${data.timeZone}&api_key=$vedicApiKey&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          ashtakvargaModel = KundliAshtakvargaModel.fromJson(response.data);
          if (ashtakvargaModel.status == AppConstants.vedicSuccess) {
            isAshtakvargaSuccess(true);
          } else {
            isAshtakvargaSuccess(false);
          }
        } else {
          AppLogger.d('OnApiError');
        }
      }
    } catch (e) {
      isAshtakvargaSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isAshtakvargaLoading(false);
    }
  }

  //Ascendants
  Future<void> getAscendants(KundliData data) async {
    isAscendantsLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroKundliAscendant}date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&lang=$language');

        if (response.statusCode == AppConstants.vedicSuccess) {
          ascendantsModel = KundliAscendantsModel.fromJson(response.data);
          if (ascendantsModel.status == AppConstants.vedicSuccess) {
            isAscendantsSuccess(true);
          } else {
            isAscendantsSuccess(false);
          }
        } else {
          AppLogger.d('[HoroscopeController] getAscendants->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroKundliAscendant}dob=${data.dob}&tob=${CommonMethods().convertTimeInputVedic(data.tob)}&lat=${data.latitude}&lon=${data.longitude}&tz=${data.timeZone}&api_key=$vedicApiKey&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          ascendantsModel = KundliAscendantsModel.fromJson(response.data);
          if (ascendantsModel.status == AppConstants.vedicSuccess) {
            isAscendantsSuccess(true);
          } else {
            isAscendantsSuccess(false);
          }
        } else {
          AppLogger.d('[HoroscopeController] getAscendants->OnApiError');
        }
      }
    } catch (e) {
      isAscendantsSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isAscendantsLoading(false);
    }
  }

  //KpCharts
  Future<void> getKPCharts(KundliData data, String style) async {
    isKpChartLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroKundliChart}bhav_chalit_chart?date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&style=$style&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          var decodedData = xml.XmlDocument.parse(response.data);
          isKpChartSuccess(true);
          chartSvg.value = decodedData.toString(); // Update the value of chartSvg
        } else {
          AppLogger.d('[KundliController] getKPCharts->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroKundliChart}dob=${data.dob}&tob=${CommonMethods().convertTimeInputVedic(data.tob)}&lat=${data.latitude}&lon=${data.longitude}&tz=${data.timeZone}&div=chalit&color=%23ff3366&style=north&api_key=$vedicApiKey&lang=$language&font_size=12&font_style=roboto&colorful_planets=0&size=300&stroke=2&format=utf8');
        if (response.statusCode == AppConstants.vedicSuccess) {
          var decodedData = xml.XmlDocument.parse(response.data);
          isKpChartSuccess(true);
          chartSvg.value = decodedData.toString();  // Update the value of chartSvg
        } else {
          AppLogger.d('[KundliController] getKPCharts->OnApiError');
        }
      }

    } catch (e) {
      AppLogger.d('[KundliController] getKPCharts->OnException:${e.toString()}');
    } finally {
      isKpChartLoading(false);
    }
  }

  //KpPlanet
  Future<void> getKP(KundliData data) async {
    isKpPlanetLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroKundliKp}dob=${data.dob}&tob=${CommonMethods().convertTimeInputVedic(data.tob)}&lat=${data.latitude}&lon=${data.longitude}&tz=${data.timeZone}&api_key=$vedicApiKey&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          kundliKpModel = KundliKpModel.fromJson(response.data);
          if (kundliKpModel.status == AppConstants.vedicSuccess) {
            isKpPlanetSuccess(true);
          } else {
            isKpPlanetSuccess(false);
          }
        } else {
          AppLogger.d('[HoroscopeController] getAscendants->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        setHeader(jyotishamApiKey.toString());
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getJyotishamAstroKundliKp}date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          kundliKpModel = KundliKpModel.fromJson(response.data);
          if (kundliKpModel.status == AppConstants.vedicSuccess) {
            isKpPlanetSuccess(true);
          } else {
            isKpPlanetSuccess(false);
          }
        } else {
          AppLogger.d('[HoroscopeController] getAscendants->OnApiError');
        }
      }
    } catch (e) {
      AppLogger.d('[KundliController] getKPCharts->OnException:${e.toString()}');
    } finally {
      isKpPlanetLoading(false);
    }
  }


  //Mangal Dosh
  Future<void> getMangalDosh(KundliData data) async {
    isMangalDoshLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroKundliMangalDosh}date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          mangalDoshModel = KundliMangalDoshModel.fromJson(response.data);
          if (mangalDoshModel.status == AppConstants.vedicSuccess) {
            isMangalDoshSuccess(true);
          } else {
            isMangalDoshSuccess(false);
          }
        } else {
          isMangalDoshSuccess(false);
          AppLogger.d('[KundliController] getMangalDosh->OnApiError');
        }
      }else if (activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroKundliMangalDosh}dob=${data.dob}&tob=${CommonMethods().convertTimeInputVedic(data.tob)}&lat=${data.latitude}&lon=${data.longitude}&tz=${data.timeZone}&api_key=$vedicApiKey&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          mangalDoshModel = KundliMangalDoshModel.fromJson(response.data);
          if (mangalDoshModel.status == AppConstants.vedicSuccess) {
            isMangalDoshSuccess(true);
          } else {
            isMangalDoshSuccess(false);
          }
        } else {
          isMangalDoshSuccess(false);
          AppLogger.d('[KundliController] getMangalDosh->OnApiError');
        }
      }
    } catch (e) {
      isMangalDoshSuccess(false);
      AppLogger.d('[KundliController] getMangalDosh->OnException:${e.toString()}');
    } finally {
      isMangalDoshLoading(false);
    }
  }

  // Kaalsarp Dosh
  Future<void> getKaalsarpDosh(KundliData data) async {
    isKaalsarpDoshLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroKundliKaalsarpDosh}date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          kaalsarpDoshModel = KundliKaalsarpDoshModel.fromJson(response.data);
          if (kaalsarpDoshModel.status == AppConstants.vedicSuccess) {
            isKaalsarpDoshSuccess(true);
          } else {
            isKaalsarpDoshSuccess(false);
          }
        } else {
          isKaalsarpDoshSuccess(false);
          AppLogger.d('[KundliController] getKaalsarpDosh->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroKundliKaalsarpDosh}dob=${data.dob}&tob=${CommonMethods().convertTimeInputVedic(data.tob)}&lat=${data.latitude}&lon=${data.longitude}&tz=${data.timeZone}&api_key=$vedicApiKey&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          kaalsarpDoshModel = KundliKaalsarpDoshModel.fromJson(response.data);
          if (kaalsarpDoshModel.status == AppConstants.vedicSuccess) {
            isKaalsarpDoshSuccess(true);
          } else {
            isKaalsarpDoshSuccess(false);
          }
        } else {
          isKaalsarpDoshSuccess(false);
          AppLogger.d('[KundliController] getKaalsarpDosh->OnApiError');
        }
      }
    } catch (e) {
      isKaalsarpDoshSuccess(false);
      AppLogger.d('[KundliController] getKaalsarpDosh->OnException:${e.toString()}');
    } finally {
      isKaalsarpDoshLoading(false);
    }
  }

  // Manglik Dosh
  Future<void> getManglikDosh(KundliData data) async {
    isManglikDoshLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroKundliManglikDosh}date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          manglikModel = KundliManglikModel.fromJson(response.data);
          if (manglikModel.status == AppConstants.vedicSuccess) {
            isManglikDoshSuccess(true);
          } else {
            isManglikDoshSuccess(false);
          }
        } else {
          isManglikDoshSuccess(false);
          AppLogger.d('[KundliController] getManglikDosh->OnApiError');
        }
      } else if (activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroKundliManglikDosh}dob=${data.dob}&tob=${CommonMethods().convertTimeInputVedic(data.tob)}&lat=${data.latitude}&lon=${data.longitude}&tz=${data.timeZone}&api_key=$vedicApiKey&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          manglikModel = KundliManglikModel.fromJson(response.data);
          if (manglikModel.status == AppConstants.vedicSuccess) {
            isManglikDoshSuccess(true);
          } else {
            isManglikDoshSuccess(false);
          }
        } else {
          isManglikDoshSuccess(false);
          AppLogger.d('[KundliController] getManglikDosh->OnApiError');
        }
      }
    } catch (e) {
      isManglikDoshSuccess(false);
      AppLogger.d('[KundliController] getManglikDosh->OnException:${e.toString()}');
    } finally {
      isManglikDoshLoading(false);
    }
  }

  // Pitra Dosh
  Future<void> getPitraDosh(KundliData data) async {
    isPitraDoshLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if (activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroKundliPitraDosh}date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          pitraDoshModel = KundliPitraDoshModel.fromJson(response.data);
          if (pitraDoshModel.status == AppConstants.vedicSuccess) {
            isPitraDoshSuccess(true);
          } else {
            isPitraDoshSuccess(false);
          }
        } else {
          isPitraDoshSuccess(false);
          AppLogger.d('[KundliController] getPitraDosh->OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroKundliPitraDosh}dob=${data.dob}&tob=${CommonMethods().convertTimeInputVedic(data.tob)}&lat=${data.latitude}&lon=${data.longitude}&tz=${data.timeZone}&api_key=$vedicApiKey&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          pitraDoshModel = KundliPitraDoshModel.fromJson(response.data);
          if (pitraDoshModel.status == AppConstants.vedicSuccess) {
            isPitraDoshSuccess(true);
          } else {
            isPitraDoshSuccess(false);
          }
        } else {
          isPitraDoshSuccess(false);
          AppLogger.d('[KundliController] getPitraDosh->OnApiError');
        }
      }
    } catch (e) {
      isPitraDoshSuccess(false);
      AppLogger.d('[KundliController] getPitraDosh->OnException:${e.toString()}');
    } finally {
      isPitraDoshLoading(false);
    }
  }

  // Rudraksh Suggestion
  Future<void> getRudrakshSuggestion(KundliData data) async {

    isRudrakshaSuggestionsLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroRudrakshSuggestion}date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          rudrakshaSuggestionsModel = KundliRudrakshaSuggestionsModel.fromJson(response.data);
          if (rudrakshaSuggestionsModel.status == AppConstants.vedicSuccess) {  // Ensure correct success condition
            isRudrakshaSuggestionsSuccess(true);
          } else {
            isRudrakshaSuggestionsSuccess(false);
          }
        } else {
          isRudrakshaSuggestionsSuccess(false);
          AppLogger.d('OnApiError');
        }
      }else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroRudrakshSuggestion}dob=${data.dob}&tob=${CommonMethods().convertTimeInputVedic(data.tob)}&lat=${data.latitude}&lon=${data.longitude}&tz=${data.timeZone}&api_key=$vedicApiKey&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          kundliRudrakshaSuggestionsVedicAstroModel = KundliRudrakshaSuggestionsVedicAstroModel.fromJson(response.data);
          if (kundliRudrakshaSuggestionsVedicAstroModel.status == AppConstants.vedicSuccess) {  // Ensure correct success condition
            isRudrakshaSuggestionsSuccess(true);
          } else {
            isRudrakshaSuggestionsSuccess(false);
          }
        } else {
          isRudrakshaSuggestionsSuccess(false);
          AppLogger.d('OnApiError');
        }
      }
    } catch (e) {
      isRudrakshaSuggestionsSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isRudrakshaSuggestionsLoading(false);
    }
  }

  // Gem Suggestion
  Future<void> getGemSuggestion(KundliData data) async {

    isGemSuggestionsLoading(true);
    try {
      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

      if(activeKundliApi == AppConstants.jyotisham){
        String? jyotishamApiKey = await SharedPreferencesHelper.getData(AppConstants.jyotishamApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        setHeader(jyotishamApiKey.toString());
        final response = await _dio.get('${AppConstants.getJyotishamAstroGemSuggestion}date=${data.dob}&time=${CommonMethods().convertTimeInputVedic(data.tob)}&latitude=${data.latitude}&longitude=${data.longitude}&tz=${data.timeZone}&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          gemSuggestionsModel = KundliGemsuggestionsModel.fromJson(response.data);
          if (gemSuggestionsModel.status == AppConstants.vedicSuccess) {  // Ensure correct success condition
            isGemSuggestionsSuccess(true);
          } else {
            isGemSuggestionsSuccess(false);
          }
        } else {
          isGemSuggestionsSuccess(false);
          AppLogger.d('OnApiError');
        }
      } else if(activeKundliApi == AppConstants.vedicastro){
        String? vedicApiKey = await SharedPreferencesHelper.getData(AppConstants.vedicApiKey);
        String? language = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
        final response = await _dio.get('${AppConstants.getVedicAstroGemSuggestion}dob=${data.dob}&tob=${CommonMethods().convertTimeInputVedic(data.tob)}&lat=${data.latitude}&lon=${data.longitude}&tz=${data.timeZone}&api_key=$vedicApiKey&lang=$language');
        if (response.statusCode == AppConstants.vedicSuccess) {
          gemSuggestionsModel = KundliGemsuggestionsModel.fromJson(response.data);
          if (gemSuggestionsModel.status == AppConstants.vedicSuccess) {  // Ensure correct success condition
            isGemSuggestionsSuccess(true);
          } else {
            isGemSuggestionsSuccess(false);
          }
        } else {
          isGemSuggestionsSuccess(false);
          AppLogger.d('OnApiError');
        }
      }
    } catch (e) {
      isGemSuggestionsSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isGemSuggestionsLoading(false);
    }
  }

  @override
  void onClose() {
    super.onClose();
    Get.delete<KundliIntakeFormController>();
  }


  void setHeader(String jyotishamApiKey) {
    _dio.options.headers = {
      'key': jyotishamApiKey,
    };
  }
}
