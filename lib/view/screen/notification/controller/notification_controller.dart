import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../model/success_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../model/notification_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class NotificationController extends GetxController {
  final Dio _dio = Dio();

  //Reviews
  final isLoading = false.obs;
  final isSuccess = false.obs;
  bool isNoMoreData = false;
  NotificationModel notificationModel = NotificationModel();
  ScrollController scrollController = ScrollController();
  num offsetCount = 0;
  // List<NotificationData> notificationListData = [];
  final notificationListData = <NotificationData>[].obs;

  final RxBool shouldRefreshScreen = false.obs;
  SuccessModel deleteModel = SuccessModel();
  final isDeleteSuccess = false.obs;
  void refreshScreen() {
    shouldRefreshScreen.toggle();
  }

  @override
  void onInit() {
    super.onInit();
    getNotifications(offsetCount);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if(isLoading.isFalse && !isNoMoreData) {
          getNotifications(offsetCount);
        }
      }
    });
  }

  Future<void> getNotifications(num offset) async {
    if(offset == 0){
      offsetCount = 0;
      isNoMoreData = false;
      notificationListData.clear();
    }

    isLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getNotification, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        "offset" : offset
      });

      if (response.statusCode == 200) {
        notificationModel = NotificationModel.fromJson(response.data);
        if (notificationModel.status == AppConstants.success) {
          offsetCount = notificationModel.offset!;

          for (var element in (notificationModel.data ?? [])) {
            notificationListData.add(element);
          }
          if(notificationListData.isNotEmpty){
            isSuccess(true);
          }
        }
        else {
          if (offset == 0) {
            isSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isSuccess(false);
      AppLogger.d('OnExceptionAll==> ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteAllNotifications(int isAllDelete,String? notificationId, int? index) async {
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.deleteNotification, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'notification_id': notificationId,
        'is_all_delete': isAllDelete,
      });
      if (response.statusCode == 200) {
        deleteModel = SuccessModel.fromJson(response.data);
        if(deleteModel.status == AppConstants.success){
          isDeleteSuccess(true);
          if (isAllDelete == 1) {
            Get.back();
            notificationListData.clear();
            refreshScreen();
          } else {
            if (index != null) {
              notificationListData.removeAt(index);
              refreshScreen();
            }
          }
        }
        else{
          isDeleteSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }


}