class SuccessModel {
  SuccessModel({
      this.status, 
      this.msg,});

  SuccessModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
  }
  num? status;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    return map;
  }

}