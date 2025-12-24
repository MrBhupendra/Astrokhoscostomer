import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../model/success_model.dart';
import '../../../../model/wallet_balance_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_snack_bar.dart';

class SettingController extends GetxController {
  final Dio _dio = Dio();

  var isAnonymousStatusLoading = false.obs;
  var anonymousReviewStatus = false.obs;
  SuccessModel anonymousStatusModel = SuccessModel();

  final isBalanceLoading = false.obs;
  final isBalanceSuccess = false.obs;
  RxDouble walletBalance = 0.0.obs;
  WalletBalanceModel walletBalanceModel = WalletBalanceModel();

  @override
  Future<void> onInit() async {
    super.onInit();
    getWalletBalance();
  }

  Future<void> getWalletBalance() async {
    isBalanceLoading(true);
    try {
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);

      final response = await _dio.post(AppConstants.getWalletBalance, data: {
        "api_key": apiKey,
        "user_uni_id": uniId
      });

      if (response.statusCode == 200) {
        walletBalanceModel = WalletBalanceModel.fromJson(response.data);
        if (walletBalanceModel.status == AppConstants.success) {
          isBalanceSuccess(true);
          walletBalance.value = double.parse(walletBalanceModel.data.toString());
          if(walletBalanceModel.isAnonymousReview == 1){
            anonymousReviewStatus(true);
          }else{
            anonymousReviewStatus(false);
          }
        } else {
          isBalanceSuccess(false);
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      isBalanceSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isBalanceLoading(false);
    }
  }

  Future<void> updateAnonymousReviewStatus(String status) async {
    isAnonymousStatusLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.customerAnonymousReviewStatusChange, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'is_anonymous_review' : status
      });
      if (response.statusCode == 200) {
        anonymousStatusModel = SuccessModel.fromJson(response.data);
        if(anonymousStatusModel.status == AppConstants.success){
          if(status == "1"){
            anonymousReviewStatus(true);
            CustomSnackBar.showBottom(anonymousStatusModel.msg.toString());
          }else{
            anonymousReviewStatus(false);
            CustomSnackBar.showBottom(anonymousStatusModel.msg.toString());
          }
        }else{
          CustomSnackBar.showBottom(anonymousStatusModel.msg.toString());
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
      isAnonymousStatusLoading(false);
    }
  }


}