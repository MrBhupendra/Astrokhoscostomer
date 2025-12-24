class PhonepeModel {
  PhonepeModel({
    this.status,
    this.paymentGatewayStatus,
    this.msg,
    this.data,
    this.paymentGatewayData,
    this.phonepeData,
  });

  PhonepeModel.fromJson(dynamic json) {
    status = json['status'];
    paymentGatewayStatus = json['payment_gateway_status'];
    msg = json['msg'];
    data = json['data'] != null ? WalletData.fromJson(json['data']) : null;
    paymentGatewayData = json['payment_gateway'] != null
        ? PaymentGatewayData.fromJson(json['payment_gateway'])
        : null;
    phonepeData = json['phonepe_data'] != null
        ? PhonepeData.fromJson(json['phonepe_data'])
        : null;
  }

  num? status;
  num? paymentGatewayStatus;
  String? msg;
  WalletData? data;
  PaymentGatewayData? paymentGatewayData;
  PhonepeData? phonepeData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['payment_gateway_status'] = paymentGatewayStatus;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (paymentGatewayData != null) {
      map['payment_gateway'] = paymentGatewayData?.toJson();
    }
    if (phonepeData != null) {
      map['phonepe_data'] = phonepeData?.toJson();
    }
    return map;
  }
}

class PhonepeData {
  PhonepeData({
    this.status,
    this.data,
    this.encode,
    this.string,
    this.sha256,
    this.finalXHeader,
    this.saltKey,
    this.saltIndex,
    this.msg,
    this.orderId,
  });

  PhonepeData.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    encode = json['encode'];
    string = json['string'];
    sha256 = json['sha256'];
    finalXHeader = json['finalXHeader'];
    saltKey = json['saltKey'];
    saltIndex = json['saltIndex'];
    msg = json['msg'];
    orderId = json['order_id'];
  }

  num? status;
  Data? data;
  String? encode;
  String? string;
  String? sha256;
  String? finalXHeader;
  String? saltKey;
  String? saltIndex;
  String? msg;
  String? orderId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['encode'] = encode;
    map['string'] = string;
    map['sha256'] = sha256;
    map['finalXHeader'] = finalXHeader;
    map['saltKey'] = saltKey;
    map['saltIndex'] = saltIndex;
    map['msg'] = msg;
    map['order_id'] = orderId;
    return map;
  }
}

class Data {
  Data({
    this.merchantId,
    this.merchantTransactionId,
    this.merchantUserId,
    this.amount,
    this.redirectUrl,
    this.redirectMode,
    this.callbackUrl,
    this.mobileNumber,
    this.paymentInstrument,
  });

  Data.fromJson(dynamic json) {
    merchantId = json['merchantId'];
    merchantTransactionId = json['merchantTransactionId'];
    merchantUserId = json['merchantUserId'];
    amount = json['amount'];
    redirectUrl = json['redirectUrl'];
    redirectMode = json['redirectMode'];
    callbackUrl = json['callbackUrl'];
    mobileNumber = json['mobileNumber'];
    paymentInstrument = json['paymentInstrument'] != null
        ? PaymentInstrument.fromJson(json['paymentInstrument'])
        : null;
  }

  String? merchantId;
  String? merchantTransactionId;
  String? merchantUserId;
  num? amount;
  String? redirectUrl;
  String? redirectMode;
  String? callbackUrl;
  String? mobileNumber;
  PaymentInstrument? paymentInstrument;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['merchantId'] = merchantId;
    map['merchantTransactionId'] = merchantTransactionId;
    map['merchantUserId'] = merchantUserId;
    map['amount'] = amount;
    map['redirectUrl'] = redirectUrl;
    map['redirectMode'] = redirectMode;
    map['callbackUrl'] = callbackUrl;
    map['mobileNumber'] = mobileNumber;
    if (paymentInstrument != null) {
      map['paymentInstrument'] = paymentInstrument?.toJson();
    }
    return map;
  }
}

class PaymentInstrument {
  PaymentInstrument({
    this.type,
  });

  PaymentInstrument.fromJson(dynamic json) {
    type = json['type'];
  }

  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }
}

class WalletData {
  WalletData({
    this.payableAmount,
  });

  WalletData.fromJson(dynamic json) {
    payableAmount = json['payable_amount'];
  }

  num? payableAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payable_amount'] = payableAmount;
    return map;
  }
}

class PaymentGatewayData {
  PaymentGatewayData({
    this.amount,
  });

  PaymentGatewayData.fromJson(dynamic json) {
    amount = json['amount'];
  }

  num? amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    return map;
  }
}
