import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../model/astrologer_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';

class ArchitectController extends FullLifeCycleController
    with FullLifeCycleMixin {

  final Dio _dio = Dio();
  final isLoading = false.obs;
  final isSuccess = false.obs;

  //Astrologer
  final isAstrologerLoading = false.obs;
  final isAstrologerSuccess = false.obs;
  bool isNoMoreData = false;
  AstrologerModel astrologerModel = AstrologerModel();
  ScrollController scrollController = ScrollController();
  num offsetCount = 0;
  List<AstrologerData> astrologerListData = [];
  AstrologerData astrologerData = AstrologerData();


  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

  @override
  void onInit() {
    super.onInit();
    getArchitects(offsetCount,'','init');

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if(isAstrologerLoading.isFalse && !isNoMoreData) {
          getArchitects(offsetCount,'','offset');
        }
      }
    });

  }

  Future<void> getArchitects(num offset, String search, String action) async {
    if(offset == 0){
      offsetCount = 0;
      isNoMoreData = false;
      astrologerListData.clear();
    }
    isAstrologerLoading(true);

    try {
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? categoryId = await SharedPreferencesHelper.getData(AppConstants.architectCategoryId);
      print('id-> $categoryId');

      final response = await _dio.post(AppConstants.getAllAstrologer,data: {
        "user_uni_id": uniId,
        "offset" : offset,
        "language": "",
        "category": categoryId,
        "skill" : "",
        "type" : "",
        "sortby" : "",
        "search" : search
      });

      if (response.statusCode == 200) {
        astrologerModel = AstrologerModel.fromJson(response.data);
        if(astrologerModel.status == AppConstants.success){
          offsetCount = astrologerModel.offset!;
          isAstrologerSuccess(true);

          for (var element in (astrologerModel.data ?? [])) {
            astrologerListData.add(element);
          }
        }
        else{
          if(offset == 0){
            isAstrologerSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      isAstrologerSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isAstrologerLoading(false);
    }
  }
}
