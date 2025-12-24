import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../model/success_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../chat/model/chat_channel_list_model.dart';
class SupportTabController extends FullLifeCycleController with FullLifeCycleMixin {
  final Dio _dio = Dio();
  final isLoading = false.obs;
  final isSuccess = false.obs;
  ChatChannelListModel chatChannelListModel = ChatChannelListModel();


  Future<void> getChatChannelsList(int isAssistantChannel) async {
    isLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      debugPrint("[ASSISTANT-CHAT] getChatChannelsList request=> $apiKey $uniId $isAssistantChannel");
      final response = await _dio.post(AppConstants.getChatChannelsList, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'is_assistant_chat' : isAssistantChannel
      });

      debugPrint("[ASSISTANT-CHAT] getChatChannelsList response=> ${response.data.toString()}");
      if (response.statusCode == 200) {
        chatChannelListModel = ChatChannelListModel.fromJson(response.data);
        if (chatChannelListModel.status == AppConstants.success) {
          isSuccess(true);
        } else {
          isSuccess(false);
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

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
