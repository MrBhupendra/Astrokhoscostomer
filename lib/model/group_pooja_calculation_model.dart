class GroupPoojaCalculationModel {
  GroupPoojaCalculationModel({
      this.status, 
      this.data, 
      this.msg,});

  GroupPoojaCalculationModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? GroupPoojaCalculationData.fromJson(json['data']) : null;
    msg = json['msg'];
  }
  num? status;
  GroupPoojaCalculationData? data;
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

class GroupPoojaCalculationData {
  GroupPoojaCalculationData({
      this.groupPujaAmount, 
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
      this.walletGiftBalance,
      this.walletMainBalance,
      this.couponStatus,
      this.groupPujaAssign,});

  GroupPoojaCalculationData.fromJson(dynamic json) {
    groupPujaAmount = json['group_puja_amount'];
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
    walletGiftBalance = json['wallet_gift_balance'];
    walletMainBalance = json['wallet_main_balance'];
    couponStatus = json['coupon_status'];
    groupPujaAssign = json['group_puja_assign'] != null ? GroupPujaAssign.fromJson(json['group_puja_assign']) : null;
  }
  String? groupPujaAmount;
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
  num? walletGiftBalance;
  num? walletMainBalance;
  String? couponStatus;
  GroupPujaAssign? groupPujaAssign;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['group_puja_amount'] = groupPujaAmount;
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
    map['wallet_gift_balance'] = walletGiftBalance;
    map['wallet_main_balance'] = walletMainBalance;
    map['coupon_status'] = couponStatus;
    if (groupPujaAssign != null) {
      map['group_puja_assign'] = groupPujaAssign?.toJson();
    }
    return map;
  }

}

class GroupPujaAssign {
  GroupPujaAssign({
      this.id, 
      this.groupPujaId, 
      this.astrologerUniId, 
      this.price, 
      this.groupPujaDate, 
      this.groupPujaTime, 
      this.description, 
      this.duration, 
      this.groupPujaChannelName, 
      this.availableDuration, 
      this.startTime, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  GroupPujaAssign.fromJson(dynamic json) {
    id = json['id'];
    groupPujaId = json['group_puja_id'];
    astrologerUniId = json['astrologer_uni_id'];
    price = json['price'];
    groupPujaDate = json['group_puja_date'];
    groupPujaTime = json['group_puja_time'];
    description = json['description'];
    duration = json['duration'];
    groupPujaChannelName = json['group_puja_channel_name'];
    availableDuration = json['available_duration'];
    startTime = json['start_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  num? groupPujaId;
  String? astrologerUniId;
  String? price;
  String? groupPujaDate;
  String? groupPujaTime;
  String? description;
  num? duration;
  String? groupPujaChannelName;
  num? availableDuration;
  String? startTime;
  num? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['group_puja_id'] = groupPujaId;
    map['astrologer_uni_id'] = astrologerUniId;
    map['price'] = price;
    map['group_puja_date'] = groupPujaDate;
    map['group_puja_time'] = groupPujaTime;
    map['description'] = description;
    map['duration'] = duration;
    map['group_puja_channel_name'] = groupPujaChannelName;
    map['available_duration'] = availableDuration;
    map['start_time'] = startTime;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}