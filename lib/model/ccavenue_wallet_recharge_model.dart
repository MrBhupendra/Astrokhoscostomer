import 'package:astro_brahmand/model/recharge_data.dart';

class CcAvenueWalletRechargeModel {
  CcAvenueWalletRechargeModel(
      {this.status,
      this.msg,
      this.ccavenueData,
      this.data,
      this.paymentGatewayStatus,
        this.orderId});

  CcAvenueWalletRechargeModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    ccavenueData = json['ccavenue_data'] != null
        ? CcavenueData.fromJson(json['ccavenue_data'])
        : null;
    data = json['data'] != null ? RechargeData.fromJson(json['data']) : null;
    paymentGatewayStatus = json['payment_gateway_status'];
    orderId = json['order_id'];
  }

  num? status;
  String? msg;
  CcavenueData? ccavenueData;
  RechargeData? data;
  num? paymentGatewayStatus;
  dynamic orderId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (ccavenueData != null) {
      map['ccavenue_data'] = ccavenueData?.toJson();
    }
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['payment_gateway_status'] = paymentGatewayStatus;
    map['order_id'] = orderId;
    return map;
  }
}

class CcavenueData {
  CcavenueData({
    this.orderId,
    this.accessCode,
    this.redirectUrl,
    this.cancelUrl,
    this.encVal,
    this.merchantId,
    this.workingKey,
    this.currency,
    this.language,
  });

  CcavenueData.fromJson(dynamic json) {
    orderId = json['order_id'];
    accessCode = json['access_code'];
    redirectUrl = json['redirect_url'];
    cancelUrl = json['cancel_url'];
    encVal = json['enc_val'];
    merchantId = json['merchant_id'];
    workingKey = json['working_key'];
    currency = json['currency'];
    language = json['language'];
  }

  dynamic orderId;
  String? accessCode;
  String? redirectUrl;
  String? cancelUrl;
  String? encVal;
  String? merchantId;
  String? workingKey;
  String? currency;
  String? language;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = orderId;
    map['access_code'] = accessCode;
    map['redirect_url'] = redirectUrl;
    map['cancel_url'] = cancelUrl;
    map['enc_val'] = encVal;
    map['merchant_id'] = merchantId;
    map['working_key'] = workingKey;
    map['currency'] = currency;
    map['language'] = language;
    return map;
  }
}
