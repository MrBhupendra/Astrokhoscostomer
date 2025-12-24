class CashfreeModel {
  CashfreeModel({
      this.status, 
      this.orderId, 
      this.paymentGatewayStatus, 
      this.paymentGateway, 
      this.msg, 
      this.data, 
      this.customerData, 
      this.cashfreeData,});

  CashfreeModel.fromJson(dynamic json) {
    status = json['status'];
    orderId = json['order_id'];
    paymentGatewayStatus = json['payment_gateway_status'];
    paymentGateway = json['payment_gateway'] != null ? PaymentGateway.fromJson(json['payment_gateway']) : null;
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    customerData = json['customerData'] != null ? CustomerData.fromJson(json['customerData']) : null;
    cashfreeData = json['cashfree_data'] != null ? CashfreeData.fromJson(json['cashfree_data']) : null;
  }
  num? status;
  String? orderId;
  num? paymentGatewayStatus;
  PaymentGateway? paymentGateway;
  String? msg;
  Data? data;
  CustomerData? customerData;
  CashfreeData? cashfreeData;

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
    if (cashfreeData != null) {
      map['cashfree_data'] = cashfreeData?.toJson();
    }
    return map;
  }

}

class CashfreeData {
  CashfreeData({
      this.status, 
      this.response, 
      this.msg,});

  CashfreeData.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'] != null ? Response.fromJson(json['response']) : null;
    msg = json['msg'];
  }
  num? status;
  Response? response;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    map['msg'] = msg;
    return map;
  }

}

class Response {
  Response({
      this.cartDetails, 
      this.cfOrderId, 
      this.createdAt, 
      this.customerDetails, 
      this.entity, 
      this.orderAmount, 
      this.orderCurrency, 
      this.orderExpiryTime, 
      this.orderId, 
      this.orderMeta, 
      this.orderNote, 
      this.orderStatus, 
      this.orderTags, 
      this.paymentSessionId, 
      this.terminalData,});

  Response.fromJson(dynamic json) {
    cartDetails = json['cart_details'];
    cfOrderId = json['cf_order_id'];
    createdAt = json['created_at'];
    customerDetails = json['customer_details'] != null ? CustomerDetails.fromJson(json['customer_details']) : null;
    entity = json['entity'];
    orderAmount = json['order_amount'];
    orderCurrency = json['order_currency'];
    orderExpiryTime = json['order_expiry_time'];
    orderId = json['order_id'];
    orderMeta = json['order_meta'] != null ? OrderMeta.fromJson(json['order_meta']) : null;
    orderNote = json['order_note'];
    orderStatus = json['order_status'];
    orderTags = json['order_tags'];
    paymentSessionId = json['payment_session_id'];
    terminalData = json['terminal_data'];
  }
  dynamic cartDetails;
  String? cfOrderId;
  String? createdAt;
  CustomerDetails? customerDetails;
  String? entity;
  num? orderAmount;
  String? orderCurrency;
  String? orderExpiryTime;
  String? orderId;
  OrderMeta? orderMeta;
  dynamic orderNote;
  List<dynamic>? orderSplits;
  String? orderStatus;
  dynamic orderTags;
  String? paymentSessionId;
  dynamic terminalData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cart_details'] = cartDetails;
    map['cf_order_id'] = cfOrderId;
    map['created_at'] = createdAt;
    if (customerDetails != null) {
      map['customer_details'] = customerDetails?.toJson();
    }
    map['entity'] = entity;
    map['order_amount'] = orderAmount;
    map['order_currency'] = orderCurrency;
    map['order_expiry_time'] = orderExpiryTime;
    map['order_id'] = orderId;
    if (orderMeta != null) {
      map['order_meta'] = orderMeta?.toJson();
    }
    map['order_note'] = orderNote;
    if (orderSplits != null) {
      map['order_splits'] = orderSplits?.map((v) => v.toJson()).toList();
    }
    map['order_status'] = orderStatus;
    map['order_tags'] = orderTags;
    map['payment_session_id'] = paymentSessionId;
    map['terminal_data'] = terminalData;
    return map;
  }

}

class OrderMeta {
  OrderMeta({
      this.returnUrl, 
      this.notifyUrl, 
      this.paymentMethods,});

  OrderMeta.fromJson(dynamic json) {
    returnUrl = json['return_url'];
    notifyUrl = json['notify_url'];
    paymentMethods = json['payment_methods'];
  }
  String? returnUrl;
  String? notifyUrl;
  dynamic paymentMethods;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['return_url'] = returnUrl;
    map['notify_url'] = notifyUrl;
    map['payment_methods'] = paymentMethods;
    return map;
  }

}

class CustomerDetails {
  CustomerDetails({
      this.customerId, 
      this.customerName, 
      this.customerEmail, 
      this.customerPhone, 
      this.customerUid,});

  CustomerDetails.fromJson(dynamic json) {
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerPhone = json['customer_phone'];
    customerUid = json['customer_uid'];
  }
  String? customerId;
  String? customerName;
  String? customerEmail;
  String? customerPhone;
  dynamic customerUid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customer_id'] = customerId;
    map['customer_name'] = customerName;
    map['customer_email'] = customerEmail;
    map['customer_phone'] = customerPhone;
    map['customer_uid'] = customerUid;
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
      this.age, 
      this.customerImg, 
      this.longitude, 
      this.birthPlace, 
      this.birthTime, 
      this.latitude, 
      this.processStatus, 
      this.roleId, 
      this.userUniId, 
      this.adminId, 
      this.packageUniId, 
      this.packageValidDate, 
      this.name, 
      this.email, 
      this.username, 
      this.password, 
      this.passwordResets, 
      this.pstr, 
      this.phone, 
      this.panNo, 
      this.aadhaarNo, 
      this.avgRating, 
      this.welcomeMail, 
      this.isRecharge, 
      this.rememberToken, 
      this.userFcmToken, 
      this.deviceToken, 
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
    age = json['age'];
    customerImg = json['customer_img'];
    longitude = json['longitude'];
    birthPlace = json['birth_place'];
    birthTime = json['birth_time'];
    latitude = json['latitude'];
    processStatus = json['process_status'];
    roleId = json['role_id'];
    userUniId = json['user_uni_id'];
    adminId = json['admin_id'];
    packageUniId = json['package_uni_id'];
    packageValidDate = json['package_valid_date'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    passwordResets = json['password_resets'];
    pstr = json['pstr'];
    phone = json['phone'];
    panNo = json['pan_no'];
    aadhaarNo = json['aadhaar_no'];
    avgRating = json['avg_rating'];
    welcomeMail = json['welcome_mail'];
    isRecharge = json['is_recharge'];
    rememberToken = json['remember_token'];
    userFcmToken = json['user_fcm_token'];
    deviceToken = json['device_token'];
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
  dynamic age;
  String? customerImg;
  String? longitude;
  String? birthPlace;
  String? birthTime;
  String? latitude;
  num? processStatus;
  num? roleId;
  String? userUniId;
  dynamic adminId;
  dynamic packageUniId;
  dynamic packageValidDate;
  String? name;
  String? email;
  dynamic username;
  dynamic password;
  dynamic passwordResets;
  dynamic pstr;
  String? phone;
  dynamic panNo;
  dynamic aadhaarNo;
  String? avgRating;
  num? welcomeMail;
  num? isRecharge;
  dynamic rememberToken;
  String? userFcmToken;
  dynamic deviceToken;
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
    map['age'] = age;
    map['customer_img'] = customerImg;
    map['longitude'] = longitude;
    map['birth_place'] = birthPlace;
    map['birth_time'] = birthTime;
    map['latitude'] = latitude;
    map['process_status'] = processStatus;
    map['role_id'] = roleId;
    map['user_uni_id'] = userUniId;
    map['admin_id'] = adminId;
    map['package_uni_id'] = packageUniId;
    map['package_valid_date'] = packageValidDate;
    map['name'] = name;
    map['email'] = email;
    map['username'] = username;
    map['password'] = password;
    map['password_resets'] = passwordResets;
    map['pstr'] = pstr;
    map['phone'] = phone;
    map['pan_no'] = panNo;
    map['aadhaar_no'] = aadhaarNo;
    map['avg_rating'] = avgRating;
    map['welcome_mail'] = welcomeMail;
    map['is_recharge'] = isRecharge;
    map['remember_token'] = rememberToken;
    map['user_fcm_token'] = userFcmToken;
    map['device_token'] = deviceToken;
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
      this.myWalletAmount,});

  Data.fromJson(dynamic json) {
    productAmount = json['product_amount'];
    item = json['item'];
    referenceAmount = json['reference_amount'];
    referenceTdsAmount = json['reference_tds_amount'];
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
    myWalletAmount = json['my_wallet_amount'];
  }
  num? productAmount;
  String? item;
  num? referenceAmount;
  num? referenceTdsAmount;
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
  num? myWalletAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_amount'] = productAmount;
    map['item'] = item;
    map['reference_amount'] = referenceAmount;
    map['reference_tds_amount'] = referenceTdsAmount;
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
    map['my_wallet_amount'] = myWalletAmount;
    return map;
  }

}

class PaymentGateway {
  PaymentGateway({
      this.gatewayOrderId, 
      this.amount, 
      this.returnUrl, 
      this.notifyUrl, 
      this.customerId, 
      this.customerPhone, 
      this.customerName, 
      this.customerEmail,});

  PaymentGateway.fromJson(dynamic json) {
    gatewayOrderId = json['gateway_order_id'];
    amount = json['amount'];
    returnUrl = json['returnUrl'];
    notifyUrl = json['notifyUrl'];
    customerId = json['customer_id'];
    customerPhone = json['customer_phone'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
  }
  String? gatewayOrderId;
  num? amount;
  String? returnUrl;
  String? notifyUrl;
  String? customerId;
  String? customerPhone;
  String? customerName;
  String? customerEmail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gateway_order_id'] = gatewayOrderId;
    map['amount'] = amount;
    map['returnUrl'] = returnUrl;
    map['notifyUrl'] = notifyUrl;
    map['customer_id'] = customerId;
    map['customer_phone'] = customerPhone;
    map['customer_name'] = customerName;
    map['customer_email'] = customerEmail;
    return map;
  }

}