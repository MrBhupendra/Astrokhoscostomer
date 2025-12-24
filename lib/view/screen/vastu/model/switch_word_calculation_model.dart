class SwitchWordCalculationModel {
  SwitchWordCalculationModel({
      this.status, 
      this.data, 
      this.msg,});

  SwitchWordCalculationModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? SwitchWordCalculatioData.fromJson(json['data']) : null;
    msg = json['msg'];
  }
  num? status;
  SwitchWordCalculatioData? data;
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

class SwitchWordCalculatioData {
  SwitchWordCalculatioData({
      this.switchwordAmount, 
      this.offerAmmount, 
      this.subtotal, 
      this.finalamount, 
      this.walletAmount, 
      this.rechargeGstPercent, 
      this.rechargeGstValue, 
      this.payableAmount, 
      this.myWalletAmount,});

  SwitchWordCalculatioData.fromJson(dynamic json) {
    switchwordAmount = json['switchword_amount'];
    offerAmmount = json['offer_ammount'];
    subtotal = json['subtotal'];
    finalamount = json['finalamount'];
    walletAmount = json['wallet_amount'];
    rechargeGstPercent = json['recharge_gst_percent'];
    rechargeGstValue = json['recharge_gst_value'];
    payableAmount = json['payable_amount'];
    myWalletAmount = json['my_wallet_amount'];
  }
  num? switchwordAmount;
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
    map['switchword_amount'] = switchwordAmount;
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