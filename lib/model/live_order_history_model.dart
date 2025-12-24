class LiveOrderHistoryModel {
  LiveOrderHistoryModel({
      this.status, 
      this.msg, 
      this.data,});

  LiveOrderHistoryModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(LiveOrderData.fromJson(v));
      });
    }
  }
  num? status;
  String? msg;
  List<LiveOrderData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class LiveOrderData {
  LiveOrderData({
      this.id, 
      this.userId, 
      this.astrologerUniId, 
      this.amount, 
      this.giftId, 
      this.createdAt, 
      this.updatedAt, 
      this.userAstrologer, 
      this.gift, 
      this.astrologer,});

  LiveOrderData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    astrologerUniId = json['astrologer_uni_id'];
    amount = json['amount'];
    giftId = json['gift_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userAstrologer = json['user_astrologer'] != null ? UserAstrologer.fromJson(json['user_astrologer']) : null;
    gift = json['gift'] != null ? Gift.fromJson(json['gift']) : null;
    astrologer = json['astrologer'] != null ? Astrologer.fromJson(json['astrologer']) : null;
  }
  num? id;
  String? userId;
  String? astrologerUniId;
  String? amount;
  num? giftId;
  String? createdAt;
  String? updatedAt;
  UserAstrologer? userAstrologer;
  Gift? gift;
  Astrologer? astrologer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['astrologer_uni_id'] = astrologerUniId;
    map['amount'] = amount;
    map['gift_id'] = giftId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (userAstrologer != null) {
      map['user_astrologer'] = userAstrologer?.toJson();
    }
    if (gift != null) {
      map['gift'] = gift?.toJson();
    }
    if (astrologer != null) {
      map['astrologer'] = astrologer?.toJson();
    }
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

class Gift {
  Gift({
      this.id, 
      this.giftName, 
      this.giftPrice, 
      this.giftImage, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  Gift.fromJson(dynamic json) {
    id = json['id'];
    giftName = json['gift_name'];
    giftPrice = json['gift_price'];
    giftImage = json['gift_image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? giftName;
  String? giftPrice;
  String? giftImage;
  num? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['gift_name'] = giftName;
    map['gift_price'] = giftPrice;
    map['gift_image'] = giftImage;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class UserAstrologer {
  UserAstrologer({
      this.id, 
      this.userUniId, 
      this.name, 
      this.avgRating, 
      this.fullInfo,});

  UserAstrologer.fromJson(dynamic json) {
    id = json['id'];
    userUniId = json['user_uni_id'];
    name = json['name'];
    avgRating = json['avg_rating'];
    fullInfo = json['full_info'];
  }
  num? id;
  String? userUniId;
  String? name;
  String? avgRating;
  String? fullInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_uni_id'] = userUniId;
    map['name'] = name;
    map['avg_rating'] = avgRating;
    map['full_info'] = fullInfo;
    return map;
  }

}