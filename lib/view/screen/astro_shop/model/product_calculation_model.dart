class ProductCalculationModel {
  ProductCalculationModel({
      this.status, 
      this.data, 
      this.msg,});

  ProductCalculationModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
  }
  num? status;
  Data? data;
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

class Data {
  Data({
      this.productAmount, 
      this.item, 
      this.referenceAmount, 
      this.referenceTdsAmount, 
      this.offerAmmount, 
      this.gstvalue, 
      this.gstamount,
      this.subscriptionDiscountPercent,
      this.isSubscription,
      this.subtotal, 
      this.finalamount, 
      this.walletAmount, 
      this.rechargeGstPercent, 
      this.rechargeGstValue, 
      this.payableAmount, 
      this.adminAmount, 
      this.vendorAmount, 
      this.vendorTdsAmount, 
      this.myWalletAmount,
      this.couponStatus
  });

  Data.fromJson(dynamic json) {
    productAmount = json['product_amount'];
    item = json['item'];
    referenceAmount = json['reference_amount'];
    referenceTdsAmount = json['reference_tds_amount'];
    offerAmmount = json['offer_ammount'];
    gstvalue = json['gstvalue'];
    gstamount = json['gstamount'];
    subscriptionDiscountPercent = json['subscription_discount_percent'];
    isSubscription = json['is_subscription'];
    subtotal = json['subtotal'];
    finalamount = json['finalamount'];
    walletAmount = json['wallet_amount'];
    rechargeGstPercent = json['recharge_gst_percent'];
    rechargeGstValue = json['recharge_gst_value'];
    payableAmount = json['payable_amount'];
    adminAmount = json['admin_amount'];
    vendorAmount = json['vendor_amount'];
    vendorTdsAmount = json['vendor_tds_amount'];
    myWalletAmount = json['my_wallet_amount'];
    couponStatus = json['coupon_status'];
  }
  num? productAmount;
  num? item;
  num? referenceAmount;
  num? referenceTdsAmount;
  num? offerAmmount;
  num? gstvalue;
  num? gstamount;
  String? subscriptionDiscountPercent;
  num? isSubscription;
  num? subtotal;
  num? finalamount;
  num? walletAmount;
  num? rechargeGstPercent;
  num? rechargeGstValue;
  num? payableAmount;
  num? adminAmount;
  num? vendorAmount;
  num? vendorTdsAmount;
  num? myWalletAmount;
  String? couponStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_amount'] = productAmount;
    map['item'] = item;
    map['reference_amount'] = referenceAmount;
    map['reference_tds_amount'] = referenceTdsAmount;
    map['offer_ammount'] = offerAmmount;
    map['gstvalue'] = gstvalue;
    map['gstamount'] = gstamount;
    map['subscription_discount_percent'] = subscriptionDiscountPercent;
    map['is_subscription'] = isSubscription;
    map['subtotal'] = subtotal;
    map['finalamount'] = finalamount;
    map['wallet_amount'] = walletAmount;
    map['recharge_gst_percent'] = rechargeGstPercent;
    map['recharge_gst_value'] = rechargeGstValue;
    map['payable_amount'] = payableAmount;
    map['admin_amount'] = adminAmount;
    map['vendor_amount'] = vendorAmount;
    map['vendor_tds_amount'] = vendorTdsAmount;
    map['my_wallet_amount'] = myWalletAmount;
    map['coupon_status'] = couponStatus;
    return map;
  }

}