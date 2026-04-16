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
    this.deliveryStatus = 'sent',
    this.deliveredAt,
    this.readAt,
  });

  ChatMessageModel.fromJson(dynamic json) {
    messageId = json['messageId'] ?? json['message_id'] ?? json['firebase_message_id'];
    senderUniId = json['senderUniId'];
    name = json['name'];
    text = json['text'];
    profileImageUrl = json['profileImageUrl'];
    date = json['date'];
    fileUrl = json['fileUrl'];
    selectedText = json['selectedText'];
    selectedType = json['selectedType'];
    messageType = json['messageType'];
    deliveryStatus =
        (json['deliveryStatus'] ?? json['delivery_status'] ?? 'sent').toString();
    deliveredAt = json['deliveredAt'] ?? json['delivered_at'];
    readAt = json['readAt'] ?? json['read_at'];
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
  String? deliveryStatus;
  String? deliveredAt;
  String? readAt;

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
    map['deliveryStatus'] = deliveryStatus ?? 'sent';
    map['deliveredAt'] = deliveredAt;
    map['readAt'] = readAt;
    return map;
  }
}
