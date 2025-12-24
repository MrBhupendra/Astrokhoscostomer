class SubscriptionPurchaseModel {
  SubscriptionPurchaseModel({
      this.status, 
      this.offset, 
      this.data, 
      this.msg,});

  SubscriptionPurchaseModel.fromJson(dynamic json) {
    status = json['status'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  num? offset;
  List<Data>? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['offset'] = offset;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.orderId, 
      this.userUniId, 
      this.subscriptionId, 
      this.title, 
      this.validityInDays, 
      this.remainChatDuration,
      this.productOrderCount,
      this.productOrderDiscount,
      this.remainProductOrderCount,
      this.remainProductOrderDiscount,
      this.remainVideoCallDuration,
      this.remainVoiceCallDuration,
      this.subscriptionStatus,
      this.startDateTime,
      this.endDateTime, 
      this.videoCallDuration, 
      this.voiceCallDuration, 
      this.chatDuration, 
      this.price, 
      this.status, 
      this.paymentStatus, 
      this.createdAt, 
      this.updatedAt, 
      this.user,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    orderId = json['order_id'];
    userUniId = json['user_uni_id'];
    subscriptionId = json['subscription_id'];
    title = json['title'];
    validityInDays = json['validity_in_days'];
    remainChatDuration = json['remain_chat_duration'];
    productOrderCount = json['product_order_count'];
    productOrderDiscount = json['product_order_discount'];
    remainProductOrderCount = json['remain_product_order_count'];
    remainProductOrderDiscount = json['remain_product_order_discount'];
    remainVideoCallDuration = json['remain_video_call_duration'];
    remainVoiceCallDuration = json['remain_voice_call_duration'];
    subscriptionStatus = json['subscription_status'];
    startDateTime = json['start_date_time'];
    endDateTime = json['end_date_time'];
    videoCallDuration = json['video_call_duration'];
    voiceCallDuration = json['voice_call_duration'];
    chatDuration = json['chat_duration'];
    price = json['price'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  num? id;
  String? orderId;
  String? userUniId;
  num? subscriptionId;
  String? title;
  num? validityInDays;
  num? remainChatDuration;
  num? productOrderCount;
  String? productOrderDiscount;
  num? remainProductOrderCount;
  String? remainProductOrderDiscount;
  num? remainVoiceCallDuration;
  num? remainVideoCallDuration;
  String? subscriptionStatus;
  String? startDateTime;
  String? endDateTime;
  num? videoCallDuration;
  num? voiceCallDuration;
  num? chatDuration;
  num? price;
  num? status;
  num? paymentStatus;
  String? createdAt;
  String? updatedAt;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_id'] = orderId;
    map['user_uni_id'] = userUniId;
    map['subscription_id'] = subscriptionId;
    map['title'] = title;
    map['validity_in_days'] = validityInDays;
    map['remain_chat_duration'] = remainChatDuration;
    map['product_order_count'] = productOrderCount;
    map['product_order_discount'] = productOrderDiscount;
    map['remain_product_order_count'] = remainProductOrderCount;
    map['remain_product_order_discount'] = remainProductOrderDiscount;
    map['remain_video_call_duration'] = remainVideoCallDuration;
    map['remain_voice_call_duration'] = remainVoiceCallDuration;
    map['subscription_status'] = subscriptionStatus;
    map['start_date_time'] = startDateTime;
    map['end_date_time'] = endDateTime;
    map['video_call_duration'] = videoCallDuration;
    map['voice_call_duration'] = voiceCallDuration;
    map['chat_duration'] = chatDuration;
    map['price'] = price;
    map['status'] = status;
    map['payment_status'] = paymentStatus;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

class User {
  User({
      this.id, 
      this.roleId, 
      this.userUniId, 
      this.referralCode, 
      this.adminId, 
      this.packageUniId, 
      this.packageValidDate, 
      this.name, 
      this.email, 
      this.username, 
      this.passwordResets, 
      this.pstr, 
      this.phone, 
      this.countryCode, 
      this.countryName, 
      this.secondaryPhone, 
      this.secondaryCountryCode, 
      this.panNo, 
      this.aadhaarNo, 
      this.avgRating, 
      this.welcomeMail, 
      this.isRecharge, 
      this.userFcmToken, 
      this.isUninstalled, 
      this.deviceToken, 
      this.userIosToken, 
      this.firebaseAuthToken, 
      this.trash, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.fullInfo,});

  User.fromJson(dynamic json) {
    id = json['id'];
    roleId = json['role_id'];
    userUniId = json['user_uni_id'];
    referralCode = json['referral_code'];
    adminId = json['admin_id'];
    packageUniId = json['package_uni_id'];
    packageValidDate = json['package_valid_date'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    passwordResets = json['password_resets'];
    pstr = json['pstr'];
    phone = json['phone'];
    countryCode = json['country_code'];
    countryName = json['country_name'];
    secondaryPhone = json['secondary_phone'];
    secondaryCountryCode = json['secondary_country_code'];
    panNo = json['pan_no'];
    aadhaarNo = json['aadhaar_no'];
    avgRating = json['avg_rating'];
    welcomeMail = json['welcome_mail'];
    isRecharge = json['is_recharge'];
    userFcmToken = json['user_fcm_token'];
    isUninstalled = json['is_uninstalled'];
    deviceToken = json['device_token'];
    userIosToken = json['user_ios_token'];
    firebaseAuthToken = json['firebase_auth_token'];
    trash = json['trash'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullInfo = json['full_info'];
  }
  num? id;
  num? roleId;
  String? userUniId;
  dynamic referralCode;
  dynamic adminId;
  dynamic packageUniId;
  dynamic packageValidDate;
  String? name;
  String? email;
  dynamic username;
  dynamic passwordResets;
  dynamic pstr;
  String? phone;
  String? countryCode;
  String? countryName;
  dynamic secondaryPhone;
  dynamic secondaryCountryCode;
  dynamic panNo;
  dynamic aadhaarNo;
  String? avgRating;
  num? welcomeMail;
  num? isRecharge;
  String? userFcmToken;
  num? isUninstalled;
  dynamic deviceToken;
  String? userIosToken;
  String? firebaseAuthToken;
  num? trash;
  num? status;
  String? createdAt;
  String? updatedAt;
  String? fullInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['role_id'] = roleId;
    map['user_uni_id'] = userUniId;
    map['referral_code'] = referralCode;
    map['admin_id'] = adminId;
    map['package_uni_id'] = packageUniId;
    map['package_valid_date'] = packageValidDate;
    map['name'] = name;
    map['email'] = email;
    map['username'] = username;
    map['password_resets'] = passwordResets;
    map['pstr'] = pstr;
    map['phone'] = phone;
    map['country_code'] = countryCode;
    map['country_name'] = countryName;
    map['secondary_phone'] = secondaryPhone;
    map['secondary_country_code'] = secondaryCountryCode;
    map['pan_no'] = panNo;
    map['aadhaar_no'] = aadhaarNo;
    map['avg_rating'] = avgRating;
    map['welcome_mail'] = welcomeMail;
    map['is_recharge'] = isRecharge;
    map['user_fcm_token'] = userFcmToken;
    map['is_uninstalled'] = isUninstalled;
    map['device_token'] = deviceToken;
    map['user_ios_token'] = userIosToken;
    map['firebase_auth_token'] = firebaseAuthToken;
    map['trash'] = trash;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['full_info'] = fullInfo;
    return map;
  }

}