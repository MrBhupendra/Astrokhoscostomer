import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../model/astrologer_filter_model.dart';
import '../../../../model/astrologer_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../../search/model/astrologer_request_model.dart';

class CallAstrologerController extends GetxController {
  final Dio _dio = Dio();

  //Astrologer
  final isAstrologerLoading = false.obs;
  final isAstrologerSuccess = false.obs;
  num offsetCount = 0;
  bool isNoMoreData = false;
  ScrollController scrollController = ScrollController();
  AstrologerModel astrologerModel = AstrologerModel();
  List<AstrologerData> astrologerListData = [];

  //Selected Astrologer Profile
  // var selectedAstrologerData = AstrologerData().obs;

  // Filter
  final isFilterLoading = false.obs;
  final isFilterSuccess = false.obs;
  RxInt selectedIndexFilter = 1.obs;
  AstrologerFilterModel astrologerFilterModel = AstrologerFilterModel();
  var languageList = <LanguageList>[].obs;
  var skillList = <SkillList>[].obs;
  var categoryList = <CategoryList>[].obs;

  //Filter Values from previous screen
  String? isCategoryId = '';
  String? isSlug = '';
  String? isVirtualAstrologer = '0';
  String? isSlotPermission = '0';
  String? isSlotAvailable = '0';
  String? isDashboardType = '';

  // Selected filters
  RxString searchValue = ''.obs;
  var filterSelectedSort = ''.obs;
  var filterSelectedSkills = <String>[].obs;
  var filterSelectedLanguages = <String>[].obs;
  var filterSelectedCategories = <String>[].obs;
  var filterSelectedGender = ''.obs;

  //Top Category Filter
  RxInt topSelectedCategoryIndex = 1.obs; // Initialize to 1 for "Filter"

  void setTopCategoryFilterIndex(int index) {
    topSelectedCategoryIndex.value = index;
  }

  // Search
  Timer? _debounce;

  String _latestRequestToken = '';

  @override
  void onInit() {
    super.onInit();
    // logger
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }

  void searchAstrologers(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      resetOffset();
      searchValue.value = query;
      getAllAstrologer(AstrologerRequestModel(
        offset: offsetCount,
        search: searchValue.value,
        gender: filterSelectedGender.value,
        language: filterSelectedLanguages.isNotEmpty ? filterSelectedLanguages.toString() : '',
        category: filterSelectedCategories.isNotEmpty ?  filterSelectedCategories.toString() : '',
        skill:  filterSelectedSkills.isNotEmpty ?  filterSelectedSkills.toString() : '',
        sortBy: filterSelectedSort.value,
        slug: isSlug,
        isVirtual: isVirtualAstrologer,
        slotPermission: isSlotPermission,
        isSlotAvailable: isSlotAvailable,
        type: isDashboardType,
        astrologerUniId: '',
      ));
    });
  }

  Future<void> getFilters() async {
    isFilterLoading(true);
    try {
      final response = await _dio.post(AppConstants.getFilters);
      if (response.statusCode == 200) {
        astrologerFilterModel = AstrologerFilterModel.fromJson(response.data);
        if (astrologerFilterModel.status == AppConstants.success) {
          skillList.value = astrologerFilterModel.skillList ?? [];
          languageList.value = astrologerFilterModel.languageList ?? [];
          categoryList.value = astrologerFilterModel.categoryList ?? [];
          isFilterSuccess(true);
        } else {
          isFilterSuccess(false);
        }
      } else {
        debugPrint("getFilters [API ERROR] ${response.statusCode}->${response.statusMessage}");
      }
    } catch (e) {
      isFilterSuccess(false);
      debugPrint("getFilters [EXCEPTION]");
    } finally {
      isFilterLoading(false);
    }
  }

  Future<void> getAllAstrologer(AstrologerRequestModel request) async {
    final thisRequestToken = DateTime.now().millisecondsSinceEpoch.toString();
    _latestRequestToken = thisRequestToken;

    if (request.offset == 0) {
      resetOffset();
      isNoMoreData = false;
      astrologerListData.clear();
      isAstrologerSuccess(false);
    }
    isAstrologerLoading(true);
    try {
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final requestData = request.toJson();
      requestData['user_uni_id'] = uniId;
      debugPrint("AS1 [getAllAstrologer] request $requestData");
      final response = await _dio.post(AppConstants.getAllAstrologer,data: requestData);

      if (_latestRequestToken != thisRequestToken) {
        debugPrint("AS1 [getAllAstrologer] Stale response ignored");
        return;
      }

      if (response.statusCode == 200) {
        astrologerModel = AstrologerModel.fromJson(response.data);
        if (astrologerModel.status == AppConstants.success) {
          offsetCount = astrologerModel.offset ?? 0;

          for (var element in (astrologerModel.data ?? [])) {
            astrologerListData.add(element);
          }
          isAstrologerSuccess(true);
        } else {
          if (request.offset == 0) {
            isAstrologerSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        debugPrint("getAllAstrologer [API ERROR] ${response.statusCode}->${response.statusMessage}");
      }
    } catch (e) {
      isAstrologerSuccess(false);
      debugPrint("getAllAstrologer [EXCEPTION]");
    } finally {
      isAstrologerLoading(false);
    }
  }

  //Filter
  void clearAllFilters() {
    filterSelectedSort.value = '';
    filterSelectedSkills.clear();
    filterSelectedLanguages.clear();
    filterSelectedGender.value = '';
    //filterSelectedCategories.clear();
  }

  void applyFilters() {
    resetOffset();
    getAllAstrologer(AstrologerRequestModel(
      offset: offsetCount,
      search: searchValue.value,
      gender: filterSelectedGender.value,
      language: filterSelectedLanguages.isNotEmpty ? filterSelectedLanguages.toString() : '',
      category: filterSelectedCategories.isNotEmpty ?  filterSelectedCategories.toString() : '',
      skill:  filterSelectedSkills.isNotEmpty ?  filterSelectedSkills.toString() : '',
      sortBy: filterSelectedSort.value,
      slug: isSlug,
      isVirtual: isVirtualAstrologer,
      slotPermission: isSlotPermission,
      isSlotAvailable: isSlotAvailable,
      type: isDashboardType,
      astrologerUniId: '',
    ));
  }

  bool isFilterSelected(int filterIndex) {
    switch (filterIndex) {
      case 1:
        return filterSelectedSort.value.isNotEmpty;
      case 2:
        return filterSelectedSkills.isNotEmpty;
      case 3:
        return filterSelectedLanguages.isNotEmpty;
      case 4:
        return filterSelectedGender.value.isNotEmpty;
    // case 5:
    //   return filterSelectedCategories.isNotEmpty;
      default:
        return false;
    }
  }
  //Filter END

  void resetOffset(){
    offsetCount = 0;
  }

  void resetCategory(){
    filterSelectedCategories.clear();
  }

  void resetSearch(){
    searchValue.value = '';
  }

  void resetData(){
    isCategoryId = '';
    isSlug =  '';
    isVirtualAstrologer = '0';
    isSlotPermission = '0';
    isSlotAvailable = '0';
  }
}