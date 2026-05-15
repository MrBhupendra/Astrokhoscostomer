import 'dart:math' as math;

class ChatMessageModel {
  ChatMessageModel({
    this.messageId,
    this.senderUniId,
    this.name,
    this.text,
    this.profileImageUrl,
    this.date,
    this.fileUrl,
    this.selectedText,
    this.selectedType,
    this.messageType,
    this.deliveryStatus,
    this.deliveredAt,
    this.readAt,
  });

  ChatMessageModel.fromJson(dynamic json) {
    if (json is! Map) return;
    final m = json.map<String, dynamic>((k, v) => MapEntry(k.toString(), v));

    messageId = _pick(m, const ['messageId', 'message_id'])?.toString();
    senderUniId = _pick(m, const ['senderUniId', 'sender_uni_id'])?.toString();
    name = _pick(m, const ['name'])?.toString();
    text = _pick(m, const ['text'])?.toString();
    profileImageUrl =
        _pick(m, const ['profileImageUrl', 'profile_image_url'])?.toString();
    date = _pick(m, const ['date'])?.toString();
    fileUrl = _pick(m, const ['fileUrl', 'file_url'])?.toString();
    selectedText =
        _pick(m, const ['selectedText', 'selected_text'])?.toString();
    selectedType =
        _pick(m, const ['selectedType', 'selected_type'])?.toString();
    messageType =
        _pick(m, const ['messageType', 'message_type'])?.toString();

    deliveryStatus =
        (_pick(m, const ['deliveryStatus', 'delivery_status']) ?? 'sent')
            .toString();
    deliveredAt = _parseInt(_pick(m, const ['deliveredAt', 'delivered_at']));
    readAt = _parseInt(_pick(m, const ['readAt', 'read_at']));
  }

  static dynamic _pick(Map<String, dynamic> m, List<String> keys) {
    for (final k in keys) {
      if (m.containsKey(k) && m[k] != null) return m[k];
    }
    return null;
  }

  static int? _parseInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString());
  }

  /// RTDB [onChildChanged] can occasionally surface partial maps; merging with
  /// the previous row avoids regressing `sent` → `delivered` and uses
  /// timestamps when status text is missing.
  static ChatMessageModel mergeRealtimeSnapshot(
      ChatMessageModel prev, ChatMessageModel next) {
    final rank = math.max(_deliveryRank(prev), _deliveryRank(next));
    final status = _statusFromRank(rank);
    return ChatMessageModel(
      messageId: next.messageId ?? prev.messageId,
      senderUniId: next.senderUniId ?? prev.senderUniId,
      name: next.name ?? prev.name,
      text: next.text ?? prev.text,
      profileImageUrl: next.profileImageUrl ?? prev.profileImageUrl,
      date: next.date ?? prev.date,
      fileUrl: next.fileUrl ?? prev.fileUrl,
      selectedText: next.selectedText ?? prev.selectedText,
      selectedType: next.selectedType ?? prev.selectedType,
      messageType: next.messageType ?? prev.messageType,
      deliveryStatus: status,
      deliveredAt: next.deliveredAt ?? prev.deliveredAt,
      readAt: next.readAt ?? prev.readAt,
    );
  }

  static int _deliveryRank(ChatMessageModel m) {
    if ((m.readAt ?? 0) > 0) return 3;
    var s = (m.deliveryStatus ?? 'sent').toLowerCase().trim();
    if (s == 'seen') s = 'read';
    if (s == 'read') return 3;
    if (s == 'delivered') return 2;
    if ((m.deliveredAt ?? 0) > 0) return 2;
    return 1;
  }

  static String _statusFromRank(int r) {
    if (r >= 3) return 'read';
    if (r >= 2) return 'delivered';
    return 'sent';
  }

  String normalizedDeliveryStatus() {
    var s = (deliveryStatus ?? 'sent').toLowerCase().trim();
    if (s == 'seen') s = 'read';
    if (s == 'delivered' || s == 'read' || s == 'sent') return s;
    return 'sent';
  }

  String? messageId;
  String? senderUniId;
  String? name;
  String? text;
  String? profileImageUrl;
  String? date;
  String? fileUrl;
  String? selectedText;
  String? selectedType;
  String? messageType;
  String? deliveryStatus; // sent / delivered / read
  int? deliveredAt; // epoch ms
  int? readAt; // epoch ms

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['messageId'] = messageId;
    map['senderUniId'] = senderUniId;
    map['name'] = name;
    map['text'] = text;
    map['profileImageUrl'] = profileImageUrl;
    map['date'] = date;
    map['fileUrl'] = fileUrl;
    map['selectedText'] = selectedText;
    map['selectedType'] = selectedType;
    map['messageType'] = messageType;
    map['deliveryStatus'] = (deliveryStatus ?? 'sent');
    map['deliveredAt'] = deliveredAt;
    map['readAt'] = readAt;
    return map;
  }
}
