class LiveTempleDarshanCalculationModel {
  LiveTempleDarshanCalculationModel({
      this.status, 
      this.data, 
      this.msg,});

  LiveTempleDarshanCalculationModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? LiveMandirDarshanCalculationData.fromJson(json['data']) : null;
    msg = json['msg'];
  }
  num? status;
  LiveMandirDarshanCalculationData? data;
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

class LiveMandirDarshanCalculationData {
  LiveMandirDarshanCalculationData({
      this.liveTempleDarshanAmount, 
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
      this.couponStatus, 
      this.liveTempleDarshanAssign, 
      this.myWalletAmount, 
      this.walletGiftBalance, 
      this.walletMainBalance,});

  LiveMandirDarshanCalculationData.fromJson(dynamic json) {
    liveTempleDarshanAmount = json['live_temple_darshan_amount'];
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
    couponStatus = json['coupon_status'];
    liveTempleDarshanAssign = json['live_temple_darshan_assign'] != null ? LiveTempleDarshanAssign.fromJson(json['live_temple_darshan_assign']) : null;
    myWalletAmount = json['my_wallet_amount'];
    walletGiftBalance = json['wallet_gift_balance'];
    walletMainBalance = json['wallet_main_balance'];
  }
  String? liveTempleDarshanAmount;
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
  String? couponStatus;
  LiveTempleDarshanAssign? liveTempleDarshanAssign;
  num? myWalletAmount;
  num? walletGiftBalance;
  num? walletMainBalance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['live_temple_darshan_amount'] = liveTempleDarshanAmount;
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
    map['coupon_status'] = couponStatus;
    if (liveTempleDarshanAssign != null) {
      map['live_temple_darshan_assign'] = liveTempleDarshanAssign?.toJson();
    }
    map['my_wallet_amount'] = myWalletAmount;
    map['wallet_gift_balance'] = walletGiftBalance;
    map['wallet_main_balance'] = walletMainBalance;
    return map;
  }

}

class LiveTempleDarshanAssign {
  LiveTempleDarshanAssign({
      this.id, 
      this.liveTempleDarshanId, 
      this.astrologerUniId, 
      this.price, 
      this.liveTempleDarshanDate, 
      this.liveTempleDarshanTime, 
      this.description, 
      this.duration, 
      this.liveTempleDarshanChannelName, 
      this.availableDuration, 
      this.startTime, 
      this.liveStatus, 
      this.isPaid, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  LiveTempleDarshanAssign.fromJson(dynamic json) {
    id = json['id'];
    liveTempleDarshanId = json['live_temple_darshan_id'];
    astrologerUniId = json['astrologer_uni_id'];
    price = json['price'];
    liveTempleDarshanDate = json['live_temple_darshan_date'];
    liveTempleDarshanTime = json['live_temple_darshan_time'];
    description = json['description'];
    duration = json['duration'];
    liveTempleDarshanChannelName = json['live_temple_darshan_channel_name'];
    availableDuration = json['available_duration'];
    startTime = json['start_time'];
    liveStatus = json['live_status'];
    isPaid = json['is_paid'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  num? liveTempleDarshanId;
  String? astrologerUniId;
  String? price;
  dynamic liveTempleDarshanDate;
  dynamic liveTempleDarshanTime;
  String? description;
  num? duration;
  String? liveTempleDarshanChannelName;
  num? availableDuration;
  dynamic startTime;
  num? liveStatus;
  num? isPaid;
  num? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['live_temple_darshan_id'] = liveTempleDarshanId;
    map['astrologer_uni_id'] = astrologerUniId;
    map['price'] = price;
    map['live_temple_darshan_date'] = liveTempleDarshanDate;
    map['live_temple_darshan_time'] = liveTempleDarshanTime;
    map['description'] = description;
    map['duration'] = duration;
    map['live_temple_darshan_channel_name'] = liveTempleDarshanChannelName;
    map['available_duration'] = availableDuration;
    map['start_time'] = startTime;
    map['live_status'] = liveStatus;
    map['is_paid'] = isPaid;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}