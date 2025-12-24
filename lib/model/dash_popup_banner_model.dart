class DashPopupBannerModel {
  DashPopupBannerModel({
      this.status, 
      this.data, 
      this.msg,});

  DashPopupBannerModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
  }
  num? status;
  Data? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['msg'] = msg;
    return map;
  }

}

class Data {
  Data({
    this.id,
    this.title,
    this.type,
    this.description,
    this.noticeImage,
    this.noticeFor,
    this.status,
    this.createdAt,
    this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    description = json['description'];
    noticeImage = json['notice_image'];
    noticeFor = json['notice_for'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? title;
  String? type;
  String? description;
  String? noticeImage;
  String? noticeFor;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['type'] = type;
    map['description'] = description;
    map['notice_image'] = noticeImage;
    map['notice_for'] = noticeFor;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}