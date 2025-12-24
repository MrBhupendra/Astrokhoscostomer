import 'package:astro_brahmand/model/live_order_history_model.dart';
import 'package:astro_brahmand/model/order_history_model.dart';
import 'package:astro_brahmand/model/product_order_model.dart';
import 'package:astro_brahmand/model/service_order_model.dart';
import 'package:astro_brahmand/model/wallet_history_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../model/get_image_model.dart';
import '../../../../model/group_pooja_order_model.dart';
import '../../../../model/live_mandir_darshan_order_model.dart';
import '../../../../model/success_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../agora/videocall/model/service_start_video_call_model.dart';

class OrderController extends GetxController {

  final Dio _dio = Dio();
  num offsetCount = 0;
  num offsetGroupPoojaCount = 0;
  bool isNoMoreData = false;
  bool isNoMoreGroupPoojaData = false;
  ScrollController scrollController = ScrollController();
  ScrollController groupPoojaScrollController = ScrollController();

  final isCallLoading = false.obs;
  final isCallSuccess = false.obs;
  OrderHistoryModel orderHistoryModel = OrderHistoryModel();
  List<OrderHistoryData> orderHistoryData = [];

  final isWalletLoading = false.obs;
  final isWalletSuccess = false.obs;
  WalletHistoryModel walletHistoryModel = WalletHistoryModel();
  List<WalletHistoryData> walletHistoryData = [];

  final isProductLoading = false.obs;
  final isProductSuccess = false.obs;
  ProductOrderModel productOrderModel = ProductOrderModel();
  ProductOrderData productOrderData = ProductOrderData();

  final isServiceLoading = false.obs;
  final isServiceSuccess = false.obs;
  ServiceOrderModel serviceOrderModel = ServiceOrderModel();

  final isGroupPoojaLoading = false.obs;
  final isGroupPoojaSuccess = false.obs;
  GroupPoojaOrderModel groupPoojaOrderModel = GroupPoojaOrderModel();
  List<GroupPoojaOrderData> groupPoojaOrderData = [];

  // Get Images on Call
  final isImageLoading = false.obs;
  final isImageSuccess = false.obs;
  GetImageModel getImageModel = GetImageModel();

  //GroupPoojaLive
  SuccessModel groupPoojaLiveJoinModel = SuccessModel();

  //CancelGroupPooja
  SuccessModel cancelGroupPoojaOrderModel = SuccessModel();

  //VideoCall
  ServiceStartVideoCallModel startVideoCallModel = ServiceStartVideoCallModel();
  //Realtime
  late FirebaseDatabase db;
  late DatabaseReference dbReference;
  final String chatGroupChild = "SERVICE-VIDEO";

  final isLiveHistoryLoading = false.obs;
  final isLiveHistorySuccess = false.obs;
  LiveOrderHistoryModel liveOrderHistoryModel = LiveOrderHistoryModel();

  //Mandir Darshan
  SuccessModel liveJoinModel = SuccessModel();
  bool isNoMoreMandirDarshanData = false;
  final isMandirDarshanOrderListLoading = false.obs;
  final isMandirDarshanOrderListSuccess = false.obs;
  LiveMandirDarshanOrderModel liveMandirDarshanOrderModel = LiveMandirDarshanOrderModel();
  List<MandirDarshanOrderData> mandirDarshanOrderData = [];


  Future<void> getCallHistory(String type,num offset) async {
    if(offset == 0){
      offsetCount = 0;
      isNoMoreData = false;
      orderHistoryData.clear();
    }

    isCallLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.userCallHistory, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'call_type': type,
        "offset": offset
      });
      if (response.statusCode == 200) {
        orderHistoryModel = OrderHistoryModel.fromJson(response.data);
        if(orderHistoryModel.status == AppConstants.success){
          offsetCount = orderHistoryModel.offset!;
          isCallSuccess(true);

          for (var element in (orderHistoryModel.data ?? [])) {
            orderHistoryData.add(element);
          }
        }
        else{
          if(offset == 0){
            isCallSuccess(false);
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
      isCallLoading(false);
    }
  }

  Future<void> getWalletHistory(num offset) async {
    if(offset == 0){
      offsetCount = 0;
      isNoMoreData = false;
      walletHistoryData.clear();
    }

    isWalletLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getWalletHistory, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        "offset": offset
      });
      if (response.statusCode == 200) {
        walletHistoryModel = WalletHistoryModel.fromJson(response.data);
        if(walletHistoryModel.status == AppConstants.success){
          offsetCount = walletHistoryModel.offset!;
          isWalletSuccess(true);

          for (var element in (walletHistoryModel.data ?? [])) {
            walletHistoryData.add(element);
          }
        }
        else{
          if(offset == 0){
            isWalletSuccess(false);
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
      isWalletLoading(false);
    }
  }

  Future<void> getShopOrder() async {
    isProductLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getShopOrder, data: {
        'api_key': apiKey,
        'user_uni_id': uniId
      });
      if (response.statusCode == 200) {
        // print('API getProductOrder Response: ${response.data}');
        productOrderModel = ProductOrderModel.fromJson(response.data);
        if(productOrderModel.status == AppConstants.success){
          isProductSuccess(true);
        }
        else{
          isProductSuccess(false);
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
      isProductLoading(false);
    }
  }

  //Service
  Future<void> getServiceOrder() async {
    isServiceLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getServiceOrder, data: {
        'api_key': apiKey,
        'user_uni_id': uniId
      });
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('API getServiceOrder Response: ${response.data}');
        }
        serviceOrderModel = ServiceOrderModel.fromJson(response.data);
        if(serviceOrderModel.status == AppConstants.success){
          isServiceSuccess(true);
        }
        else{
          isServiceSuccess(false);
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
      isServiceLoading(false);
    }
  }

  Future<void> startServiceVideoCall(String? orderId,String? astrologerUniId) async {
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
      final response = await _dio.post(AppConstants.startServiceVideoCall, data: {
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
          Get.back();

          String? agoraAppId = await SharedPreferencesHelper.getData(AppConstants.agoraAppId);
          String channelName = '$customerUniUd-$astrologerUniId-Video';

        //  print("StartVideoCall Data-> channel:$channelName uniqueId:${startVideoCallModel.data?.uniqeid.toString()} agoraAppId:$agoraAppId token:${startVideoCallModel.data!.agoraToken.toString()}");
          Get.toNamed('/serviceVideoCallScreen',arguments: {
            'channelName' : channelName,
            'uniqueId' : orderId,
            'agoraAppId' : agoraAppId,
            'token' : startVideoCallModel.token.toString(),
          });
        } else {
          //Handle error code here
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

  //GroupPooja
  Future<void> getGroupPoojaOrder(num offset) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (offset == 0) {
        offsetCount = 0;
        isNoMoreGroupPoojaData = false;
        groupPoojaOrderData.clear();
      }

      isGroupPoojaLoading(true);
      try {
        String? apiKey = await SharedPreferencesHelper.getData(
            AppConstants.userApiKey);
        String? uniId = await SharedPreferencesHelper.getData(
            AppConstants.userUniId);
        final response = await _dio.post(
            AppConstants.getCustomerGroupPujaOrder, data: {
          'api_key': apiKey,
          'user_uni_id': uniId,
          'offset': offset,
        });
        if (kDebugMode) {
          print('API getGroupPoojaOrder Response: ${response.data}');
        }
        if (response.statusCode == 200) {
          groupPoojaOrderModel = GroupPoojaOrderModel.fromJson(response.data);
          if (groupPoojaOrderModel.status == AppConstants.success) {
            offsetCount = groupPoojaOrderModel.offset!;
            isGroupPoojaSuccess(true);
            if (groupPoojaOrderModel.data != null &&
                groupPoojaOrderModel.data!.isNotEmpty) {
              for (var element in (groupPoojaOrderModel.data ?? [])) {
                groupPoojaOrderData.add(element);
              }
            }
          }
          else {
            if (offset == 0) {
              isGroupPoojaSuccess(false);
            }
            isNoMoreGroupPoojaData = true;
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
        isGroupPoojaLoading(false);
      }
    });
  }


  Future<void> joinGroupPoojaLiveStream(String orderId, String astrologerUniId, String uniqueId, String groupPoojaAssignId) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? agoraAppId = await SharedPreferencesHelper.getData(AppConstants.agoraAppId);
      final response = await _dio.post(AppConstants.joinGroupPuja, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'order_id' : orderId,
        'group_puja_assign_id' : groupPoojaAssignId,
        'started_by' : "Customer"
      });
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        groupPoojaLiveJoinModel = SuccessModel.fromJson(response.data);
        if(groupPoojaLiveJoinModel.status == AppConstants.success){
          if (kDebugMode) {
            print("GroupPoojaLiveSuccess -> ${response.data.toString()}");
          }
          String? token = response.data["token"];
          Get.toNamed('/groupPoojaLiveStreamScreen',arguments: {
            'uniqueId': uniqueId,
            'agoraAppId': agoraAppId,
            'token': token,
            'astrologerId': astrologerUniId,
            'astrologerUID': response.data["astrologer"]!["id"]!.toInt(),
            'orderId': orderId,
            'groupPoojaAssignId': groupPoojaAssignId
          });
        }else{
          CustomSnackBar.showBottom(groupPoojaLiveJoinModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      getCustomerMandirDarshanOrder(0);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    }
  }

  Future<void> cancelGroupPoojaOrder(String orderId) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.cancelGroupPujaByCustomerApi, data: {
        'api_key': apiKey,
        'customer_uni_id': uniId,
        'order_id': orderId,
      });
      if (kDebugMode) {
        print("orderId$orderId");
      }
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        if (kDebugMode) {
          print('Cancel Group Pooja Response: ${response.data}');
        }
        cancelGroupPoojaOrderModel = SuccessModel.fromJson(response.data);
        if(cancelGroupPoojaOrderModel.status == AppConstants.success){
          CustomSnackBar.showTop(cancelGroupPoojaOrderModel.msg.toString());
          getGroupPoojaOrder(0);
        }
        else{
          CustomSnackBar.showBottom(cancelGroupPoojaOrderModel.msg.toString());
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
    }
  }

  Future<void> getCustomerMandirDarshanOrder(num offset) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (offset == 0) {
        offsetCount = 0;
        isNoMoreMandirDarshanData = false;
        mandirDarshanOrderData.clear();
      }

      isMandirDarshanOrderListLoading(true);
      try {
        String? apiKey = await SharedPreferencesHelper.getData(
            AppConstants.userApiKey);
        String? uniId = await SharedPreferencesHelper.getData(
            AppConstants.userUniId);
        final response = await _dio.post(
            AppConstants.getCustomerMandirDarshanOrder, data: {
          'api_key': apiKey,
          'user_uni_id': uniId,
          'offset': offset,
        });
        if (kDebugMode) {
          print('API getCustomerMandirDarshanOrder Response: ${response.data}');
        }
        if (response.statusCode == 200) {
          liveMandirDarshanOrderModel =
              LiveMandirDarshanOrderModel.fromJson(response.data);
          if (liveMandirDarshanOrderModel.status == AppConstants.success) {
            offsetCount = liveMandirDarshanOrderModel.offset!;
            isMandirDarshanOrderListSuccess(true);
            if (liveMandirDarshanOrderModel.data != null &&
                liveMandirDarshanOrderModel.data!.isNotEmpty) {
              for (var element in (liveMandirDarshanOrderModel.data ?? [])) {
                mandirDarshanOrderData.add(element);
              }
            }
          }
          else {
            if (offset == 0) {
              isMandirDarshanOrderListSuccess(false);
            }
            isNoMoreMandirDarshanData = true;
          }
        } else {
          if (kDebugMode) {
            print('OnApiErrorGetCustomerMandirDarshanOrder');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('OnExceptionGetCustomerMandirDarshanOrder==> ${e.toString()}');
        }
      } finally {
        isMandirDarshanOrderListLoading(false);
      }
    });
  }

  Future<void> joinMandirDarshan(String astrologerUniId, String uniqueId, String assignId) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? agoraAppId = await SharedPreferencesHelper.getData(AppConstants.agoraAppId);
      print("$apiKey $uniId $assignId Customer");
      final response = await _dio.post(AppConstants.joinMandirDarshan, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'live_temple_darshan_assign_id' : assignId,
        'started_by' : "Customer"
      });
      if (kDebugMode) {
        print("responseTemple:::$response");
      }
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        liveJoinModel = SuccessModel.fromJson(response.data);
        if(liveJoinModel.status == AppConstants.success){
          String? token = response.data["token"];
          Get.toNamed('/liveStreamScreen',arguments: {
            'uniqueId': uniqueId,
            'agoraAppId': agoraAppId,
            'token': token,
            'astrologerId': astrologerUniId,
            'astrologerUID': response.data["astrologer"]!["id"]!.toInt()
          });
          print("As1 Req $token $uniqueId $agoraAppId $astrologerUniId ${response.data["astrologer"]!["id"]!.toInt()}");
        }else{
          CustomSnackBar.showBottom(liveJoinModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        if (kDebugMode) {
          print('OnApiErrorJoinMandirDarshan');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('OnExceptionJoinMandirDarshan==> ${e.toString()}');
      }
    } finally {
      CustomProgressDialog.dismissDialog();
    }
  }

  Future<void> getLiveOrderHistory(String giftType, num offset) async {
    isLiveHistoryLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getLiveGiftHistory, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'gift_type ': giftType,
        'offset ': offset,
      });
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('API liveOrderHistoryModel Response: ${response.data}');
        }
        liveOrderHistoryModel = LiveOrderHistoryModel.fromJson(response.data);
        if(liveOrderHistoryModel.status == AppConstants.success){
          isLiveHistorySuccess(true);
        }
        else{
          isLiveHistorySuccess(false);
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
      isLiveHistoryLoading(false);
    }
  }

  String formatDuration(String durationString) {
    try {
      int totalSecs = int.tryParse(durationString) ?? 0;
      int hours = totalSecs ~/ 3600;
      int minutes = (totalSecs % 3600) ~/ 60;
      int seconds = totalSecs % 60;
      return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    } catch (e) {
      return "00:00:00";
    }
  }

  Future<void> getImage(String uniqueId) async {
    isImageSuccess(false);
    isImageLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getFileOnCall,data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "uniqeid" : uniqueId,
        "send_by" : "Astrologer",
      });

      if (response.statusCode == 200) {
        getImageModel = GetImageModel.fromJson(response.data);
        if(getImageModel.status == AppConstants.success){
          if(getImageModel.data!.isNotEmpty) {
            isImageSuccess(true);
          }
        }
        else{
          isImageSuccess(false);
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
      isImageLoading(false);
    }
  }

}