import 'astrologer_model.dart';

class AstrologerDetailModel {
  AstrologerDetailModel({
      this.status, 
      this.data, 
      this.msg,});

  AstrologerDetailModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? AstrologerData.fromJson(json['data']) : null;
    msg = json['msg'];
  }
  num? status;
  AstrologerData? data;
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