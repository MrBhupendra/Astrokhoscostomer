import 'package:astro_brahmand/view/screen/remedies/model/remedies_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';

class RemediesController extends GetxController {
  final Dio _dio = Dio();

  //Reviews
  final isLoading = false.obs;
  final isSuccess = false.obs;
  bool isNoMoreData = false;
  RemediesModel remediesModel = RemediesModel();
  ScrollController scrollController = ScrollController();
  num offsetCount = 0;
  List<RemediesData> remediesListData = [];


  Future<void> getRemedies(num offset,String astrologerUniId) async {
    if(offset == 0){
      offsetCount = 0;
      isNoMoreData = false;
      remediesListData.clear();
    }

    isLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getRemedies, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        "offset" : offset,
        "astrologer_uni_id" : astrologerUniId
      });

      print("Request $apiKey $uniId $offset");

      if (response.statusCode == 200) {
        print("Response ${response.data.toString()}");
        remediesModel = RemediesModel.fromJson(response.data);
        if(remediesModel.status == AppConstants.success){
          offsetCount = remediesModel.offset!;
          isSuccess(true);

          for (var element in (remediesModel.data ?? [])) {
            remediesListData.add(element);
          }
        }
        else{
          if(offset == 0){
            isSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        debugPrint('OnApiError');
      }
    } catch (e) {
      isSuccess(false);
      debugPrint('OnException==> ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }


}