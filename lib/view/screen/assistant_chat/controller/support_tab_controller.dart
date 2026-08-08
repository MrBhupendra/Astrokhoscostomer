import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/shared_preference.dart';
import '../assistant_chat_delivery_helper.dart';
import '../../chat/model/chat_channel_list_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class SupportTabController extends FullLifeCycleController with FullLifeCycleMixin {
  final Dio _dio = Dio();
  final isLoading = false.obs;
  final isSuccess = false.obs;
  ChatChannelListModel chatChannelListModel = ChatChannelListModel();

  /// Set from UI so lifecycle refresh only runs for assistant channel list.
  String? assistantListContextType;

  /// Unread incoming messages per channel row (`uniqeid` from API).
  final RxMap<String, int> unreadByUniqeid = <String, int>{}.obs;

  static const String _assistantMessagesRoot = 'ASSISTANT-MESSAGES';
  static const String _messagesChild = 'messages';

  static int _incomingUnreadFromSnapshot(DataSnapshot snap, String myUniId) {
    final raw = snap.value;
    if (raw == null) return 0;
    if (raw is! Map) return 0;
    var n = 0;
    for (final entry in raw.values) {
      if (entry is! Map) continue;
      final m = Map<Object?, Object?>.from(entry);
      final sender = '${m['senderUniId'] ?? ''}';
      if (sender.isEmpty || sender == myUniId) continue;
      final status =
          '${m['deliveryStatus'] ?? m['delivery_status'] ?? 'sent'}'
              .toLowerCase()
              .trim();
      if (status == 'read') continue;
      n++;
    }
    return n;
  }

  Future<void> _refreshUnreadBadgesFromFirebase() async {
    final rows = chatChannelListModel.data;
    if (rows == null || rows.isEmpty) {
      unreadByUniqeid.clear();
      return;
    }
    final myId = await SharedPreferencesHelper.getData(AppConstants.userUniId) ?? '';
    if (myId.isEmpty) {
      unreadByUniqeid.clear();
      return;
    }

    final db = FirebaseDatabase.instance;
    final out = <String, int>{};
    const batchSize = 6;
    for (var i = 0; i < rows.length; i += batchSize) {
      final end = math.min(i + batchSize, rows.length);
      final slice = rows.sublist(i, end);
      await Future.wait(slice.map((row) async {
        final cid = row.customerUniId?.toString() ?? '';
        final aid = row.astrologerUniId?.toString() ?? '';
        if (cid.isEmpty || aid.isEmpty) return;
        final channelName = '$cid-$aid';
        final uniq = row.uniqeid?.toString() ?? channelName;
        try {
          final snap = await db
              .ref(_assistantMessagesRoot)
              .child(channelName)
              .child(_messagesChild)
              .get();
          out[uniq] = _incomingUnreadFromSnapshot(snap, myId);
          await AssistantChatDeliveryHelper.markDeliveredFromMessagesSnapshot(
            channelName: channelName,
            messagesSnap: snap,
            myUniId: myId,
          );
        } catch (e) {
          AppLogger.d('[ASSISTANT-CHAT] unread badge RTDB error $channelName => $e');
          out[uniq] = 0;
        }
      }));
    }
    unreadByUniqeid.assignAll(out);
  }

  Future<void> getChatChannelsList(int isAssistantChannel) async {
    isLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      AppLogger.d("[ASSISTANT-CHAT] getChatChannelsList request=> $apiKey $uniId $isAssistantChannel");
      final response = await _dio.post(AppConstants.getChatChannelsList, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'is_assistant_chat' : isAssistantChannel
      });

      AppLogger.d("[ASSISTANT-CHAT] getChatChannelsList response=> ${response.data.toString()}");
      if (response.statusCode == 200) {
        chatChannelListModel = ChatChannelListModel.fromJson(response.data);
        if (chatChannelListModel.status == AppConstants.success) {
          isSuccess(true);
          if (isAssistantChannel == 1) {
            await _refreshUnreadBadgesFromFirebase();
          }
        } else {
          isSuccess(false);
          unreadByUniqeid.clear();
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
    if (assistantListContextType == 'Astrologer') {
      getChatChannelsList(1);
    }
  }
}
