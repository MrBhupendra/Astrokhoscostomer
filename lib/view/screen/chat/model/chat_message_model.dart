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
    messageId = json['messageId']?.toString();
    senderUniId = json['senderUniId'];
    name = json['name'];
    text = json['text'];
    profileImageUrl = json['profileImageUrl'];
    date = json['date'];
    fileUrl = json['fileUrl'];
    selectedText = json['selectedText'];
    selectedType = json['selectedType'];
    messageType = json['messageType'];

    deliveryStatus = (json['deliveryStatus'] ?? 'sent')?.toString() ?? 'sent';
    deliveredAt = _parseInt(json['deliveredAt']);
    readAt = _parseInt(json['readAt']);
  }

  static int? _parseInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString());
  }

  String normalizedDeliveryStatus() {
    final s = (deliveryStatus ?? 'sent').toLowerCase().trim();
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
