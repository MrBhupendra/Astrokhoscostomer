import 'package:astro_brahmand/model/pdf_book_purchase_list_model.dart';
import 'package:astro_brahmand/model/sanjeevini_purchase_list_model.dart';
import 'package:astro_brahmand/model/switchword_purchase_list_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../../vedic_and_jyotisham_astro/model/report_order_list_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class PaidServiceOrderController extends GetxController {

  final Dio _dio = Dio();
  final isLoading = false.obs;
  final isSuccess = false.obs;

  // num offsetCount = 0;
  // bool isNoMoreData = false;
  // ScrollController scrollController = ScrollController();

  final isSanjeeviniLoading = false.obs;
  final isSanjeeviniSuccess = false.obs;
  SanjeeviniPurchaseListModel sanjeeviniPurchaseListModel = SanjeeviniPurchaseListModel();

  final isDivineLoading = false.obs;
  final isDivineSuccess = false.obs;
  SwitchwordPurchaseListModel switchwordPurchaseListModel = SwitchwordPurchaseListModel();

  final isEbookLoading = false.obs;
  final isEbookSuccess = false.obs;
  PdfBookPurchaseListModel pdfBookPurchaseListModel = PdfBookPurchaseListModel();

  final isReportLoading = false.obs;
  final isReportSuccess = false.obs;
  ReportOrderListModel reportOrderListModel = ReportOrderListModel();

  Future<void> sanjeeviniPurchaseList() async {
    isSanjeeviniLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.sanjeeviniPurchaseList, data: {
        'api_key': apiKey,
        'user_uni_id': uniId
      });
      if (response.statusCode == 200) {

        sanjeeviniPurchaseListModel = SanjeeviniPurchaseListModel.fromJson(response.data);
        if(sanjeeviniPurchaseListModel.status == AppConstants.success){
          isSanjeeviniSuccess(true);
        }
        else{
          isSanjeeviniSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isSanjeeviniLoading(false);
    }
  }

  Future<void> switchWordPurchaseList() async {
    isDivineLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.switchWordPurchaseList, data: {
        'api_key': apiKey,
        'user_uni_id': uniId
      });
      if (response.statusCode == 200) {

        switchwordPurchaseListModel = SwitchwordPurchaseListModel.fromJson(response.data);
        if(switchwordPurchaseListModel.status == AppConstants.success){
          isDivineSuccess(true);
        }
        else{
          isDivineSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isDivineLoading(false);
    }
  }

  Future<void> pdfBookPurchaseList() async {
    isEbookLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.bookPurchaseList, data: {
        'api_key': apiKey,
        'user_uni_id': uniId
      });
      if (response.statusCode == 200) {

        pdfBookPurchaseListModel = PdfBookPurchaseListModel.fromJson(response.data);
        if(pdfBookPurchaseListModel.status == AppConstants.success){
          isEbookSuccess(true);
        }
        else{
          isEbookSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isEbookLoading(false);
    }
  }

  Future<void> getReportOrderList(int offset) async {
    isReportLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.reportHoroscopeOrderList, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "offset": offset
      });

      if (response.statusCode == 200) {
        reportOrderListModel = ReportOrderListModel.fromJson(response.data);
        if (reportOrderListModel.status == AppConstants.success) {
          isReportSuccess(true);
        } else {
          isReportSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isReportSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isReportLoading(false);
    }
  }


}