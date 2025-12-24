class ArchitectCalculationModel {
  ArchitectCalculationModel({
      this.status, 
      this.data, 
      this.msg,});

  ArchitectCalculationModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? ArchitectCalculationData.fromJson(json['data']) : null;
    msg = json['msg'];
  }
  num? status;
  ArchitectCalculationData? data;
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

class ArchitectCalculationData {
  ArchitectCalculationData({
      this.architectServiceAmount, 
      this.architectServiceType, 
      this.architectServiceDuration, 
      this.offerAmmount, 
      this.gstvalue, 
      this.gstamount, 
      this.subtotal, 
      this.finalamount, 
      this.walletAmount, 
      this.rechargeGstPercent, 
      this.rechargeGstValue, 
      this.payableAmount, 
      this.adminAmount, 
      this.architectAmount, 
      this.architectTdsAmount, 
      this.myWalletAmount,});

  ArchitectCalculationData.fromJson(dynamic json) {
    architectServiceAmount = json['architect_service_amount'];
    architectServiceType = json['architect_service_type'];
    architectServiceDuration = json['architect_service_duration'];
    offerAmmount = json['offer_ammount'];
    gstvalue = json['gstvalue'];
    gstamount = json['gstamount'];
    subtotal = json['subtotal'];
    finalamount = json['finalamount'];
    walletAmount = json['wallet_amount'];
    rechargeGstPercent = json['recharge_gst_percent'];
    rechargeGstValue = json['recharge_gst_value'];
    payableAmount = json['payable_amount'];
    adminAmount = json['admin_amount'];
    architectAmount = json['architect_amount'];
    architectTdsAmount = json['architect_tds_amount'];
    myWalletAmount = json['my_wallet_amount'];
  }
  num? architectServiceAmount;
  String? architectServiceType;
  num? architectServiceDuration;
  num? offerAmmount;
  num? gstvalue;
  num? gstamount;
  num? subtotal;
  num? finalamount;
  num? walletAmount;
  num? rechargeGstPercent;
  num? rechargeGstValue;
  num? payableAmount;
  num? adminAmount;
  num? architectAmount;
  num? architectTdsAmount;
  num? myWalletAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['architect_service_amount'] = architectServiceAmount;
    map['architect_service_type'] = architectServiceType;
    map['architect_service_duration'] = architectServiceDuration;
    map['offer_ammount'] = offerAmmount;
    map['gstvalue'] = gstvalue;
    map['gstamount'] = gstamount;
    map['subtotal'] = subtotal;
    map['finalamount'] = finalamount;
    map['wallet_amount'] = walletAmount;
    map['recharge_gst_percent'] = rechargeGstPercent;
    map['recharge_gst_value'] = rechargeGstValue;
    map['payable_amount'] = payableAmount;
    map['admin_amount'] = adminAmount;
    map['architect_amount'] = architectAmount;
    map['architect_tds_amount'] = architectTdsAmount;
    map['my_wallet_amount'] = myWalletAmount;
    return map;
  }

}