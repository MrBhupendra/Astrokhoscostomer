import 'package:astro_brahmand/model/blog_model.dart';
import 'package:astro_brahmand/model/success_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_snack_bar.dart';

class BlogController extends GetxController{
  final Dio _dio = Dio();
  final isLoading = false.obs;
  final isSuccess = false.obs;
  BlogModel blogModel = BlogModel();
  BlogsData blogsData = BlogsData();

  // like blog
  final isLikeLoading = false.obs;
  final isLikeSuccess = false.obs;
  RxBool isLike = false.obs;
  SuccessModel blogLikeModel = SuccessModel();

  List<BlogsData> blogsListData = [];
  num offsetCount = 0;
  bool isNoMoreData = false;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getBlog(offsetCount,"");

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if(isLoading.isFalse && !isNoMoreData) {
          getBlog(offsetCount, "");
        }
      }
    });

  }

  Future<void> getBlog(num offset, String search) async {
    if (offset == 0) {
      offsetCount = 0;
      isNoMoreData = false;
      blogsListData.clear();
    }

    isLoading(true);
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey) ?? "";
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId) ?? "";
      final response = await _dio.post(AppConstants.getBlog, data: {
        "offset": offset,
        "api_key": apiKey,
        "user_uni_id": uniId,
        "search": search,
        "astrologer_uni_id": ""
      });

      if (response.statusCode == 200) {
        blogModel = BlogModel.fromJson(response.data);
        if (blogModel.status == AppConstants.success) {
          offsetCount = blogModel.offset!;
          isSuccess(true);

          for (BlogsData element in (blogModel.data ?? [])) {
            element.count.value = element.likeCount!.toInt();
            if (element.isLikes == true) {
              element.liked.value = true;
            }else{
              element.liked.value = false;
            }
            blogsListData.add(element);
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
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> blogLike(String status, String blogId,int index,int likeCount) async {
    isLikeLoading(true);
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.blogLike, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'blog_id': blogId,
        'status': status
      });
      print("apiKey->$apiKey uniId->$uniId blogId->$blogId status->$status");
      if (response.statusCode == 200) {
        blogLikeModel = SuccessModel.fromJson(response.data);
        if (blogLikeModel.status == AppConstants.success) {
          blogsListData[index].count.value = likeCount;
          if (status == "1") {
            blogsListData[index].liked.value = true;
            // CustomSnackBar.showTop(AppStrings.blogLikeMsg);
          } else {
            blogsListData[index].liked.value = false;
            // CustomSnackBar.showTop(AppStrings.blogUnlikeMsg);
          }
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
      isLikeLoading(false);
    }
  }

}