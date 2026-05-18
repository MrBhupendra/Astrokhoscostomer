class RazorpayQrVerifyResponse {
  RazorpayQrVerifyResponse({
      this.status, 
      this.msg, 
      this.isPaid, 
      this.paymentId, 
      this.qrId, 
      this.data,});

  RazorpayQrVerifyResponse.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    isPaid = json['is_paid'];
    paymentId = json['payment_id'];
    qrId = json['qr_id'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? status;
  String? msg;
  num? isPaid;
  String? paymentId;
  String? qrId;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    map['is_paid'] = isPaid;
    map['payment_id'] = paymentId;
    map['qr_id'] = qrId;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.entity, 
      this.amount, 
      this.currency, 
      this.status, 
      this.international, 
      this.method, 
      this.amountRefunded, 
      this.captured, 
      this.description, 
      this.vpa, 
      this.notes, 
      this.fee, 
      this.tax, 
      this.acquirerData, 
      this.createdAt, 
      this.upi,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    entity = json['entity'];
    amount = json['amount'];
    currency = json['currency'];
    status = json['status'];
    international = json['international'];
    method = json['method'];
    amountRefunded = json['amount_refunded'];
    captured = json['captured'];
    description = json['description'];
    vpa = json['vpa'];
    notes = json['notes'] != null ? Notes.fromJson(json['notes']) : null;
    fee = json['fee'];
    tax = json['tax'];
    acquirerData = json['acquirer_data'] != null ? AcquirerData.fromJson(json['acquirer_data']) : null;
    createdAt = json['created_at'];
    upi = json['upi'] != null ? Upi.fromJson(json['upi']) : null;
  }
  String? id;
  String? entity;
  num? amount;
  String? currency;
  String? status;
  bool? international;
  String? method;
  num? amountRefunded;
  bool? captured;
  String? description;
  String? vpa;
  Notes? notes;
  num? fee;
  num? tax;
  AcquirerData? acquirerData;
  num? createdAt;
  Upi? upi;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['entity'] = entity;
    map['amount'] = amount;
    map['currency'] = currency;
    map['status'] = status;
    map['international'] = international;
    map['method'] = method;
    map['amount_refunded'] = amountRefunded;
    map['captured'] = captured;
    map['description'] = description;
    map['vpa'] = vpa;
    if (notes != null) {
      map['notes'] = notes?.toJson();
    }
    map['fee'] = fee;
    map['tax'] = tax;
    if (acquirerData != null) {
      map['acquirer_data'] = acquirerData?.toJson();
    }
    map['created_at'] = createdAt;
    if (upi != null) {
      map['upi'] = upi?.toJson();
    }
    return map;
  }

}

class Upi {
  Upi({
      this.payerAccountType, 
      this.vpa, 
      this.flow,});

  Upi.fromJson(dynamic json) {
    payerAccountType = json['payer_account_type'];
    vpa = json['vpa'];
    flow = json['flow'];
  }
  String? payerAccountType;
  String? vpa;
  String? flow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payer_account_type'] = payerAccountType;
    map['vpa'] = vpa;
    map['flow'] = flow;
    return map;
  }

}

class AcquirerData {
  AcquirerData({
      this.rrn,});

  AcquirerData.fromJson(dynamic json) {
    rrn = json['rrn'];
  }
  String? rrn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rrn'] = rrn;
    return map;
  }

}

class Notes {
  Notes({
      this.walletId, 
      this.userUniId,});

  Notes.fromJson(dynamic json) {
    walletId = json['wallet_id'];
    userUniId = json['user_uni_id'];
  }
  String? walletId;
  String? userUniId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['wallet_id'] = walletId;
    map['user_uni_id'] = userUniId;
    return map;
  }

}