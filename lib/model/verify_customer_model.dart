class VerifyCustomerModel {
  VerifyCustomerModel({
    this.status,
    this.data,
    this.msg,
  });

  VerifyCustomerModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  num? status;
  Data? data;
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

class Data {
  Data({
    this.id,
    this.customerUniId,
    this.birthDate,
    this.gender,
    this.customerImg,
    this.longitude,
    this.timezone,
    this.birthPlace,
    this.birthTime,
    this.latitude,
    this.processStatus,
    this.uid,
    this.phone,
    this.name,
    this.email,
    this.status,
    this.userApiKey,
    this.firebaseAuthToken,
    this.currencyCode,
    this.currencySymbol
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    customerUniId = json['customer_uni_id'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    customerImg = json['customer_img'];
    longitude = json['longitude'];
    timezone = json['time_zone'];
    birthPlace = json['birth_place'];
    birthTime = json['birth_time'];
    latitude = json['latitude'];
    processStatus = json['process_status'];
    uid = json['uid'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
    userApiKey = json['user_api_key'];
    firebaseAuthToken = json['firebase_auth_token'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
  }

  num? id;
  String? customerUniId;
  String? birthDate;
  String? gender;
  String? customerImg;
  String? longitude;
  String? timezone;
  String? birthPlace;
  String? birthTime;
  String? latitude;
  num? processStatus;
  num? uid;
  String? phone;
  String? name;
  String? email;
  num? status;
  String? userApiKey;
  String? firebaseAuthToken;
  String? currencyCode;
  String? currencySymbol;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['customer_uni_id'] = customerUniId;
    map['birth_date'] = birthDate;
    map['gender'] = gender;
    map['customer_img'] = customerImg;
    map['longitude'] = longitude;
    map['time_zone'] = timezone;
    map['birth_place'] = birthPlace;
    map['birth_time'] = birthTime;
    map['latitude'] = latitude;
    map['process_status'] = processStatus;
    map['uid'] = uid;
    map['phone'] = phone;
    map['name'] = name;
    map['email'] = email;
    map['status'] = status;
    map['user_api_key'] = userApiKey;
    map['firebase_auth_token'] = firebaseAuthToken;
    map['currency_code'] = currencyCode;
    map['currency_symbol'] = currencySymbol;
    return map;
  }
}
