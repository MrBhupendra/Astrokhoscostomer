import 'package:astro_brahmand/view/screen/slot_booking/model/slot_availability_list_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/success_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_dialogs.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../chat/controller/chat_intake_form_controller.dart';

class SlotBookingController extends GetxController {
  final Dio _dio = Dio();
  //SlotAvailability
  final isScheduleLoading = false.obs;
  final isScheduleSuccess = false.obs;
  SlotAvailabilityListModel slotAvailabilityModel = SlotAvailabilityListModel();
  List<SlotAvailabilityListData> slotAvailabilityListData = [];

  num offsetCount = 0;
  bool isNoMoreData = false;
  ScrollController scrollController = ScrollController();

  //Add
  SuccessModel bookScheduleModel = SuccessModel();

  SlotList selectedSlot = SlotList();
  String selectedScheduleId = "";

  void selectSlot(SlotList slot, String scheduleId){
    selectedSlot = slot;
    selectedScheduleId = scheduleId;

  }

  Future<void> getSchedules(num offset, String astrologerUniId) async {
    if (offset == 0) {
      offsetCount = 0;
      isNoMoreData = false;
      slotAvailabilityListData.clear();
    }
    isScheduleLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getAstrologerSlotList,
          data: {'api_key': apiKey,
            'customer_uni_id': uniId,
            "astrologer_uni_id": astrologerUniId});
      if (response.statusCode == 200) {
        slotAvailabilityModel = SlotAvailabilityListModel.fromJson(response.data);
        if (slotAvailabilityModel.status == AppConstants.success) {
          // offsetCount = slotAvailabilityModel.offset!;
          isScheduleSuccess(true);

          for (var element in (slotAvailabilityModel.data ?? [])) {
            slotAvailabilityListData.add(element);
          }
        } else {
          if (offset == 0) {
            isScheduleSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      isScheduleSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isScheduleLoading(false);
    }
  }

  Future<void> bookSchedule(String astrologerUniId,String slotStart,String slotEnd,String serialNo,String scheduleId) async {
    CustomProgressDialog.showDialog();
    String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
    String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
    try {
      print("$apiKey $uniId $astrologerUniId $slotStart $slotEnd $serialNo $scheduleId");
      final response = await _dio.post(AppConstants.bookAstroSchedule, data: {
        'api_key': apiKey,
        'customer_uni_id': uniId,
        "astrologer_uni_id": astrologerUniId,
        'slot_start': slotStart,
        'slot_end': slotEnd,
        'serial_no': serialNo,
        'schedule_id': scheduleId
      });

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        bookScheduleModel = SuccessModel.fromJson(response.data);
        if (bookScheduleModel.status == AppConstants.success) {
          // final ChatIntakeFormController chatIntakeFormController = Get.find();
          // chatIntakeFormController.saveIntakeData(chatSuccessModel.data?.uniqeid.toString(), AppConstants.slot);
          AppDialog().showPaymentSuccessDialog(AppConstants.slotBooking);
        } else {
          CustomSnackBar.showBottom(bookScheduleModel.msg.toString());
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      if (kDebugMode) {
        print('OnException==> $e');
      }
    }
  }
}