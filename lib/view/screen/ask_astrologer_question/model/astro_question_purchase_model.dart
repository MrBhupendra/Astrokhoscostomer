class AstroQuestionPurchaseModel {
  AstroQuestionPurchaseModel({
      this.status,
      this.errorCode,
      this.orderId, 
      this.paymentGatewayStatus, 
      this.msg, 
      this.data, 
      this.customerData,});

  AstroQuestionPurchaseModel.fromJson(dynamic json) {
    status = json['status'];
    errorCode = json['error_code'];
    orderId = json['order_id'];
    paymentGatewayStatus = json['payment_gateway_status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    customerData = json['customerData'] != null ? CustomerData.fromJson(json['customerData']) : null;
  }
  num? status;
  num? errorCode;
  String? orderId;
  num? paymentGatewayStatus;
  String? msg;
  Data? data;
  CustomerData? customerData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['error_code'] = errorCode;
    map['order_id'] = orderId;
    map['payment_gateway_status'] = paymentGatewayStatus;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (customerData != null) {
      map['customerData'] = customerData?.toJson();
    }
    return map;
  }

}

class CustomerData {
  CustomerData({
      this.id, 
      this.customerUniId, 
      this.city, 
      this.state, 
      this.country, 
      this.birthDate, 
      this.gender, 
      this.customerImg, 
      this.longitude, 
      this.birthPlace, 
      this.birthTime, 
      this.latitude, 
      this.name, 
      this.email, 
      this.phone, 
      this.countryCode, 
      this.countryName, 
      this.createdAt, 
      this.updatedAt,});

  CustomerData.fromJson(dynamic json) {
    id = json['id'];
    customerUniId = json['customer_uni_id'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    customerImg = json['customer_img'];
    longitude = json['longitude'];
    birthPlace = json['birth_place'];
    birthTime = json['birth_time'];
    latitude = json['latitude'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    countryName = json['country_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? customerUniId;
  String? city;
  String? state;
  String? country;
  String? birthDate;
  String? gender;
  String? customerImg;
  String? longitude;
  String? birthPlace;
  String? birthTime;
  String? latitude;
  String? name;
  String? email;
  String? phone;
  String? countryCode;
  String? countryName;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['customer_uni_id'] = customerUniId;
    map['city'] = city;
    map['state'] = state;
    map['country'] = country;
    map['birth_date'] = birthDate;
    map['gender'] = gender;
    map['customer_img'] = customerImg;
    map['longitude'] = longitude;
    map['birth_place'] = birthPlace;
    map['birth_time'] = birthTime;
    map['latitude'] = latitude;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['country_code'] = countryCode;
    map['country_name'] = countryName;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class Data {
  Data({
      this.askQuestionPrice, 
      this.referenceAmount, 
      this.offerAmmount, 
      this.subtotal, 
      this.finalamount, 
      this.walletAmount, 
      this.rechargeGstPercent, 
      this.rechargeGstValue, 
      this.payableAmount, 
      this.adminAmount, 
      this.adminPercentage, 
      this.astrologerAmount, 
      this.astrologerTdsAmount, 
      this.myWalletAmount, 
      this.couponStatus,});

  Data.fromJson(dynamic json) {
    askQuestionPrice = json['ask_question_price'];
    referenceAmount = json['reference_amount'];
    offerAmmount = json['offer_ammount'];
    subtotal = json['subtotal'];
    finalamount = json['finalamount'];
    walletAmount = json['wallet_amount'];
    rechargeGstPercent = json['recharge_gst_percent'];
    rechargeGstValue = json['recharge_gst_value'];
    payableAmount = json['payable_amount'];
    adminAmount = json['admin_amount'];
    adminPercentage = json['admin_percentage'];
    astrologerAmount = json['astrologer_amount'];
    astrologerTdsAmount = json['astrologer_tds_amount'];
    myWalletAmount = json['my_wallet_amount'];
    couponStatus = json['coupon_status'];
  }
  String? askQuestionPrice;
  num? referenceAmount;
  num? offerAmmount;
  num? subtotal;
  num? finalamount;
  num? walletAmount;
  num? rechargeGstPercent;
  num? rechargeGstValue;
  num? payableAmount;
  num? adminAmount;
  num? adminPercentage;
  num? astrologerAmount;
  num? astrologerTdsAmount;
  num? myWalletAmount;
  String? couponStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ask_question_price'] = askQuestionPrice;
    map['reference_amount'] = referenceAmount;
    map['offer_ammount'] = offerAmmount;
    map['subtotal'] = subtotal;
    map['finalamount'] = finalamount;
    map['wallet_amount'] = walletAmount;
    map['recharge_gst_percent'] = rechargeGstPercent;
    map['recharge_gst_value'] = rechargeGstValue;
    map['payable_amount'] = payableAmount;
    map['admin_amount'] = adminAmount;
    map['admin_percentage'] = adminPercentage;
    map['astrologer_amount'] = astrologerAmount;
    map['astrologer_tds_amount'] = astrologerTdsAmount;
    map['my_wallet_amount'] = myWalletAmount;
    map['coupon_status'] = couponStatus;
    return map;
  }

}