class NotificationModel {
  NotificationModel({
      this.status, 
      this.data,
    this.offset,
    this.msg,});

  NotificationModel.fromJson(dynamic json) {
    status = json['status'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(NotificationData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  List<NotificationData>? data;
  String? msg;
  num? offset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['offset'] = offset;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class NotificationData {
  NotificationData({
      this.id, 
      this.userUniId, 
      this.title, 
      this.image, 
      this.msg, 
      this.status, 
      this.sendStatus, 
      this.notificationId, 
      this.createdAt, 
      this.updatedAt,
      this.isRead,
  });

  NotificationData.fromJson(dynamic json) {
    id = json['id'];
    userUniId = json['user_uni_id'];
    title = json['title'];
    image = json['image'];
    msg = json['msg'];
    status = json['status'];
    sendStatus = json['send_status'];
    notificationId = json['notification_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isRead = json['is_read'] == 1;
  }
  num? id;
  String? userUniId;
  String? title;
  String? image;
  String? msg;
  num? status;
  num? sendStatus;
  num? notificationId;
  String? createdAt;
  String? updatedAt;
  bool? isRead;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_uni_id'] = userUniId;
    map['title'] = title;
    map['image'] = image;
    map['msg'] = msg;
    map['status'] = status;
    map['send_status'] = sendStatus;
    map['notification_id'] = notificationId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_read'] = isRead == true ? 1 : 0;
    return map;
  }

}