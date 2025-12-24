class QuestionPurchaseModel {
  QuestionPurchaseModel({
    this.status,
    this.errorCode,
    this.isCustDataIncomplete,
    this.orderId,
    this.questionData,
    this.answerData,
    this.paymentGatewayStatus,
    this.msg,
    this.data,});

  QuestionPurchaseModel.fromJson(dynamic json) {
    status = json['status'];
    errorCode = json['error_code'];
    isCustDataIncomplete = json['is_cust_data_incomplete'];
    orderId = json['order_id'];
    questionData = json['question_data'] != null
        ? QuestionData.fromJson(json['question_data'])
        : null;
    answerData = json['answer_data'] != null
        ? AnswerData.fromJson(json['answer_data'])
        : null;
    paymentGatewayStatus = json['payment_gateway_status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  num? status;
  num? isCustDataIncomplete;
  String? orderId;
  QuestionData? questionData;
  AnswerData? answerData;
  num? paymentGatewayStatus;
  String? msg;
  Data? data;
  num? errorCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['error_code'] = errorCode;
    map['is_cust_data_incomplete'] = isCustDataIncomplete;
    map['order_id'] = orderId;
    if (questionData != null) {
      map['question_data'] = questionData?.toJson();
    }
    if (answerData != null) {
      map['answer_data'] = answerData?.toJson();
    }
    map['payment_gateway_status'] = paymentGatewayStatus;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
    this.openAiPredictionPrice,
    this.offerAmmount,
    this.subtotal,
    this.finalamount,
    this.walletAmount,
    this.rechargeGstPercent,
    this.rechargeGstValue,
    this.payableAmount,
    this.myWalletAmount,});

  Data.fromJson(dynamic json) {
    openAiPredictionPrice = json['open_ai_prediction_price'];
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

class AnswerData {
  AnswerData({
    this.userUniId,
    this.userName,
    this.userImageUrl,
    this.message,
    this.messageType,
    this.status,
    this.createdAt,});

  AnswerData.fromJson(dynamic json) {
    userUniId = json['user_uni_id'];
    userName = json['user_name'];
    userImageUrl = json['user_image_url'];
    message = json['message'];
    messageType = json['message_type'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  String? userUniId;
  String? userName;
  String? userImageUrl;
  String? message;
  String? messageType;
  num? status;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_uni_id'] = userUniId;
    map['user_name'] = userName;
    map['user_image_url'] = userImageUrl;
    map['message'] = message;
    map['message_type'] = messageType;
    map['status'] = status;
    map['created_at'] = createdAt;
    return map;
  }

}

class QuestionData {
  QuestionData({
    this.userUniId,
    this.userName,
    this.userImageUrl,
    this.message,
    this.messageType,
    this.status,
    this.createdAt,});

  QuestionData.fromJson(dynamic json) {
    userUniId = json['user_uni_id'];
    userName = json['user_name'];
    userImageUrl = json['user_image_url'];
    message = json['message'];
    messageType = json['message_type'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  String? userUniId;
  String? userName;
  String? userImageUrl;
  String? message;
  String? messageType;
  num? status;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_uni_id'] = userUniId;
    map['user_name'] = userName;
    map['user_image_url'] = userImageUrl;
    map['message'] = message;
    map['message_type'] = messageType;
    map['status'] = status;
    map['created_at'] = createdAt;
    return map;
  }

}