class GetImageModel {
  GetImageModel({
      this.status, 
      this.data, 
      this.msg,});

  GetImageModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  List<Data>? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.userUniId, 
      this.uniqeid, 
      this.callType, 
      this.fileUrl, 
      this.fileType, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    userUniId = json['user_uni_id'];
    uniqeid = json['uniqeid'];
    callType = json['call_type'];
    fileUrl = json['file_url'];
    fileType = json['file_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? userUniId;
  String? uniqeid;
  String? callType;
  String? fileUrl;
  String? fileType;
  num? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_uni_id'] = userUniId;
    map['uniqeid'] = uniqeid;
    map['call_type'] = callType;
    map['file_url'] = fileUrl;
    map['file_type'] = fileType;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}