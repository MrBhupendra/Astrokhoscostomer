import 'dart:async';

import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../model/success_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../model/queue_list_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class QueueController extends FullLifeCycleController
    with FullLifeCycleMixin {

  final Dio _dio = Dio();
  final isQueueLoading = false.obs;
  final isQueueSuccess = false.obs;

  QueueListModel queueListModel = QueueListModel();
  List<QueueListData> queueListData = [];

  SuccessModel declineChatModel = SuccessModel();

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
    Timer.periodic(const Duration(seconds: 30), (timer) {
      getQueueList();
    });

  }

  Future<void> getQueueList() async {
    AppLogger.d("QueueList");
    isQueueLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getQueueList, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
      });

      if (response.statusCode == 200) {
        AppLogger.d("QueueList Response ${response.data}");
        queueListModel = QueueListModel.fromJson(response.data);
        queueListData.clear();
        if (queueListModel.status == AppConstants.success) {
          isQueueSuccess(true);
          for (var element in (queueListModel.data ?? [])) {
            queueListData.add(element);
          }
        } else {
          isQueueSuccess(false);
        }
      } else {
        isQueueSuccess(false);
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isQueueLoading(false);
    }
  }

  Future<void> declineRequest(String uniqeid,int index, int id) async {
    isQueueLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.declineQueueRequest, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'uniqeid': uniqeid,
        'status': "Declined(Customer)"
      });

      if (response.statusCode == 200) {
        declineChatModel = SuccessModel.fromJson(response.data);
        CustomSnackBar.showBottom(declineChatModel.msg.toString());
        if (declineChatModel.status == AppConstants.success) {
          AwesomeNotifications().cancel(id);
          isQueueSuccess(true);
          queueListData.removeAt(index);
          CustomSnackBar.showBottom(declineChatModel.msg.toString());
        } else {
          isQueueSuccess(false);
          CustomSnackBar.showBottom(declineChatModel.msg.toString());
        }
      } else {
        isQueueSuccess(false);
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isQueueLoading(false);
    }
  }

}