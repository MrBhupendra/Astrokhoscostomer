import 'package:astro_brahmand/model/razorpay_model.dart';

class RazorpayWalletRechargeModel {
  RazorpayWalletRechargeModel({
      this.status, 
      this.msg, 
      this.data,});

  RazorpayWalletRechargeModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? PaymentGateway.fromJson(json['data']) : null;
  }
  num? status;
  String? msg;
  PaymentGateway? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}