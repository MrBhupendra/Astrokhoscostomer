class QuestionCalculationModel {
  QuestionCalculationModel({
      this.status, 
      this.data, 
      this.msg,});

  QuestionCalculationModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? QuestionCalculationData.fromJson(json['data']) : null;
    msg = json['msg'];
  }
  num? status;
  QuestionCalculationData? data;
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

class QuestionCalculationData {
  QuestionCalculationData({
      this.openAiPredictionPrice, 
      this.openAiPredictionActualPrice, 
      this.remainingOfferCount, 
      this.maxOfferCount, 
      this.isOfferApplied, 
      this.offerAmmount, 
      this.subtotal, 
      this.finalamount, 
      this.walletAmount, 
      this.rechargeGstPercent, 
      this.rechargeGstValue, 
      this.payableAmount, 
      this.myWalletAmount,});

  QuestionCalculationData.fromJson(dynamic json) {
    openAiPredictionPrice = json['open_ai_prediction_price'];
    openAiPredictionActualPrice = json['open_ai_prediction_actual_price'];
    remainingOfferCount = json['remaining_offer_count'];
    maxOfferCount = json['max_offer_count'];
    isOfferApplied = json['is_offer_applied'];
    offerAmmount = json['offer_ammount'];
    subtotal = json['subtotal'];
    finalamount = json['finalamount'];
    walletAmount = json['wallet_amount'];
    rechargeGstPercent = json['recharge_gst_percent'];
    rechargeGstValue = json['recharge_gst_value'];
    payableAmount = json['payable_amount'];
    myWalletAmount = json['my_wallet_amount'];
  }
  num? openAiPredictionPrice;
  num? openAiPredictionActualPrice;
  num? remainingOfferCount;
  num? maxOfferCount;
  num? isOfferApplied;
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
    map['open_ai_prediction_price'] = openAiPredictionPrice;
    map['open_ai_prediction_actual_price'] = openAiPredictionActualPrice;
    map['remaining_offer_count'] = remainingOfferCount;
    map['max_offer_count'] = maxOfferCount;
    map['is_offer_applied'] = isOfferApplied;
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