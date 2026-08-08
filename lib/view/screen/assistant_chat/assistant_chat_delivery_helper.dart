import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/shared_preference.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
/// Marks assistant chat messages as **delivered** when they reach this device
/// (push notification, channel list RTDB sync, etc.) — not only when chat opens.
class AssistantChatDeliveryHelper {
  AssistantChatDeliveryHelper._();

  static const String _messagesRoot = 'ASSISTANT-MESSAGES';
  static const String _messagesChild = 'messages';

  /// Avoid duplicate RTDB/API writes per app session.
  static final Set<String> _deliveredOnce = <String>{};

  static String deliveryTimestamp() {
    final now = DateTime.now();
    final d =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final t =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    return '$d $t';
  }

  static bool isAssistantFcmPayload(Map<String, dynamic> data) {
    final type = (data['type'] ?? '').toString().toLowerCase();
    if (type != 'message') return false;
    final raw =
        (data['channelName'] ?? data['channel_name'] ?? '').toString();
    final notificationType =
        (data['notification_type'] ?? '').toString().toLowerCase();
    return raw.startsWith('ASSISTANT/') ||
        notificationType == 'assistant_chat';
  }

  static String parseChannelSegment(Map<String, dynamic> data) {
    final raw =
        (data['channelName'] ?? data['channel_name'] ?? '').toString().trim();
    if (raw.isEmpty) return '';
    return raw.contains('/') ? raw.split('/').last : raw;
  }

  static String? parseFirebaseMessageId(Map<String, dynamic> data) {
    for (final key in const [
      'firebase_message_id',
      'firebaseMessageId',
      'message_id',
      'messageId',
    ]) {
      final v = data[key]?.toString().trim();
      if (v != null && v.isNotEmpty) return v;
    }
    return null;
  }

  /// Awesome [NotificationContent.id] must be unique per push. For assistant chat
  /// the backend often reuses the same [notification_id] for every message in a
  /// thread, so Android replaces the previous notification instead of stacking them.
  ///
  /// Payload [notification_id] is unchanged — only the local display id differs.
  static int awesomeDisplayIdForMessage(
    Map<String, dynamic> data, {
    String? fcmMessageId,
  }) {
    final backendId =
        int.tryParse((data['notification_id'] ?? '').toString()) ?? -1;

    final fbId = parseFirebaseMessageId(data);
    if (fbId != null) {
      return _positiveHash('asst_fb:$fbId');
    }
    final mid = fcmMessageId?.trim() ?? '';
    if (mid.isNotEmpty) {
      return _positiveHash('asst_fcm:$mid');
    }
    final channel = parseChannelSegment(data);
    final body = (data['body'] ?? '').toString();
    final title = (data['title'] ?? '').toString();
    if (body.isNotEmpty || title.isNotEmpty) {
      return _positiveHash('asst:$channel|$title|$body');
    }
    if (backendId > 0) return backendId;
    return _positiveHash('asst_ts:${DateTime.now().microsecondsSinceEpoch}');
  }

  static int _positiveHash(String key) {
    var h = key.hashCode;
    if (h == 0) h = 1;
    return h.abs().clamp(1, 0x7FFFFFFF);
  }

  /// Call when an assistant message push is shown (foreground/background).
  static Future<void> markDeliveredFromFcmData(
      Map<String, dynamic> data) async {
    if (!isAssistantFcmPayload(data)) return;
    final channel = parseChannelSegment(data);
    if (channel.isEmpty) return;

    final messageId = parseFirebaseMessageId(data);
    if (messageId != null) {
      await markMessageDelivered(channelName: channel, messageId: messageId);
    } else {
      await markAllIncomingSentAsDelivered(channel);
    }
  }

  /// After reading RTDB for unread badges, mark incoming `sent` as delivered.
  static Future<void> markDeliveredFromMessagesSnapshot({
    required String channelName,
    required DataSnapshot messagesSnap,
    required String myUniId,
  }) async {
    final raw = messagesSnap.value;
    if (raw is! Map || myUniId.isEmpty) return;

    for (final entry in raw.entries) {
      final id = entry.key?.toString() ?? '';
      if (id.isEmpty) continue;
      final value = entry.value;
      if (value is! Map) continue;
      final m = value.map<String, dynamic>((k, v) => MapEntry(k.toString(), v));
      final sender =
          '${m['senderUniId'] ?? m['sender_uni_id'] ?? ''}'.trim();
      if (sender.isEmpty || sender == myUniId) continue;
      final status =
          '${m['deliveryStatus'] ?? m['delivery_status'] ?? 'sent'}'
              .toLowerCase()
              .trim();
      if (status != 'sent') continue;
      await markMessageDelivered(channelName: channelName, messageId: id);
    }
  }

  static Future<void> markAllIncomingSentAsDelivered(String channelName) async {
    final myId =
        await SharedPreferencesHelper.getData(AppConstants.userUniId) ?? '';
    if (myId.isEmpty) return;

    try {
      final snap = await FirebaseDatabase.instance
          .ref(_messagesRoot)
          .child(channelName)
          .child(_messagesChild)
          .get();
      await markDeliveredFromMessagesSnapshot(
        channelName: channelName,
        messagesSnap: snap,
        myUniId: myId,
      );
    } catch (e) {
      AppLogger.d('[AssistantChatDelivery] markAllIncomingSent $channelName => $e');
    }
  }

  static Future<void> markMessageDelivered({
    required String channelName,
    required String messageId,
  }) async {
    final dedupeKey = '$channelName:$messageId';
    if (_deliveredOnce.contains(dedupeKey)) return;

    final myId =
        await SharedPreferencesHelper.getData(AppConstants.userUniId) ?? '';
    if (myId.isEmpty) return;

    final ref = FirebaseDatabase.instance
        .ref(_messagesRoot)
        .child(channelName)
        .child(_messagesChild)
        .child(messageId);

    try {
      final snap = await ref.get();
      if (!snap.exists || snap.value is! Map) return;
      final m = (snap.value as Map)
          .map<String, dynamic>((k, v) => MapEntry(k.toString(), v));
      final sender =
          '${m['senderUniId'] ?? m['sender_uni_id'] ?? ''}'.trim();
      if (sender.isEmpty || sender == myId) return;
      final status =
          '${m['deliveryStatus'] ?? m['delivery_status'] ?? 'sent'}'
              .toLowerCase()
              .trim();
      if (status != 'sent') {
        _deliveredOnce.add(dedupeKey);
        return;
      }

      _deliveredOnce.add(dedupeKey);
      final deliveredAt = deliveryTimestamp();

      await ref.update({
        'deliveryStatus': 'delivered',
        'deliveredAt': ServerValue.timestamp,
      });

      await _updateChatMessageStatusApi(
        firebaseMessageId: messageId,
        deliveryStatus: 'delivered',
        deliveredAt: deliveredAt,
      );
    } catch (e) {
      _deliveredOnce.remove(dedupeKey);
      AppLogger.d('[AssistantChatDelivery] markMessageDelivered $dedupeKey => $e');
    }
  }

  static Future<void> _updateChatMessageStatusApi({
    required String firebaseMessageId,
    required String deliveryStatus,
    String? deliveredAt,
    String? readAt,
  }) async {
    try {
      final apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      final userUniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      if (apiKey == null || apiKey.toString().isEmpty) return;
      if (userUniId == null || userUniId.toString().isEmpty) return;

      final data = <String, dynamic>{
        'api_key': apiKey,
        'user_uni_id': userUniId,
        'firebase_message_id': firebaseMessageId,
        'delivery_status': deliveryStatus,
      };
      if (deliveredAt != null) data['delivered_at'] = deliveredAt;
      if (readAt != null) data['read_at'] = readAt;

      await Dio()
          .post(
            AppConstants.updateChatMessageStatus,
            data: FormData.fromMap(data),
          )
          .timeout(const Duration(seconds: 20));
    } catch (e) {
      AppLogger.d('[AssistantChatDelivery] API $firebaseMessageId => $e');
    }
  }
}
