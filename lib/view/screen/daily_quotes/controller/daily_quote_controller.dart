import 'package:astro_brahmand/model/quote_category_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/model/daily_quote_model.dart';
import '../../../../utill/app_constants.dart';

class DailyQuoteController extends GetxController{

  final Dio _dio = Dio();
  final isLoading = false.obs;
  final isSuccess = false.obs;

  final isCategoryLoading = false.obs;
  final isCategorySuccess = false.obs;


  DailyQuoteModel dailyQuoteModel = DailyQuoteModel();
  List<DailyQuoteData> dailyQuoteListData = [];
  num offsetCount = 0;
  bool isNoMoreData = false;
  ScrollController scrollController = ScrollController();

  QuoteCategoryModel quoteCategoryModel = QuoteCategoryModel();

  //Filter
  String categorySelected = "";
  RxInt selectedIndex = 0.obs;

  void selectCategory(int index) {
    selectedIndex.value = index;
    offsetCount = 0; // Reset offset when category is changed
    isNoMoreData = false; // Reset no more data flag
  }

  // void selectCategory(int index) {
  //   selectedIndex.value = index;
  //   offsetCount = 0; // Reset offset when category is changed
  //   isNoMoreData = false; // Reset no more data flag
  //   dailyQuoteListData.clear(); // Clear the existing data
  //
  //   String? selectedCategoryId = index == 0 ? "" : quoteCategoryModel.data?[index - 1].id.toString();
  //
  //   // Debug log to check categoryId
  //   print("Selected Index: $index");
  //   print("Selected Category ID: $selectedCategoryId");
  //
  //   getQuote(offsetCount, selectedCategoryId!);
  // }

  @override
  void onInit() {
    super.onInit();
    getQuoteCategory();
    getQuote(offsetCount,"");

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if(isLoading.isFalse && !isNoMoreData) {
          getQuote(offsetCount,"");
        }
      }
    });
  }


  Future<void> getQuote(num offset, String categoryId) async {
    print("Fetching quotes for categoryId: $categoryId");
    isLoading(true);
    try {

      final response = await _dio.post(AppConstants.getQuote,data: {
         "offset": offset,
        "quote_category_id": categoryId
      });
      print("API Response: ${response.data}");
      if (response.statusCode == 200) {
        dailyQuoteModel = DailyQuoteModel.fromJson(response.data);
        if (dailyQuoteModel.status == AppConstants.success) {
          offsetCount = dailyQuoteModel.offset!;
          isSuccess(true);

          for (var element in (dailyQuoteModel.data ?? [])) {
            dailyQuoteListData.add(element);
          }
        } else {
          if(offset == 0){
            isSuccess(false);
          }
          isNoMoreData = true;
        }
      }
      else {
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

  Future<void> getQuoteCategory() async {
    isCategoryLoading(true);
    try {

      final response = await _dio.post(AppConstants.getQuoteCategory);
      if (response.statusCode == 200) {
        quoteCategoryModel = QuoteCategoryModel.fromJson(response.data);
        if(quoteCategoryModel.status == AppConstants.success){
          isCategorySuccess(true);
        }
        else{
          isCategorySuccess(false);
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      isCategorySuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isCategoryLoading(false);
    }
  }

}