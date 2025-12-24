class ReportHoroCalculation {
  ReportHoroCalculation({
      this.status, 
      this.data, 
      this.msg,});

  ReportHoroCalculation.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? ReportHoroCalculationData.fromJson(json['data']) : null;
    msg = json['msg'];
  }
  num? status;
  ReportHoroCalculationData? data;
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

class ReportHoroCalculationData {
  ReportHoroCalculationData({
    this.paidKundliManualId,
    this.orderAmount,
    this.offerAmmount,
    this.subtotal,
    this.finalamount,
    this.walletAmount,
    this.rechargeGstPercent,
    this.rechargeGstValue,
    this.payableAmount,
    this.myWalletAmount,});

  ReportHoroCalculationData.fromJson(dynamic json) {
    paidKundliManualId = json['paid_kundli_manual_id'];
    orderAmount = json['order_amount'];
    offerAmmount = json['offer_ammount'];
    subtotal = json['subtotal'];
    finalamount = json['finalamount'];
    walletAmount = json['wallet_amount'];
    rechargeGstPercent = json['recharge_gst_percent'];
    rechargeGstValue = json['recharge_gst_value'];
    payableAmount = json['payable_amount'];
    myWalletAmount = json['my_wallet_amount'];
  }
  num? paidKundliManualId;
  num? orderAmount;
  num? offerAmmount;
  num? subtotal;
  num? finalamount;
  num? walletAmount;
  num? rechargeGstPercent;
  num? rechargeGstValue;
  num? payableAmount;
  num? myWalletAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['paid_kundli_manual_id'] = paidKundliManualId;
    map['order_amount'] = orderAmount;
    map['offer_ammount'] = offerAmmount;
    map['subtotal'] = subtotal;
    map['finalamount'] = finalamount;
    map['wallet_amount'] = walletAmount;
    map['recharge_gst_percent'] = rechargeGstPercent;
    map['recharge_gst_value'] = rechargeGstValue;
    map['payable_amount'] = payableAmount;
    map['my_wallet_amount'] = myWalletAmount;
    return map;
  }

}