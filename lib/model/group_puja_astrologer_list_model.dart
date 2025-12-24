class GroupPujaAstrologerListModel {
  GroupPujaAstrologerListModel({
      this.status, 
      this.data, 
      this.offset, 
      this.msg,});

  GroupPujaAstrologerListModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(GroupPoojaAstrologerListData.fromJson(v));
      });
    }
    offset = json['offset'];
    msg = json['msg'];
  }
  num? status;
  List<GroupPoojaAstrologerListData>? data;
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

class GroupPoojaAstrologerListData {
  GroupPoojaAstrologerListData({
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
      this.isAvailable, 
      this.astrologer, 
      this.user, 
      this.groupPuja,});

  GroupPoojaAstrologerListData.fromJson(dynamic json) {
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
    isAvailable = json['is_available'];
    astrologer = json['astrologer'] != null ? Astrologer.fromJson(json['astrologer']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
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
  dynamic startTime;
  num? status;
  String? createdAt;
  String? updatedAt;
  num? isAvailable;
  Astrologer? astrologer;
  User? user;
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
    map['is_available'] = isAvailable;
    if (astrologer != null) {
      map['astrologer'] = astrologer?.toJson();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
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
      this.groupPujaDescription, 
      this.groupPujaDate, 
      this.groupPujaTime, 
      this.duration, 
      this.price,});

  GroupPuja.fromJson(dynamic json) {
    id = json['id'];
    groupPujaCategoryId = json['group_puja_category_id'];
    groupPujaName = json['group_puja_name'];
    slug = json['slug'];
    groupPujaImage = json['group_puja_image'];
    groupPujaDescription = json['group_puja_description'];
    groupPujaDate = json['group_puja_date'];
    groupPujaTime = json['group_puja_time'];
    duration = json['duration'];
    price = json['price'];
  }
  num? id;
  num? groupPujaCategoryId;
  String? groupPujaName;
  String? slug;
  String? groupPujaImage;
  String? groupPujaDescription;
  String? groupPujaDate;
  String? groupPujaTime;
  num? duration;
  String? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['group_puja_category_id'] = groupPujaCategoryId;
    map['group_puja_name'] = groupPujaName;
    map['slug'] = slug;
    map['group_puja_image'] = groupPujaImage;
    map['group_puja_description'] = groupPujaDescription;
    map['group_puja_date'] = groupPujaDate;
    map['group_puja_time'] = groupPujaTime;
    map['duration'] = duration;
    map['price'] = price;
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

class Astrologer {
  Astrologer({
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

  Astrologer.fromJson(dynamic json) {
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