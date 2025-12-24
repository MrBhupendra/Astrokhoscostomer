import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/app_dialogs.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../agora/videocall/model/service_start_video_call_model.dart';
import '../model/slot_order_list_model.dart';

class SlotOrderController extends GetxController {
  final Dio _dio = Dio();

  num offsetCount = 0;
  bool isNoMoreData = false;
  ScrollController scrollController = ScrollController();

  final isOrderLoading = false.obs;
  final isOrderSuccess = false.obs;
  SlotOrdersListModel slotOrderModel = SlotOrdersListModel();
  List<SlotOrdersData> slotOrderData = [];

  //VideoCall
  ServiceStartVideoCallModel startVideoCallModel = ServiceStartVideoCallModel();
  //Realtime
  late FirebaseDatabase db;
  late DatabaseReference dbReference;
  final String chatGroupChild = "SLOT-CHAT";

  Future<void> getSlotBookings(num offset) async {
    if(offset == 0){
      offsetCount = 0;
      isNoMoreData = false;
      slotOrderData.clear();
    }

    isOrderLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getBookedSchedule, data: {
        'api_key': apiKey,
        'customer_uni_id': uniId,
        "offset": offset,
        "status" : ""   // { pending | in-progress | completed | cancel }
      });

      if (response.statusCode == 200) {
        slotOrderModel = SlotOrdersListModel.fromJson(response.data);
        if(slotOrderModel.status == AppConstants.success){
          offsetCount = slotOrderModel.offset!;
          isOrderSuccess(true);

          for (var element in (slotOrderModel.data ?? [])) {
            slotOrderData.add(element);
          }
        }
        else{
          if(offset == 0){
            isOrderSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isOrderLoading(false);
    }
  }

  Future<void> startSlotVideoCall(String? orderId,String? astrologerUniId) async {
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
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.startSlotVideoCall, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'order_id': orderId,
        'started_by': "Customer",
        'notification_status': notificationStatus,
      });

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        startVideoCallModel = ServiceStartVideoCallModel.fromJson(response.data);
        if (startVideoCallModel.status == AppConstants.success) {
          String? agoraAppId = await SharedPreferencesHelper.getData(AppConstants.agoraAppId);
          String channelName = '$customerUniUd-$astrologerUniId-Video';

          Get.toNamed('/slotVideoCallScreen',arguments: {
            'channelName' : channelName,
            'uniqueId' : orderId,
            'agoraAppId' : agoraAppId,
            'token' : startVideoCallModel.token.toString(),
          });
        } else {
          CustomSnackBar.showBottom(startVideoCallModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
    }
  }

  Future<void> startSlotVoiceCall(String? orderId,String? astrologerUniId, int inAppCallStatus) async {
    int notificationStatus = 1;
    String? customerUniUd = await SharedPreferencesHelper.getData(AppConstants.userUniId);
    String channelName = '$customerUniUd-$astrologerUniId-Call';
    db = FirebaseDatabase.instance;
    dbReference = db.ref(chatGroupChild).child(channelName);
    DataSnapshot chatEndSnapshot = await dbReference.child('chatEnd').get();
    if (chatEndSnapshot.exists && chatEndSnapshot.value == false) {
      notificationStatus = 0;
    }
    CustomProgressDialog.showDialog();

    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.startSlotVoiceCall, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'order_id': orderId,
        'notification_status': notificationStatus,
        'is_inapp_voice_call' : inAppCallStatus
      });

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        startVideoCallModel = ServiceStartVideoCallModel.fromJson(response.data);
        if (startVideoCallModel.status == AppConstants.success) {

          if(inAppCallStatus == 1){
            String? agoraAppId = await SharedPreferencesHelper.getData(AppConstants.agoraAppId);
            String channelName = '$customerUniUd-$astrologerUniId-Video';

            Get.toNamed('/slotVideoCallScreen',arguments: {
              'channelName' : channelName,
              'uniqueId' : orderId,
              'agoraAppId' : agoraAppId,
              'token' : startVideoCallModel.token.toString(),
            });

          }else{
            AppDialog().showCallSuccessDialog(startVideoCallModel.msg.toString(), "Init");
          }
        } else {
          CustomSnackBar.showBottom(startVideoCallModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
    }
  }

}