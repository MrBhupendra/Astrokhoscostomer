class GroupPujaRemainingTimeModel {
  GroupPujaRemainingTimeModel({
      this.status, 
      this.msg, 
      this.minutes, 
      this.second,});

  GroupPujaRemainingTimeModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    minutes = json['minutes'];
    second = json['second'];
  }
  num? status;
  String? msg;
  num? minutes;
  num? second;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    map['minutes'] = minutes;
    map['second'] = second;
    return map;
  }

}