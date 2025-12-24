import 'package:astro_brahmand/model/video_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utill/app_constants.dart';

class VideoController extends GetxController{
  final Dio _dio = Dio();
  final isLoading = false.obs;
  final isSuccess = false.obs;

  VideoModel videoModel = VideoModel();
  List<VideoData> videoList = [];
  num offsetCount = 0;
  bool isNoMoreData = false;
  ScrollController scrollController = ScrollController();


  @override
  void onInit() {
    super.onInit();
    getVideoList(offsetCount);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if(isLoading.isFalse && !isNoMoreData) {
          getVideoList(offsetCount);
        }
      }
    });

  }

  Future<void> getVideoList(num offset) async {
    if(offset == 0){
      offsetCount = 0;
      isNoMoreData = false;
      videoList.clear();
    }
    isLoading(true);
    try {
      final response = await _dio.post(AppConstants.getVideo, data: {
        'offset': offset
      });
      if (response.statusCode == 200) {
        videoModel = VideoModel.fromJson(response.data);
        if (videoModel.status == AppConstants.success) {
          offsetCount = videoModel.offset!;
          isSuccess(true);

          for (var element in (videoModel.data ?? [])) {
            videoList.add(element);
          }
        } else {
          if (offset == 0) {
            isSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      isSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isLoading(false);
    }
  }

}