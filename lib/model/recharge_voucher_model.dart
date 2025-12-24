class RechargeVoucherModel {
  RechargeVoucherModel({
      this.status, 
      this.wallet, 
      this.data, 
      this.msg,});

  RechargeVoucherModel.fromJson(dynamic json) {
    status = json['status'];
    wallet = json['wallet'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  num? wallet;
  List<Data>? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['wallet'] = wallet;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.walletAmount, 
      this.giftAmount, 
      this.tag, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.walletCmsId, 
      this.gstprecent, 
      this.gstamount, 
      this.totalamount, 
      this.currency, 
      this.currencyCode, 
      this.mainAmount,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    walletAmount = json['wallet_amount'];
    giftAmount = json['gift_amount'];
    tag = json['tag'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    walletCmsId = json['wallet_cms_id'];
    gstprecent = json['gstprecent'];
    gstamount = json['gstamount'];
    totalamount = json['totalamount'];
    currency = json['currency'];
    currencyCode = json['currency_code'];
    mainAmount = json['main_amount'];
  }
  num? id;
  String? walletAmount;
  String? giftAmount;
  String? tag;
  num? status;
  String? createdAt;
  String? updatedAt;
  num? walletCmsId;
  String? gstprecent;
  num? gstamount;
  num? totalamount;
  String? currency;
  String? currencyCode;
  num? mainAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['wallet_amount'] = walletAmount;
    map['gift_amount'] = giftAmount;
    map['tag'] = tag;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['wallet_cms_id'] = walletCmsId;
    map['gstprecent'] = gstprecent;
    map['gstamount'] = gstamount;
    map['totalamount'] = totalamount;
    map['currency'] = currency;
    map['currency_code'] = currencyCode;
    map['main_amount'] = mainAmount;
    return map;
  }

}