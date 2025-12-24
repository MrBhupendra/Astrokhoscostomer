class ServiceCalculationModel {
  ServiceCalculationModel({
      this.status, 
      this.data, 
      this.msg,});

  ServiceCalculationModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? ServiceCalculationData.fromJson(json['data']) : null;
    msg = json['msg'];
  }
  num? status;
  ServiceCalculationData? data;
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

class ServiceCalculationData {
  ServiceCalculationData({
      this.serviceAmount, 
      this.referenceAmount, 
      this.offerAmmount, 
      this.subtotal, 
      this.finalamount, 
      this.walletAmount, 
      this.rechargeGstPercent, 
      this.rechargeGstValue, 
      this.payableAmount, 
      this.adminAmount, 
      this.astrologerAmount, 
      this.astrologerTdsAmount, 
      this.myWalletAmount,
      this.couponStatus
  });

  ServiceCalculationData.fromJson(dynamic json) {
    serviceAmount = json['service_amount'];
    referenceAmount = json['reference_amount'];
    offerAmmount = json['offer_ammount'];
    subtotal = json['subtotal'];
    finalamount = json['finalamount'];
    walletAmount = json['wallet_amount'];
    rechargeGstPercent = json['recharge_gst_percent'];
    rechargeGstValue = json['recharge_gst_value'];
    payableAmount = json['payable_amount'];
    adminAmount = json['admin_amount'];
    astrologerAmount = json['astrologer_amount'];
    astrologerTdsAmount = json['astrologer_tds_amount'];
    myWalletAmount = json['my_wallet_amount'];
    couponStatus = json['coupon_status'];
  }
  num? serviceAmount;
  num? referenceAmount;
  num? offerAmmount;
  num? subtotal;
  num? finalamount;
  num? walletAmount;
  num? rechargeGstPercent;
  num? rechargeGstValue;
  num? payableAmount;
  num? adminAmount;
  num? astrologerAmount;
  num? astrologerTdsAmount;
  num? myWalletAmount;
  String? couponStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_amount'] = serviceAmount;
    map['reference_amount'] = referenceAmount;
    map['offer_ammount'] = offerAmmount;
    map['subtotal'] = subtotal;
    map['finalamount'] = finalamount;
    map['wallet_amount'] = walletAmount;
    map['recharge_gst_percent'] = rechargeGstPercent;
    map['recharge_gst_value'] = rechargeGstValue;
    map['payable_amount'] = payableAmount;
    map['admin_amount'] = adminAmount;
    map['astrologer_amount'] = astrologerAmount;
    map['astrologer_tds_amount'] = astrologerTdsAmount;
    map['my_wallet_amount'] = myWalletAmount;
    map['coupon_status'] = couponStatus;
    return map;
  }

}