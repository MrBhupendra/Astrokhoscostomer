class ChatHistoryModel {
  ChatHistoryModel({
    this.status,
    this.data,
    this.page,
    this.msg,
  });

  ChatHistoryModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    page = json['page'];
    msg = json['msg'];
  }

  num? status;
  List<Data>? data;
  num? page;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['page'] = page;
    map['msg'] = msg;
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.parentId,
    this.channelName,
    this.userUniId,
    this.uniqeid,
    this.message,
    this.selectedText,
    this.selectedType,
    this.fileUrl,
    this.messageType,
    this.firebaseMessageId,
    this.deliveryStatus,
    this.deliveredAt,
    this.readAt,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.userImageUrl,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    parentId = json['parent_id'];
    channelName = json['channel_name'];
    userUniId = json['user_uni_id'];
    uniqeid = json['uniqeid'];
    message = json['message'];
    selectedText = json['selected_text'];
    selectedType = json['selected_type'];
    fileUrl = json['file_url'];
    messageType = json['message_type'];
    firebaseMessageId = json['firebase_message_id'] ?? json['message_id'];
    deliveryStatus = json['delivery_status'] ?? json['deliveryStatus'];
    deliveredAt = json['delivered_at'] ?? json['deliveredAt'];
    readAt = json['read_at'] ?? json['readAt'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userName = json['user_name'];
    userImageUrl = json['user_image_url'];
  }

  num? id;
  String? parentId;
  String? channelName;
  String? userUniId;
  String? uniqeid;
  String? message;
  String? selectedText;
  String? selectedType;
  String? fileUrl;
  String? messageType;
  String? firebaseMessageId;
  dynamic deliveryStatus;
  dynamic deliveredAt;
  dynamic readAt;
  num? status;
  String? createdAt;
  String? updatedAt;
  String? userName;
  String? userImageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['parent_id'] = parentId;
    map['channel_name'] = channelName;
    map['user_uni_id'] = userUniId;
    map['uniqeid'] = uniqeid;
    map['message'] = message;
    map['selected_text'] = selectedText;
    map['selected_type'] = selectedType;
    map['file_url'] = fileUrl;
    map['message_type'] = messageType;
    map['firebase_message_id'] = firebaseMessageId;
    map['delivery_status'] = deliveryStatus;
    map['delivered_at'] = deliveredAt;
    map['read_at'] = readAt;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['user_name'] = userName;
    map['user_image_url'] = userImageUrl;
    return map;
  }
}
