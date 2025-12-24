class QuestionHistoryListModel {
  QuestionHistoryListModel({
      this.status, 
      this.page, 
      this.openAIProfile, 
      this.data, 
      this.msg,});

  QuestionHistoryListModel.fromJson(dynamic json) {
    status = json['status'];
    page = json['page'];
    openAIProfile = json['openAIProfile'] != null ? OpenAiProfile.fromJson(json['openAIProfile']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(QuestionHistoryData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  num? page;
  OpenAiProfile? openAIProfile;
  List<QuestionHistoryData>? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['page'] = page;
    if (openAIProfile != null) {
      map['openAIProfile'] = openAIProfile?.toJson();
    }
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class QuestionHistoryData {
  QuestionHistoryData({
      this.userUniId, 
      this.userName, 
      this.userImageUrl, 
      this.message, 
      this.messageType, 
      this.status, 
      this.createdAt,});

  QuestionHistoryData.fromJson(dynamic json) {
    userUniId = json['user_uni_id'];
    userName = json['user_name'];
    userImageUrl = json['user_image_url'];
    message = json['message'];
    messageType = json['message_type'];
    status = json['status'];
    createdAt = json['created_at'];
  }
  String? userUniId;
  String? userName;
  String? userImageUrl;
  String? message;
  String? messageType;
  num? status;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_uni_id'] = userUniId;
    map['user_name'] = userName;
    map['user_image_url'] = userImageUrl;
    map['message'] = message;
    map['message_type'] = messageType;
    map['status'] = status;
    map['created_at'] = createdAt;
    return map;
  }

}

class OpenAiProfile {
  OpenAiProfile({
      this.name, 
      this.gender, 
      this.dob, 
      this.tob, 
      this.pob, 
      this.lat, 
      this.lon,});

  OpenAiProfile.fromJson(dynamic json) {
    name = json['name'];
    gender = json['gender'];
    dob = json['dob'];
    tob = json['tob'];
    pob = json['pob'];
    lat = json['lat'];
    lon = json['lon'];
  }
  String? name;
  String? gender;
  String? dob;
  String? tob;
  String? pob;
  String? lat;
  String? lon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['gender'] = gender;
    map['dob'] = dob;
    map['tob'] = tob;
    map['pob'] = pob;
    map['lat'] = lat;
    map['lon'] = lon;
    return map;
  }

}