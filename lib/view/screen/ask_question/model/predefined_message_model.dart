class PredefinedMessageModel {
  PredefinedMessageModel({
      this.status, 
      this.msg, 
      this.offset, 
      this.predefinedMessages,});

  PredefinedMessageModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    offset = json['offset'];
    if (json['predefined_messages'] != null) {
      predefinedMessages = [];
      json['predefined_messages'].forEach((v) {
        predefinedMessages?.add(PredefinedMessages.fromJson(v));
      });
    }
  }
  num? status;
  String? msg;
  num? offset;
  List<PredefinedMessages>? predefinedMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    map['offset'] = offset;
    if (predefinedMessages != null) {
      map['predefined_messages'] = predefinedMessages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class PredefinedMessages {
  PredefinedMessages({
      this.id, 
      this.userUniId, 
      this.message, 
      this.createdBy, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  PredefinedMessages.fromJson(dynamic json) {
    id = json['id'];
    userUniId = json['user_uni_id'];
    message = json['message'];
    createdBy = json['created_by'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? userUniId;
  String? message;
  String? createdBy;
  num? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_uni_id'] = userUniId;
    map['message'] = message;
    map['created_by'] = createdBy;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}