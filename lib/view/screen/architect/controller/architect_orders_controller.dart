import 'package:astro_brahmand/view/screen/architect/model/architect_completed_order_model.dart';
import 'package:astro_brahmand/view/screen/architect/model/architect_in_progress_order_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../agora/videocall/model/service_start_video_call_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class ArchitectOrdersController extends GetxController {
  final Dio _dio = Dio();
  num offsetCount = 0;
  bool isNoMoreData = false;
  ScrollController scrollController = ScrollController();

  final isInProgressLoading = false.obs;
  final isInProgressSuccess = false.obs;
  ArchitectInProgressOrderModel inProgressOrderModel = ArchitectInProgressOrderModel();
  List<ArchitectInProgressData> inProgressOrderData = [];

  final isCompletedLoading = false.obs;
  final isCompletedSuccess = false.obs;
  ArchitectCompletedOrderModel completedOrderModel = ArchitectCompletedOrderModel();
  List<ArchitectCompletedOrderData> completedOrderData = [];

  //VideoCall
  ServiceStartVideoCallModel startVideoCallModel = ServiceStartVideoCallModel();
  //Realtime
  late FirebaseDatabase db;
  late DatabaseReference dbReference;
  final String chatGroupChild = "ARCHITECT-CHAT";

  Future<void> getInProgressOrders() async {
    isInProgressLoading(true);
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(
          AppConstants.architectInProgressOrdersList,
          data: {'api_key': apiKey, 'user_uni_id': uniId});
      if (response.statusCode == 200) {
        inProgressOrderData.clear();
        inProgressOrderModel = ArchitectInProgressOrderModel.fromJson(response.data);
        if (inProgressOrderModel.status == AppConstants.success) {
          isInProgressSuccess(true);

          for (var element in (inProgressOrderModel.data ?? [])) {
            inProgressOrderData.add(element);
          }
        } else {
          isInProgressSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isInProgressLoading(false);
    }
  }

  Future<void> getCompletedOrders() async {
    isCompletedLoading(true);
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(
          AppConstants.architectCompletedOrdersList,
          data: {'api_key': apiKey, 'user_uni_id': uniId});
      if (response.statusCode == 200) {
        completedOrderData.clear();
        completedOrderModel = ArchitectCompletedOrderModel.fromJson(response.data);
        if (completedOrderModel.status == AppConstants.success) {
          isCompletedSuccess(true);

          for (var element in (completedOrderModel.data ?? [])) {
            completedOrderData.add(element);
          }
        } else {
          isCompletedSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isCompletedLoading(false);
    }
  }

  Future<void> startServiceVideoCall(String? uniqueId,String? astrologerUniId) async {
    int notificationStatus = 1;
    String? customerUniUd = await SharedPreferencesHelper.getData(AppConstants.userUniId);
    String channelName = '$customerUniUd-$astrologerUniId-Video';
    db = FirebaseDatabase.instance;
    dbReference = db.ref(chatGroupChild).child(channelName);
    DataSnapshot chatEndSnapshot = await dbReference.child('chatEnd').get();
    if (chatEndSnapshot.exists && chatEndSnapshot.value == false) {
      notificationStatus = 0;
    }
    CustomProgressDialog.showDialog();

    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.startArchitectVideoCall, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'uniqeid': uniqueId,
        'started_by': "Customer",
        'notification_status': notificationStatus,
      });

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        startVideoCallModel = ServiceStartVideoCallModel.fromJson(response.data);
        if (startVideoCallModel.status == AppConstants.success) {
          String? agoraAppId = await SharedPreferencesHelper.getData(AppConstants.agoraAppId);
          String channelName = '$customerUniUd-$astrologerUniId-Video';

          //  print("StartVideoCall Data-> channel:$channelName uniqueId:${startVideoCallModel.data?.uniqeid.toString()} agoraAppId:$agoraAppId token:${startVideoCallModel.data!.agoraToken.toString()}");
          Get.toNamed('/architectVideoCallScreen',arguments: {
            'channelName' : channelName,
            'uniqueId' : uniqueId,
            'agoraAppId' : agoraAppId,
            'token' : startVideoCallModel.token.toString(),
          });
        } else {
          //Handle error code here
          CustomSnackBar.showBottom(startVideoCallModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
    }
  }

}
