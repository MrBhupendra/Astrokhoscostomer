class ServiceStartVideoCallModel {
  ServiceStartVideoCallModel({
      this.status, 
      this.msg, 
      this.minutes, 
      this.second, 
      this.available, 
      this.token,});

  ServiceStartVideoCallModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    minutes = json['minutes'];
    second = json['second'];
    available = json['available'];
    token = json['token'];
  }
  num? status;
  String? msg;
  num? minutes;
  num? second;
  num? available;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    map['minutes'] = minutes;
    map['second'] = second;
    map['available'] = available;
    map['token'] = token;
    return map;
  }

}