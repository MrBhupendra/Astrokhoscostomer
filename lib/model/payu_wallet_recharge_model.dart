class PayuWalletRechargeModel {
  PayuWalletRechargeModel({
      this.status, 
      this.msg, 
      this.payuData, 
      this.data,});

  PayuWalletRechargeModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    payuData = json['payu_data'] != null ? PayuData.fromJson(json['payu_data']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? status;
  String? msg;
  PayuData? payuData;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (payuData != null) {
      map['payu_data'] = payuData?.toJson();
    }
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.walletAmount, 
      this.giftAmount, 
      this.tag, 
      this.currencyCode, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.orderId, 
      this.amount, 
      this.customerData,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    walletAmount = json['wallet_amount'];
    giftAmount = json['gift_amount'];
    tag = json['tag'];
    currencyCode = json['currency_code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderId = json['order_id'];
    amount = json['amount'];
    customerData = json['customerData'] != null ? CustomerData.fromJson(json['customerData']) : null;
  }
  num? id;
  String? walletAmount;
  String? giftAmount;
  String? tag;
  String? currencyCode;
  num? status;
  String? createdAt;
  String? updatedAt;
  String? orderId;
  num? amount;
  CustomerData? customerData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['wallet_amount'] = walletAmount;
    map['gift_amount'] = giftAmount;
    map['tag'] = tag;
    map['currency_code'] = currencyCode;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['order_id'] = orderId;
    map['amount'] = amount;
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
      this.processStatus, 
      this.roleId, 
      this.userUniId,
      this.name, 
      this.email,
      this.phone, 
      this.countryCode, 
      this.countryName,
      this.avgRating, 
      this.welcomeMail, 
      this.isRecharge,
      this.userFcmToken, 
      this.isUninstalled,
      this.userIosToken, 
      this.firebaseAuthToken, 
      this.trash, 
      this.status, 
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
    processStatus = json['process_status'];
    roleId = json['role_id'];
    userUniId = json['user_uni_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    countryName = json['country_name'];
    avgRating = json['avg_rating'];
    welcomeMail = json['welcome_mail'];
    isRecharge = json['is_recharge'];
    userFcmToken = json['user_fcm_token'];
    isUninstalled = json['is_uninstalled'];
    userIosToken = json['user_ios_token'];
    firebaseAuthToken = json['firebase_auth_token'];
    trash = json['trash'];
    status = json['status'];
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
  num? processStatus;
  num? roleId;
  String? userUniId;
  String? name;
  String? email;
  String? phone;
  String? countryCode;
  String? countryName;
  String? avgRating;
  num? welcomeMail;
  num? isRecharge;
  String? userFcmToken;
  num? isUninstalled;
  String? userIosToken;
  String? firebaseAuthToken;
  num? trash;
  num? status;
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
    map['process_status'] = processStatus;
    map['role_id'] = roleId;
    map['user_uni_id'] = userUniId;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['country_code'] = countryCode;
    map['country_name'] = countryName;
    map['avg_rating'] = avgRating;
    map['welcome_mail'] = welcomeMail;
    map['is_recharge'] = isRecharge;
    map['user_fcm_token'] = userFcmToken;
    map['is_uninstalled'] = isUninstalled;
    map['user_ios_token'] = userIosToken;
    map['firebase_auth_token'] = firebaseAuthToken;
    map['trash'] = trash;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class PayuData {
  PayuData({
      this.status, 
      this.paymentLink, 
      this.msg, 
      this.orderId,});

  PayuData.fromJson(dynamic json) {
    status = json['status'];
    paymentLink = json['paymentLink'];
    msg = json['msg'];
    orderId = json['order_id'];
  }
  num? status;
  String? paymentLink;
  String? msg;
  String? orderId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['paymentLink'] = paymentLink;
    map['msg'] = msg;
    map['order_id'] = orderId;
    return map;
  }

}