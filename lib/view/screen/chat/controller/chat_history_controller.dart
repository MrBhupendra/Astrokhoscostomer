import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../model/success_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_snack_bar.dart';
import '../model/chat_channel_list_model.dart';
import '../model/chat_history_model.dart';
import '../model/chat_message_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class ChatHistoryController extends FullLifeCycleController
    with FullLifeCycleMixin {
  final isLoading = false.obs;
  final isSuccess = false.obs;
  ChatChannelListModel chatChannelListModel = ChatChannelListModel();

  final isDeleteLoading = false.obs;
  final isDeleteSuccess = false.obs;
  SuccessModel deleteModel = SuccessModel();

  String? uniId;

  //Chat history
  final Dio _dio = Dio();
  final isChatHistoryLoading = false.obs;
  final isChatHistorySuccess = false.obs;
  ChatHistoryModel chatHistoryModel = ChatHistoryModel();
  RxList<ChatMessageModel> chatHistoryList = <ChatMessageModel>[].obs;

  //Scroll
  ScrollController scrollController = ScrollController();
  num offsetCount = 1;
  bool isNoMoreData = false;

  //Data
  String? astrologerName;
  String? astrologerImage;
  String? channelName;

  @override
  void onInit() {
    super.onInit();
    getChatChannelsList();

    AppLogger.d('OnInit ChatScreen');
  }

  Future<void> getChatChannelsList() async {
    isLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      AppLogger.d("[CHAT] getChatChannelsList request=> $apiKey $uniId 0");
      final response = await _dio.post(AppConstants.getChatChannelsList, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'is_assistant_chat' : 0
      });

      AppLogger.d("[CHAT] getChatChannelsList response=> ${response.data.toString()}");
      if (response.statusCode == 200) {
        chatChannelListModel = ChatChannelListModel.fromJson(response.data);
        if (chatChannelListModel.status == AppConstants.success) {
          isSuccess(true);
        } else {
          isSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getChatHistory(String channelName, String firstMsgId, num page) async {
    if (page == 1) {
      offsetCount = 1;
      isNoMoreData = false;
      chatHistoryList.clear();
    }
    isChatHistoryLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      AppLogger.d("[CHAT] getChatHistory request=> $apiKey $uniId $channelName $firstMsgId $page");
      final response = await _dio.post(AppConstants.getChatHistory, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'channel_name': channelName,
        'first_msg_id': firstMsgId,
        'page': page
      });
      AppLogger.d("[CHAT] getChatHistory response=> ${response.data.toString()}");
      if (response.statusCode == 200) {
        chatHistoryModel = ChatHistoryModel.fromJson(response.data);
        if (chatHistoryModel.status == AppConstants.success) {
          offsetCount = chatHistoryModel.page!;
          isChatHistorySuccess(true);

          if (chatHistoryModel.data!.isNotEmpty) {
            chatHistoryModel.data?.forEach((message) {
              var cm = ChatMessageModel(
                  senderUniId: message.userUniId,
                  name: message.userName,
                  text: message.message,
                  fileUrl: message.fileUrl,
                  date: message.createdAt,
                  messageType: message.messageType,
                  profileImageUrl: message.userImageUrl,
                  selectedText: message.selectedText,
                  selectedType: message.selectedType);
              chatHistoryList.add(cm);
            });
          } else {
            isNoMoreData = true;
          }
        } else {
          AppLogger.d('getChatHistory API Response else: ${response.data.toString()}');
          if (page == 1) {
            isChatHistorySuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isChatHistorySuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isChatHistoryLoading(false);
    }
  }

  Future<void> deleteChatChannels(int index, num id) async {
    isDeleteLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      AppLogger.d("[CHAT] deleteChatChannels request=> $apiKey $uniId $id");
      final response = await _dio.post(AppConstants.deleteChatChannel, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'id': id
      });
      AppLogger.d("[CHAT] deleteChatChannels response=> ${response.data.toString()}");
      if (response.statusCode == 200) {
        deleteModel = SuccessModel.fromJson(response.data);
        CustomSnackBar.showBottom(deleteModel.msg.toString());
        if(deleteModel.status == AppConstants.success){
          isDeleteSuccess(true);
          chatChannelListModel.data!.removeAt(index);
          getChatChannelsList();
        }
        else{
          isDeleteSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isDeleteLoading(false);
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
