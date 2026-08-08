import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:astro_brahmand/model/success_model.dart';
import '../../../../model/astrologer_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../agora/live_stream/model/live_gift_list_model.dart';
import '../../dashboard/controller/dashboard_controller.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class GiftController extends FullLifeCycleController with FullLifeCycleMixin{

  DashboardController dashboardController = Get.put(DashboardController());

  final Dio _dio = Dio();
  final isGiftLoading = false.obs;
  final isGiftSuccess = false.obs;
  var astrologerData = AstrologerData().obs;

  RxInt selectedGiftIndex = 0.obs;
  RxString walletBalance = '***'.obs;

  LiveGiftListModel liveGiftListModel = LiveGiftListModel();
  SuccessModel giftSendSuccessModel = SuccessModel();

  Future<void> getGifts() async {

    isGiftLoading(true);
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getLiveGifts,
          data: {'api_key': apiKey, "user_uni_id": uniId});
      if (response.statusCode == 200) {
        liveGiftListModel = LiveGiftListModel.fromJson(response.data);
        if (liveGiftListModel.status == AppConstants.success) {
          walletBalance.value = liveGiftListModel.walletBalance.toString();
          isGiftSuccess(true);
        } else {
          isGiftSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isGiftSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isGiftLoading(false);
    }
  }

  Future<void> sendGiftApi(String status, String astrologerId, String giftId) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.sendLiveGift, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "astrologer_uni_id": astrologerId,
        "gift_id": giftId
      });

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        giftSendSuccessModel = SuccessModel.fromJson(response.data);
        if (giftSendSuccessModel.status == AppConstants.success) {
          if (status == "1") {
            CustomSnackBar.showTop("Gift '${liveGiftListModel.data![selectedGiftIndex.value.toInt()].giftName}' sent successfully.");
            Get.offAllNamed('/dashboard');
            dashboardController.getWalletBalance();
          } else {
            CustomSnackBar.showTop("Gift '${liveGiftListModel.data![selectedGiftIndex.value.toInt()].giftName}' sent successfully.");
            dashboardController.getWalletBalance();
          }
        } else {
          CustomSnackBar.showBottom(giftSendSuccessModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    }
  }

  @override
  void onResumed() {
  }
  
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

}