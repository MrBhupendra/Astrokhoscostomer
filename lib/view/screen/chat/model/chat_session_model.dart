class ChatSessionModel {
  ChatSessionModel({
    this.chatEnd,
    this.chatAccepted,
    this.chatId,
    this.customerStatus,
    this.duration,
    this.chatDeclinedBy,
    this.type
  });

  ChatSessionModel.fromJson(dynamic json) {
    chatEnd = json['chatEnd'];
    chatAccepted = json['chatAccepted'];
    chatId = json['chatId'];
    customerStatus = json['customer_status'];
    duration = json['duration'];
    chatDeclinedBy = json['chatDeclinedBy'];
    type = json['type'];
  }

  bool? chatEnd;
  bool? chatAccepted;
  String? chatId;
  bool? customerStatus;
  num? duration;
  String? chatDeclinedBy;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chatEnd'] = chatEnd;
    map['chatAccepted'] = chatAccepted;
    map['chatId'] = chatId;
    map['customer_status'] = customerStatus;
    map['duration'] = duration;
    map['chatDeclinedBy'] = chatDeclinedBy;
    map['type'] = type;
    return map;
  }
}
