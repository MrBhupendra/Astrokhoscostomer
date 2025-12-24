class GroupPoojaOrderModel {
  GroupPoojaOrderModel({
      this.status, 
      this.offset, 
      this.data, 
      this.msg,});

  GroupPoojaOrderModel.fromJson(dynamic json) {
    status = json['status'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(GroupPoojaOrderData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  num? offset;
  List<GroupPoojaOrderData>? data;
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

class GroupPoojaOrderData {
  GroupPoojaOrderData({
      this.id, 
      this.groupPujaAssignId, 
      this.customerUniId, 
      this.astrologerUniId, 
      this.orderId, 
      this.price, 
      this.groupPujaDate, 
      this.groupPujaTime, 
      this.groupPujaChannelName, 
      this.status, 
      this.paymentStatus, 
      this.refundValidDate, 
      this.createdAt, 
      this.updatedAt, 
      this.isAvailable, 
      this.groupPujaAssign, 
      this.userAstrologer, 
      this.astrologer, 
      this.userCustomer, 
      this.customer,});

  GroupPoojaOrderData.fromJson(dynamic json) {
    id = json['id'];
    groupPujaAssignId = json['group_puja_assign_id'];
    customerUniId = json['customer_uni_id'];
    astrologerUniId = json['astrologer_uni_id'];
    orderId = json['order_id'];
    price = json['price'];
    groupPujaDate = json['group_puja_date'];
    groupPujaTime = json['group_puja_time'];
    groupPujaChannelName = json['group_puja_channel_name'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    refundValidDate = json['refund_valid_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isAvailable = json['is_available'];
    groupPujaAssign = json['group_puja_assign'] != null ? GroupPujaAssign.fromJson(json['group_puja_assign']) : null;
    userAstrologer = json['user_astrologer'] != null ? UserAstrologer.fromJson(json['user_astrologer']) : null;
    astrologer = json['astrologer'] != null ? Astrologer.fromJson(json['astrologer']) : null;
    userCustomer = json['user_customer'] != null ? UserCustomer.fromJson(json['user_customer']) : null;
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }
  num? id;
  num? groupPujaAssignId;
  String? customerUniId;
  String? astrologerUniId;
  String? orderId;
  String? price;
  String? groupPujaDate;
  String? groupPujaTime;
  String? groupPujaChannelName;
  String? status;
  String? paymentStatus;
  dynamic refundValidDate;
  String? createdAt;
  String? updatedAt;
  num? isAvailable;
  GroupPujaAssign? groupPujaAssign;
  UserAstrologer? userAstrologer;
  Astrologer? astrologer;
  UserCustomer? userCustomer;
  Customer? customer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['group_puja_assign_id'] = groupPujaAssignId;
    map['customer_uni_id'] = customerUniId;
    map['astrologer_uni_id'] = astrologerUniId;
    map['order_id'] = orderId;
    map['price'] = price;
    map['group_puja_date'] = groupPujaDate;
    map['group_puja_time'] = groupPujaTime;
    map['group_puja_channel_name'] = groupPujaChannelName;
    map['status'] = status;
    map['payment_status'] = paymentStatus;
    map['refund_valid_date'] = refundValidDate;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_available'] = isAvailable;
    if (groupPujaAssign != null) {
      map['group_puja_assign'] = groupPujaAssign?.toJson();
    }
    if (userAstrologer != null) {
      map['user_astrologer'] = userAstrologer?.toJson();
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

class GroupPujaAssign {
  GroupPujaAssign({
      this.id, 
      this.groupPujaId, 
      this.astrologerUniId, 
      this.price, 
      this.groupPujaDate, 
      this.groupPujaTime, 
      this.description, 
      this.duration, 
      this.groupPujaChannelName, 
      this.availableDuration, 
      this.startTime, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.groupPuja,});

  GroupPujaAssign.fromJson(dynamic json) {
    id = json['id'];
    groupPujaId = json['group_puja_id'];
    astrologerUniId = json['astrologer_uni_id'];
    price = json['price'];
    groupPujaDate = json['group_puja_date'];
    groupPujaTime = json['group_puja_time'];
    description = json['description'];
    duration = json['duration'];
    groupPujaChannelName = json['group_puja_channel_name'];
    availableDuration = json['available_duration'];
    startTime = json['start_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    groupPuja = json['group_puja'] != null ? GroupPuja.fromJson(json['group_puja']) : null;
  }
  num? id;
  num? groupPujaId;
  String? astrologerUniId;
  String? price;
  String? groupPujaDate;
  String? groupPujaTime;
  String? description;
  num? duration;
  String? groupPujaChannelName;
  num? availableDuration;
  String? startTime;
  num? status;
  String? createdAt;
  String? updatedAt;
  GroupPuja? groupPuja;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['group_puja_id'] = groupPujaId;
    map['astrologer_uni_id'] = astrologerUniId;
    map['price'] = price;
    map['group_puja_date'] = groupPujaDate;
    map['group_puja_time'] = groupPujaTime;
    map['description'] = description;
    map['duration'] = duration;
    map['group_puja_channel_name'] = groupPujaChannelName;
    map['available_duration'] = availableDuration;
    map['start_time'] = startTime;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (groupPuja != null) {
      map['group_puja'] = groupPuja?.toJson();
    }
    return map;
  }

}

class GroupPuja {
  GroupPuja({
      this.id, 
      this.groupPujaCategoryId, 
      this.groupPujaName, 
      this.slug, 
      this.groupPujaImage, 
      this.groupPujaDescription,});

  GroupPuja.fromJson(dynamic json) {
    id = json['id'];
    groupPujaCategoryId = json['group_puja_category_id'];
    groupPujaName = json['group_puja_name'];
    slug = json['slug'];
    groupPujaImage = json['group_puja_image'];
    groupPujaDescription = json['group_puja_description'];
  }
  num? id;
  num? groupPujaCategoryId;
  String? groupPujaName;
  String? slug;
  String? groupPujaImage;
  String? groupPujaDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['group_puja_category_id'] = groupPujaCategoryId;
    map['group_puja_name'] = groupPujaName;
    map['slug'] = slug;
    map['group_puja_image'] = groupPujaImage;
    map['group_puja_description'] = groupPujaDescription;
    return map;
  }

}