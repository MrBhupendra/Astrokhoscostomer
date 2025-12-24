class ChatSuccessModel {
  ChatSuccessModel({
    this.status,
    this.errorCode,
    this.joinStatus,
    this.intakeStatus,
    this.data,
    this.msg,
  });

  ChatSuccessModel.fromJson(dynamic json) {
    status = json['status'];
    errorCode = json['error_code'];
    joinStatus = json['join_status'];
    intakeStatus = json['intake_status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  num? status;
  num? joinStatus;
  num? intakeStatus;
  Data? data;
  String? msg;
  num? errorCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['error_code'] = errorCode;
    map['join_status'] = joinStatus;
    map['intake_status'] = intakeStatus;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['msg'] = msg;
    return map;
  }
}

class Data {
  Data({
    this.minutes,
    this.second,
    this.uniqeid,
    this.name,
    this.agoraToken,
  });

  Data.fromJson(dynamic json) {
    minutes = json['minutes'];
    second = json['second'];
    uniqeid = json['uniqeid'];
    name = json['name'];
    agoraToken = json['token'];
  }

  num? minutes;
  num? second;
  String? uniqeid;
  String? name;
  String? agoraToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['minutes'] = minutes;
    map['second'] = second;
    map['uniqeid'] = uniqeid;
    map['name'] = name;
    map['token'] = agoraToken;
    return map;
  }
}
