class MandirAssignListModel {
  MandirAssignListModel({
    this.status,
    this.data,
    this.offset,
    this.msg,});

  MandirAssignListModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(MandirAssignData.fromJson(v));
      });
    }
    offset = json['offset'];
    msg = json['msg'];
  }
  num? status;
  List<MandirAssignData>? data;
  num? offset;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['offset'] = offset;
    map['msg'] = msg;
    return map;
  }

}

class MandirAssignData {
  MandirAssignData({
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
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isPurchased,
    this.mandirAstrologer,
    this.user,
    this.liveTempleDarshan,});

  MandirAssignData.fromJson(dynamic json) {
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
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isPurchased = json['is_purchased'];
    mandirAstrologer = json['astrologer'] != null ? MandirAstrologer.fromJson(json['astrologer']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
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
  num? status;
  String? createdAt;
  String? updatedAt;
  int? isPurchased;
  MandirAstrologer? mandirAstrologer;
  User? user;
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
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_purchased'] = isPurchased;
    if (mandirAstrologer != null) {
      map['astrologer'] = mandirAstrologer?.toJson();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
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

class User {
  User({
    this.id,
    this.userUniId,
    this.name,
    this.userFcmToken,
    this.userIosToken,
    this.avgRating,
    this.fullInfo,});

  User.fromJson(dynamic json) {
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

class MandirAstrologer {
  MandirAstrologer({
    this.id,
    this.astrologerUniId,
    this.displayName,
    this.slug,
    this.astroImg,
    this.experience,
    this.languagesList,
    this.categoriesList,
    this.languages,
    this.categories,});

  MandirAstrologer.fromJson(dynamic json) {
    id = json['id'];
    astrologerUniId = json['astrologer_uni_id'];
    displayName = json['display_name'];
    slug = json['slug'];
    astroImg = json['astro_img'];
    experience = json['experience'];
    languagesList = json['languages_list'];
    categoriesList = json['categories_list'];
    if (json['languages'] != null) {
      languages = [];
      json['languages'].forEach((v) {
        languages?.add(Languages.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
  }
  num? id;
  String? astrologerUniId;
  String? displayName;
  String? slug;
  String? astroImg;
  num? experience;
  String? languagesList;
  String? categoriesList;
  List<Languages>? languages;
  List<Categories>? categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['astrologer_uni_id'] = astrologerUniId;
    map['display_name'] = displayName;
    map['slug'] = slug;
    map['astro_img'] = astroImg;
    map['experience'] = experience;
    map['languages_list'] = languagesList;
    map['categories_list'] = categoriesList;
    if (languages != null) {
      map['languages'] = languages?.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Categories {
  Categories({
    this.id,
    this.categoryTitle,
    this.categorySlug,
    this.categoryImages,
    this.pivot,});

  Categories.fromJson(dynamic json) {
    id = json['id'];
    categoryTitle = json['category_title'];
    categorySlug = json['category_slug'];
    categoryImages = json['category_images'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }
  num? id;
  String? categoryTitle;
  String? categorySlug;
  String? categoryImages;
  Pivot? pivot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_title'] = categoryTitle;
    map['category_slug'] = categorySlug;
    map['category_images'] = categoryImages;
    if (pivot != null) {
      map['pivot'] = pivot?.toJson();
    }
    return map;
  }

}

class Pivot {
  Pivot({
    this.astrologerId,
    this.categoryId,});

  Pivot.fromJson(dynamic json) {
    astrologerId = json['astrologer_id'];
    categoryId = json['category_id'];
  }
  num? astrologerId;
  num? categoryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['astrologer_id'] = astrologerId;
    map['category_id'] = categoryId;
    return map;
  }

}

class Languages {
  Languages({
    this.id,
    this.languageName,
    this.pivot,});

  Languages.fromJson(dynamic json) {
    id = json['id'];
    languageName = json['language_name'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }
  num? id;
  String? languageName;
  Pivot? pivot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['language_name'] = languageName;
    if (pivot != null) {
      map['pivot'] = pivot?.toJson();
    }
    return map;
  }

}