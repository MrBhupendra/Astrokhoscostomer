import 'package:astro_brahmand/model/review_model.dart';

import 'blog_model.dart';

class AstrologerModel {
  AstrologerModel({
    this.status,
    this.msg,
    this.count,
    this.offset,
    this.data,
  });

  AstrologerModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    count = json['count'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AstrologerData.fromJson(v));
      });
    }
  }

  num? status;
  String? msg;
  num? count;
  num? offset;
  List<AstrologerData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    map['count'] = count;
    map['offset'] = offset;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class AstrologerData {
  AstrologerData({
    this.id,
    this.slug,
    this.userId,
    this.astrologerUniId,
    this.displayName,
    this.birthDate,
    this.gender,
    this.experience,
    this.astroImg,
    this.liveStatus,
    this.videoStatus,
    this.onlineStatus,
    this.callStatus,
    this.chatStatus,
    this.emergencyCallStatus,
    this.emergencyChatStatus,
    this.emergencyVideoStatus,
    this.busyStatus,
    this.longBiography,
    this.tag,
    this.isVerified,
    this.totalCallDuration,
    this.totalChatDuration,
    this.totalVideoDuration,
    this.reviewCount,
    this.totalWaitingTime,
    this.totalQueueCount,
    this.isFollow,
    this.followerCount,
    this.totalCall,
    this.categoryNames,
    this.skillNames,
    this.languageName,
    this.liveChannel,
    this.liveTopic,
    this.reviews,
    this.blogs,
    this.galleryImageList,
    this.user,
    this.prices,
    this.totalOrderCount,
    this.isSlotAvailable,
    this.isVirtualAstrologer,
  });

  AstrologerData.fromJson(dynamic json) {
    id = json['id'];
    slug = json['slug'];
    userId = json['user_id'];
    astrologerUniId = json['astrologer_uni_id'];
    displayName = json['display_name'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    experience = json['experience'];
    astroImg = json['astro_img'];
    liveStatus = json['live_status'];
    videoStatus = json['video_status'];
    onlineStatus = json['online_status'];
    callStatus = json['call_status'];
    chatStatus = json['chat_status'];
    emergencyCallStatus = json['emergency_call_status'];
    emergencyChatStatus = json['emergency_chat_status'];
    emergencyVideoStatus = json['emergency_video_status'];
    busyStatus = json['busy_status'];
    longBiography = json['long_biography'];
    tag = json['tag'];
    isVerified = json['is_verified'];
    totalCallDuration = json['total_call_duration'];
    totalChatDuration = json['total_chat_duration'];
    totalVideoDuration = json['total_video_duration'];
    reviewCount = json['review_count'];
    totalWaitingTime = json['total_waiting_time'];
    totalQueueCount = json['total_queue_count'];
    isFollow = json['is_follow'];
    followerCount = json['follower_count'];
    totalCall = json['total_call'];
    categoryNames = json['category_names'];
    skillNames = json['skill_names'];
    languageName = json['language_name'];
    liveChannel = json['livechannel'];
    liveTopic = json['live_topic'];
    isSlotAvailable = json['is_slot_available'];
    isVirtualAstrologer = json['is_virtual'];
    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews?.add(ReviewsData.fromJson(v));
      });
    }
    if (json['blogs'] != null) {
      blogs = [];
      json['blogs'].forEach((v) {
        blogs?.add(BlogsData.fromJson(v));
      });
    }
    galleryImageList = json['gallery_image_list'] != null
        ? json['gallery_image_list'].cast<String>()
        : [];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['prices'] != null) {
      prices = [];
      json['prices'].forEach((v) {
        prices?.add(Prices.fromJson(v));
      });
      totalOrderCount = json['total_orders_count'];
    }
  }

  num? id;
  String? slug;
  num? userId;
  String? astrologerUniId;
  String? displayName;
  String? birthDate;
  String? gender;
  num? experience;
  String? astroImg;
  num? liveStatus;
  num? videoStatus;
  num? onlineStatus;
  num? callStatus;
  num? chatStatus;
  num? emergencyCallStatus;
  num? emergencyChatStatus;
  num? emergencyVideoStatus;
  num? busyStatus;
  String? longBiography;
  String? tag;
  num? isVerified;
  String? totalCallDuration;
  String? totalChatDuration;
  String? totalVideoDuration;
  num? reviewCount;
  num? totalWaitingTime;
  num? totalQueueCount;
  bool? isFollow;
  num? followerCount;
  String? totalCall;
  String? categoryNames;
  String? skillNames;
  String? languageName;
  String? liveChannel;
  String? liveTopic;
  List<ReviewsData>? reviews;
  List<BlogsData>? blogs;
  List<String>? galleryImageList;
  User? user;
  List<Prices>? prices;
  String? totalOrderCount;
  int? isSlotAvailable;
  int? isVirtualAstrologer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['slug'] = slug;
    map['user_id'] = userId;
    map['astrologer_uni_id'] = astrologerUniId;
    map['display_name'] = displayName;
    map['birth_date'] = birthDate;
    map['gender'] = gender;
    map['experience'] = experience;
    map['astro_img'] = astroImg;
    map['live_status'] = liveStatus;
    map['video_status'] = videoStatus;
    map['online_status'] = onlineStatus;
    map['call_status'] = callStatus;
    map['chat_status'] = chatStatus;
    map['emergency_call_status'] = emergencyCallStatus;
    map['emergency_chat_status'] = emergencyChatStatus;
    map['emergency_video_status'] = emergencyVideoStatus;
    map['busy_status'] = busyStatus;
    map['long_biography'] = longBiography;
    map['tag'] = tag;
    map['is_verified'] = isVerified;
    map['total_call_duration'] = totalCallDuration;
    map['total_chat_duration'] = totalChatDuration;
    map['total_video_duration'] = totalVideoDuration;
    map['review_count'] = reviewCount;
    map['total_waiting_time'] = totalWaitingTime;
    map['total_queue_count'] = totalQueueCount;
    map['is_follow'] = isFollow;
    map['follower_count'] = followerCount;
    map['total_call'] = totalCall;
    map['category_names'] = categoryNames;
    map['skill_names'] = skillNames;
    map['language_name'] = languageName;
    map['livechannel'] = liveChannel;
    map['live_topic'] = liveTopic;
    map['is_slot_available'] = isSlotAvailable;
    map['is_virtual'] = isVirtualAstrologer;
    if (reviews != null) {
      map['reviews'] = reviews?.map((v) => v.toJson()).toList();
    }
    if (blogs != null) {
      map['blogs'] = blogs?.map((v) => v.toJson()).toList();
    }
    map['gallery_image_list'] = galleryImageList;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (prices != null) {
      map['prices'] = prices?.map((v) => v.toJson()).toList();
    }
    map['total_orders_count'] = totalOrderCount;
    return map;
  }
}

class Prices {
  Prices({
    this.id,
    this.astrologerUniId,
    this.type,
    this.price,
    this.actualPrice,
    this.timeInMinutes,
    this.currency,
    this.trash,
    this.createdAt,
    this.updatedAt,
    this.firstCallFreeMinutes,
    this.nextOnlineTime,
  });

  Prices.fromJson(dynamic json) {
    id = json['id'];
    astrologerUniId = json['astrologer_uni_id'];
    type = json['type'];
    price = json['price'];
    actualPrice = json['actual_price'];
    timeInMinutes = json['time_in_minutes'];
    currency = json['currency'];
    trash = json['trash'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstCallFreeMinutes = json['first_call_free_minutes'];
    nextOnlineTime = json['next_online_time'];
  }

  num? id;
  String? astrologerUniId;
  String? type;
  num? price;
  num? actualPrice;
  num? timeInMinutes;
  String? currency;
  num? trash;
  String? createdAt;
  String? updatedAt;
  String? firstCallFreeMinutes;
  String? nextOnlineTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['astrologer_uni_id'] = astrologerUniId;
    map['type'] = type;
    map['price'] = price;
    map['actual_price'] = actualPrice;
    map['time_in_minutes'] = timeInMinutes;
    map['currency'] = currency;
    map['trash'] = trash;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['first_call_free_minutes'] = firstCallFreeMinutes;
    map['next_online_time'] = nextOnlineTime;
    return map;
  }
}

class User {
  User({
    this.id,
    this.userUniId,
    this.name,
    this.avgRating,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    userUniId = json['user_uni_id'];
    name = json['name'];
    avgRating = json['avg_rating'];
  }

  num? id;
  String? userUniId;
  String? name;
  String? avgRating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_uni_id'] = userUniId;
    map['name'] = name;
    map['avg_rating'] = avgRating;
    return map;
  }
}
