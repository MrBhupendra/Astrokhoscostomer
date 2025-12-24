import 'package:astro_brahmand/model/recharge_data.dart';

class PaypalModel {
  PaypalModel({
    this.status,
    this.msg,
    this.data,
    this.paypalData,
  });

  PaypalModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? RechargeData.fromJson(json['data']) : null;
    paypalData = json['paypal_data'] != null
        ? PaypalData.fromJson(json['paypal_data'])
        : null;
  }

  num? status;
  String? msg;
  RechargeData? data;
  PaypalData? paypalData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (paypalData != null) {
      map['paypal_data'] = paypalData?.toJson();
    }
    return map;
  }
}

class PaypalData {
  PaypalData({
    this.url,
    this.orderId,
  });

  PaypalData.fromJson(dynamic json) {
    url = json['url'];
    orderId = json['order_id'];
  }

  String? url;
  String? orderId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['order_id'] = orderId;
    return map;
  }
}
