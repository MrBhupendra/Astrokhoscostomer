class SubscriptionCalculationModel {
  SubscriptionCalculationModel({
      this.status, 
      this.data, 
      this.msg,});

  SubscriptionCalculationModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? SubscriptionData.fromJson(json['data']) : null;
    msg = json['msg'];
  }
  num? status;
  SubscriptionData? data;
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

class SubscriptionData {
  SubscriptionData({
      this.subscriptionAmount, 
      this.referenceId, 
      this.refPercentage, 
      this.referenceAmount, 
      this.referenceTdsAmount, 
      this.refDiscPercentage, 
      this.offerAmount, 
      this.subtotal, 
      this.finalamount, 
      this.walletAmount, 
      this.rechargeGstPercent, 
      this.rechargeGstValue, 
      this.payableAmount, 
      this.myWalletAmount, 
      this.subscriptionDetail,});

  SubscriptionData.fromJson(dynamic json) {
    subscriptionAmount = json['subscription_amount'];
    referenceId = json['reference_id'];
    refPercentage = json['ref_percentage'];
    referenceAmount = json['reference_amount'];
    referenceTdsAmount = json['reference_tds_amount'];
    refDiscPercentage = json['ref_disc_percentage'];
    offerAmount = json['offer_amount'];
    subtotal = json['subtotal'];
    finalamount = json['finalamount'];
    walletAmount = json['wallet_amount'];
    rechargeGstPercent = json['recharge_gst_percent'];
    rechargeGstValue = json['recharge_gst_value'];
    payableAmount = json['payable_amount'];
    myWalletAmount = json['my_wallet_amount'];
    subscriptionDetail = json['subscription_detail'] != null ? SubscriptionDetail.fromJson(json['subscription_detail']) : null;
  }
  num? subscriptionAmount;
  String? referenceId;
  num? refPercentage;
  num? referenceAmount;
  num? referenceTdsAmount;
  num? refDiscPercentage;
  num? offerAmount;
  num? subtotal;
  num? finalamount;
  num? walletAmount;
  num? rechargeGstPercent;
  num? rechargeGstValue;
  num? payableAmount;
  num? myWalletAmount;
  SubscriptionDetail? subscriptionDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subscription_amount'] = subscriptionAmount;
    map['reference_id'] = referenceId;
    map['ref_percentage'] = refPercentage;
    map['reference_amount'] = referenceAmount;
    map['reference_tds_amount'] = referenceTdsAmount;
    map['ref_disc_percentage'] = refDiscPercentage;
    map['offer_amount'] = offerAmount;
    map['subtotal'] = subtotal;
    map['finalamount'] = finalamount;
    map['wallet_amount'] = walletAmount;
    map['recharge_gst_percent'] = rechargeGstPercent;
    map['recharge_gst_value'] = rechargeGstValue;
    map['payable_amount'] = payableAmount;
    map['my_wallet_amount'] = myWalletAmount;
    if (subscriptionDetail != null) {
      map['subscription_detail'] = subscriptionDetail?.toJson();
    }
    return map;
  }

}

class SubscriptionDetail {
  SubscriptionDetail({
      this.id, 
      this.title, 
      this.validityInDays, 
      this.videoCallDuration, 
      this.voiceCallDuration, 
      this.chatDuration, 
      this.price, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  SubscriptionDetail.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    validityInDays = json['validity_in_days'];
    videoCallDuration = json['video_call_duration'];
    voiceCallDuration = json['voice_call_duration'];
    chatDuration = json['chat_duration'];
    price = json['price'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? title;
  num? validityInDays;
  num? videoCallDuration;
  num? voiceCallDuration;
  num? chatDuration;
  num? price;
  num? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['validity_in_days'] = validityInDays;
    map['video_call_duration'] = videoCallDuration;
    map['voice_call_duration'] = voiceCallDuration;
    map['chat_duration'] = chatDuration;
    map['price'] = price;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}