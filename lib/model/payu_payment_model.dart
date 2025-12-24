class PayuPaymentModel {
  PayuPaymentModel({
      this.status, 
      this.orderId, 
      this.paymentGatewayStatus, 
      this.paymentGateway, 
      this.msg, 
      this.data, 
      this.customerData, 
      this.payuData,});

  PayuPaymentModel.fromJson(dynamic json) {
    status = json['status'];
    orderId = json['order_id'];
    paymentGatewayStatus = json['payment_gateway_status'];
    paymentGateway = json['payment_gateway'] != null ? PaymentGateway.fromJson(json['payment_gateway']) : null;
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    customerData = json['customerData'] != null ? CustomerData.fromJson(json['customerData']) : null;
    payuData = json['payu_data'] != null ? PayuData.fromJson(json['payu_data']) : null;
  }
  num? status;
  String? orderId;
  num? paymentGatewayStatus;
  PaymentGateway? paymentGateway;
  String? msg;
  Data? data;
  CustomerData? customerData;
  PayuData? payuData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['order_id'] = orderId;
    map['payment_gateway_status'] = paymentGatewayStatus;
    if (paymentGateway != null) {
      map['payment_gateway'] = paymentGateway?.toJson();
    }
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (customerData != null) {
      map['customerData'] = customerData?.toJson();
    }
    if (payuData != null) {
      map['payu_data'] = payuData?.toJson();
    }
    return map;
  }

}

class PayuData {
  PayuData({
      this.status, 
      this.paymentLink, 
      this.msg,});

  PayuData.fromJson(dynamic json) {
    status = json['status'];
    paymentLink = json['paymentLink'];
    msg = json['msg'];
  }
  num? status;
  String? paymentLink;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['paymentLink'] = paymentLink;
    map['msg'] = msg;
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

class Data {
  Data({
      this.productAmount, 
      this.item, 
      this.referenceAmount, 
      this.referenceTdsAmount, 
      this.refDiscPercentage, 
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
      this.vendorAmount, 
      this.vendorTdsAmount, 
      this.couponStatus, 
      this.myWalletAmount, 
      this.walletGiftBalance, 
      this.walletMainBalance,});

  Data.fromJson(dynamic json) {
    productAmount = json['product_amount'];
    item = json['item'];
    referenceAmount = json['reference_amount'];
    referenceTdsAmount = json['reference_tds_amount'];
    refDiscPercentage = json['ref_disc_percentage'];
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
    vendorAmount = json['vendor_amount'];
    vendorTdsAmount = json['vendor_tds_amount'];
    couponStatus = json['coupon_status'];
    myWalletAmount = json['my_wallet_amount'];
    walletGiftBalance = json['wallet_gift_balance'];
    walletMainBalance = json['wallet_main_balance'];
  }
  num? productAmount;
  String? item;
  num? referenceAmount;
  num? referenceTdsAmount;
  num? refDiscPercentage;
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
  num? vendorAmount;
  num? vendorTdsAmount;
  String? couponStatus;
  num? myWalletAmount;
  num? walletGiftBalance;
  num? walletMainBalance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_amount'] = productAmount;
    map['item'] = item;
    map['reference_amount'] = referenceAmount;
    map['reference_tds_amount'] = referenceTdsAmount;
    map['ref_disc_percentage'] = refDiscPercentage;
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
    map['vendor_amount'] = vendorAmount;
    map['vendor_tds_amount'] = vendorTdsAmount;
    map['coupon_status'] = couponStatus;
    map['my_wallet_amount'] = myWalletAmount;
    map['wallet_gift_balance'] = walletGiftBalance;
    map['wallet_main_balance'] = walletMainBalance;
    return map;
  }

}

class PaymentGateway {
  PaymentGateway({
      this.gatewayOrderId, 
      this.amount, 
      this.successURL, 
      this.failureURL, 
      this.customerId, 
      this.customerPhone, 
      this.customerName, 
      this.customerEmail, 
      this.description, 
      this.isUpdated,});

  PaymentGateway.fromJson(dynamic json) {
    gatewayOrderId = json['gateway_order_id'];
    amount = json['amount'];
    successURL = json['successURL'];
    failureURL = json['failureURL'];
    customerId = json['customer_id'];
    customerPhone = json['customer_phone'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    description = json['description'];
    isUpdated = json['is_updated'];
  }
  String? gatewayOrderId;
  num? amount;
  String? successURL;
  String? failureURL;
  String? customerId;
  String? customerPhone;
  String? customerName;
  String? customerEmail;
  String? description;
  num? isUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gateway_order_id'] = gatewayOrderId;
    map['amount'] = amount;
    map['successURL'] = successURL;
    map['failureURL'] = failureURL;
    map['customer_id'] = customerId;
    map['customer_phone'] = customerPhone;
    map['customer_name'] = customerName;
    map['customer_email'] = customerEmail;
    map['description'] = description;
    map['is_updated'] = isUpdated;
    return map;
  }

}