import 'package:astro_brahmand/model/success_model.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_features.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_progress_dialog.dart';

class FeedbackController extends GetxController{

  final Dio _dio = Dio();
  final isLoading = false.obs;
  final isSuccess = false.obs;
  SuccessModel successModel = SuccessModel();

  Future<void> submitReview(String astrologerId,String uniqueId, String rating, String message) async {
    CustomProgressDialog.showDialog();
    isLoading(true);
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.submitReview,data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'astrologer_uni_id': astrologerId,
        'uniqeid': uniqueId,
        'review_rating': rating,
        'review_comment': message
      });
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        successModel = SuccessModel.fromJson(response.data);
        if(successModel.status == AppConstants.success){
          isSuccess(true);
          if(AppFeatures.tipScreenAfterFeedBack == true){
            Get.offAllNamed('/tipScreen', arguments: {'astrologerId': astrologerId});
          }
          else{
            Get.offAllNamed('/dashboard');
          }
        }
        else{
          isSuccess(false);
          CustomSnackBar.showBottom(successModel.msg.toString());
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      isSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isLoading(false);
    }
  }

}