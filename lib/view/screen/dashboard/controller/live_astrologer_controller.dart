import 'package:astro_brahmand/model/upcoming_live_astrologer_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../model/astrologer_detail_model.dart';
import '../../../../model/astrologer_model.dart';
import '../../../../model/success_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class LiveAstrologerController extends GetxController {

  final Dio _dio = Dio();

  //Live Astrologer
  final isAstrologerLoading = false.obs;
  final isAstrologerSuccess = false.obs;
  AstrologerModel astrologerModel = AstrologerModel();

  //Upcoming
  final isUpcomingLoading = false.obs;
  final isUpcomingSuccess = false.obs;
  UpcomingLiveAstrologerModel upcomingLiveAstrologerModel = UpcomingLiveAstrologerModel();

  SuccessModel liveJoinModel = SuccessModel();
  // Follow
  var isFollowLoading = false.obs;
  RxBool isFollow = false.obs;
  SuccessModel astrologerFollowModel = SuccessModel();

  //Astrologer
  var astrologerController;
  AstrologerDetailModel astrologerDetailModel = AstrologerDetailModel();
  var astrologerData = AstrologerData().obs;
  // // Follow End

  Future<void> getAllAstrologer(String type) async {
    isAstrologerLoading(true);
    try {
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getAllAstrologer,data: {
        "user_uni_id": uniId,
        "type" : type
      });
      if (response.statusCode == 200) {
        astrologerModel = AstrologerModel.fromJson(response.data);
        if(astrologerModel.status == AppConstants.success){
          isAstrologerSuccess(true);
        }
        else{
          isAstrologerSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isAstrologerSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isAstrologerLoading(false);
    }
  }

  Future<void> joinLiveStream(int astrologerUID,String uniqueId, String astrologerUniId) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? agoraAppId = await SharedPreferencesHelper.getData(AppConstants.agoraAppId);
      final response = await _dio.post(AppConstants.joinLiveStream, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'uniqeid' : uniqueId
      });
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        liveJoinModel = SuccessModel.fromJson(response.data);
        if(liveJoinModel.status == AppConstants.success){
          AppLogger.d("Success -> ${response.data.toString()}");
          String? token = response.data["data"]["token"];
          Get.toNamed('/liveStreamScreen',arguments: {
            'uniqueId': uniqueId,
            'agoraAppId': agoraAppId,
            'token': token,
            'astrologerId': astrologerUniId,
            'astrologerUID': astrologerUID
          });
        }else{
          CustomSnackBar.showBottom(liveJoinModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    }
  }

  Future<void> getUpcomingLiveAstrologer() async {
    isUpcomingLoading(true);
    try {
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getUpcomingLiveAstrologers,data: {
        "user_uni_id": uniId
      });
      if (response.statusCode == 200) {
        upcomingLiveAstrologerModel = UpcomingLiveAstrologerModel.fromJson(response.data);
        if(upcomingLiveAstrologerModel.status == AppConstants.success){
          if(upcomingLiveAstrologerModel.data!.isNotEmpty){
            isUpcomingSuccess(true);
          }else{
            isUpcomingSuccess(false);
          }

        }
        else{
          isUpcomingSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isUpcomingSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isUpcomingLoading(false);
    }
  }

  Future<void> astrologerFollow(String status, String astrologerUniId) async {
    isFollowLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.astrologerFollow, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'astrologer_uni_id': astrologerUniId,
        'status' : status
      });
      if (response.statusCode == 200) {
        astrologerFollowModel = SuccessModel.fromJson(response.data);
        if(astrologerFollowModel.status == AppConstants.success){
          if(status == "1"){
            isFollow(true);
          }else{
            isFollow(false);
          }
        }

      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isFollowLoading(false);
    }
  }

}