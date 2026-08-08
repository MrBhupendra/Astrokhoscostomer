import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../model/astrologer_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class FollowingController extends FullLifeCycleController with FullLifeCycleMixin {
  final Dio _dio = Dio();

  //Astrologer
  final isLoading = false.obs;
  final isSuccess = false.obs;
  bool isNoMoreData = false;
  ScrollController scrollController = ScrollController();
  num offsetCount = 0;

  AstrologerModel astrologerModel = AstrologerModel();
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
    getFollowing(offsetCount,'init');

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if(isLoading.isFalse && !isNoMoreData) {
          getFollowing(offsetCount,'scroll');
        }
      }
    });

  }

  Future<void> getFollowing(num offset,String action) async {
    if(offset == 0){
      offsetCount = 0;
      isNoMoreData = false;
      astrologerListData.clear();
    }

    isLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getFollowing,data: {
        "user_uni_id": uniId,
        "api_key": apiKey,
        "offset" : offset
      });

      if (response.statusCode == 200) {
        astrologerModel = AstrologerModel.fromJson(response.data);
        if(astrologerModel.status == AppConstants.success){
          offsetCount = astrologerModel.offset!;
          isSuccess(true);

          for (var element in (astrologerModel.data ?? [])) {
            astrologerListData.add(element);
          }
        }
        else{
          if(offset == 0){
            isSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

}