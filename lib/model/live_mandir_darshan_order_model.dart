class LiveMandirDarshanOrderModel {
  LiveMandirDarshanOrderModel({
      this.status, 
      this.offset, 
      this.data, 
      this.msg,});

  LiveMandirDarshanOrderModel.fromJson(dynamic json) {
    status = json['status'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(MandirDarshanOrderData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  num? offset;
  List<MandirDarshanOrderData>? data;
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

class MandirDarshanOrderData {
  MandirDarshanOrderData({
      this.id, 
      this.liveTempleDarshanAssignId, 
      this.customerUniId, 
      this.astrologerUniId, 
      this.orderId, 
      this.price, 
      this.liveTempleDarshanDate, 
      this.liveTempleDarshanTime, 
      this.liveTempleDarshanChannelName, 
      this.custName, 
      this.place, 
      this.gotra, 
      this.status, 
      this.paymentStatus, 
      this.refundValidDate, 
      this.createdAt, 
      this.updatedAt, 
      this.isAvailable, 
      this.userAstrologer, 
      this.liveTempleDarshanAssign, 
      this.astrologer, 
      this.userCustomer, 
      this.customer,});

  MandirDarshanOrderData.fromJson(dynamic json) {
    id = json['id'];
    liveTempleDarshanAssignId = json['live_temple_darshan_assign_id'];
    customerUniId = json['customer_uni_id'];
    astrologerUniId = json['astrologer_uni_id'];
    orderId = json['order_id'];
    price = json['price'];
    liveTempleDarshanDate = json['live_temple_darshan_date'];
    liveTempleDarshanTime = json['live_temple_darshan_time'];
    liveTempleDarshanChannelName = json['live_temple_darshan_channel_name'];
    custName = json['cust_name'];
    place = json['place'];
    gotra = json['gotra'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    refundValidDate = json['refund_valid_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isAvailable = json['is_available'];
    userAstrologer = json['user_astrologer'] != null ? UserAstrologer.fromJson(json['user_astrologer']) : null;
    liveTempleDarshanAssign = json['live_temple_darshan_assign'] != null ? LiveTempleDarshanAssign.fromJson(json['live_temple_darshan_assign']) : null;
    astrologer = json['astrologer'] != null ? Astrologer.fromJson(json['astrologer']) : null;
    userCustomer = json['user_customer'] != null ? UserCustomer.fromJson(json['user_customer']) : null;
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }
  num? id;
  num? liveTempleDarshanAssignId;
  String? customerUniId;
  String? astrologerUniId;
  String? orderId;
  String? price;
  dynamic liveTempleDarshanDate;
  dynamic liveTempleDarshanTime;
  String? liveTempleDarshanChannelName;
  String? custName;
  String? place;
  String? gotra;
  String? status;
  String? paymentStatus;
  dynamic refundValidDate;
  String? createdAt;
  String? updatedAt;
  num? isAvailable;
  UserAstrologer? userAstrologer;
  LiveTempleDarshanAssign? liveTempleDarshanAssign;
  Astrologer? astrologer;
  UserCustomer? userCustomer;
  Customer? customer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['live_temple_darshan_assign_id'] = liveTempleDarshanAssignId;
    map['customer_uni_id'] = customerUniId;
    map['astrologer_uni_id'] = astrologerUniId;
    map['order_id'] = orderId;
    map['price'] = price;
    map['live_temple_darshan_date'] = liveTempleDarshanDate;
    map['live_temple_darshan_time'] = liveTempleDarshanTime;
    map['live_temple_darshan_channel_name'] = liveTempleDarshanChannelName;
    map['cust_name'] = custName;
    map['place'] = place;
    map['gotra'] = gotra;
    map['status'] = status;
    map['payment_status'] = paymentStatus;
    map['refund_valid_date'] = refundValidDate;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_available'] = isAvailable;
    if (userAstrologer != null) {
      map['user_astrologer'] = userAstrologer?.toJson();
    }
    if (liveTempleDarshanAssign != null) {
      map['live_temple_darshan_assign'] = liveTempleDarshanAssign?.toJson();
    }
    if (astrologer != null) {
      map['astrologer'] = astrologer?.toJson();
    }
    if (userCustomer != null) {
      map['user_customer'] = userCustomer?.toJson();
    }
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    return map;
  }

}

class Customer {
  Customer({
      this.id, 
      this.customerUniId, 
      this.customerImg,});

  Customer.fromJson(dynamic json) {
    id = json['id'];
    customerUniId = json['customer_uni_id'];
    customerImg = json['customer_img'];
  }
  num? id;
  String? customerUniId;
  String? customerImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['customer_uni_id'] = customerUniId;
    map['customer_img'] = customerImg;
    return map;
  }

}

class UserCustomer {
  UserCustomer({
      this.id, 
      this.userUniId, 
      this.name, 
      this.userFcmToken, 
      this.userIosToken, 
      this.avgRating, 
      this.fullInfo,});

  UserCustomer.fromJson(dynamic json) {
    id = json['id'];
    userUniId = json['user_uni_id'];
    name = json['name'];
    userFcmToken = json['user_fcm_token'];
    userIosToken = json['user_ios_token'];
    avgRating = json['avg_rating'];
    fullInfo = json['full_info'];
  }
  num? id;
  String? userUniId;
  String? name;
  String? userFcmToken;
  String? userIosToken;
  String? avgRating;
  String? fullInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_uni_id'] = userUniId;
    map['name'] = name;
    map['user_fcm_token'] = userFcmToken;
    map['user_ios_token'] = userIosToken;
    map['avg_rating'] = avgRating;
    map['full_info'] = fullInfo;
    return map;
  }

}

class Astrologer {
  Astrologer({
      this.id, 
      this.astrologerUniId, 
      this.displayName, 
      this.slug, 
      this.astroImg,});

  Astrologer.fromJson(dynamic json) {
    id = json['id'];
    astrologerUniId = json['astrologer_uni_id'];
    displayName = json['display_name'];
    slug = json['slug'];
    astroImg = json['astro_img'];
  }
  num? id;
  String? astrologerUniId;
  String? displayName;
  String? slug;
  String? astroImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['astrologer_uni_id'] = astrologerUniId;
    map['display_name'] = displayName;
    map['slug'] = slug;
    map['astro_img'] = astroImg;
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
      this.updatedAt, 
      this.liveTempleDarshan,});

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
    liveTempleDarshan = json['live_temple_darshan'] != null ? LiveTempleDarshan.fromJson(json['live_temple_darshan']) : null;
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
  LiveTempleDarshan? liveTempleDarshan;

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
    if (liveTempleDarshan != null) {
      map['live_temple_darshan'] = liveTempleDarshan?.toJson();
    }
    return map;
  }

}

class LiveTempleDarshan {
  LiveTempleDarshan({
      this.id, 
      this.liveTempleDarshanName, 
      this.slug, 
      this.liveTempleDarshanImage, 
      this.liveTempleDarshanDescription,});

  LiveTempleDarshan.fromJson(dynamic json) {
    id = json['id'];
    liveTempleDarshanName = json['live_temple_darshan_name'];
    slug = json['slug'];
    liveTempleDarshanImage = json['live_temple_darshan_image'];
    liveTempleDarshanDescription = json['live_temple_darshan_description'];
  }
  num? id;
  String? liveTempleDarshanName;
  String? slug;
  String? liveTempleDarshanImage;
  String? liveTempleDarshanDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['live_temple_darshan_name'] = liveTempleDarshanName;
    map['slug'] = slug;
    map['live_temple_darshan_image'] = liveTempleDarshanImage;
    map['live_temple_darshan_description'] = liveTempleDarshanDescription;
    return map;
  }

}

class UserAstrologer {
  UserAstrologer({
      this.id, 
      this.userUniId, 
      this.name, 
      this.userFcmToken, 
      this.userIosToken, 
      this.avgRating, 
      this.fullInfo,});

  UserAstrologer.fromJson(dynamic json) {
    id = json['id'];
    userUniId = json['user_uni_id'];
    name = json['name'];
    userFcmToken = json['user_fcm_token'];
    userIosToken = json['user_ios_token'];
    avgRating = json['avg_rating'];
    fullInfo = json['full_info'];
  }
  num? id;
  String? userUniId;
  String? name;
  String? userFcmToken;
  String? userIosToken;
  String? avgRating;
  String? fullInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_uni_id'] = userUniId;
    map['name'] = name;
    map['user_fcm_token'] = userFcmToken;
    map['user_ios_token'] = userIosToken;
    map['avg_rating'] = avgRating;
    map['full_info'] = fullInfo;
    return map;
  }

}