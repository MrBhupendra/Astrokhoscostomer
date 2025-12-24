import 'package:get/get.dart';

class BlogModel {
  BlogModel({
    this.status,
    this.msg,
    this.offset,
    this.data,});

  BlogModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BlogsData.fromJson(v));
      });
    }
  }
  num? status;
  String? msg;
  num? offset;
  List<BlogsData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    map['offset'] = offset;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class BlogsData {
  BlogsData({
    this.id,
    this.blogCategoryId,
    this.authId,
    this.title,
    this.slug,
    this.blogImage,
    this.content,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.likeCount,
    this.isAstroFollow,
    this.isLikes,
    this.day,
    this.astrologer,
    this.user,});

  BlogsData.fromJson(dynamic json) {
    id = json['id'];
    blogCategoryId = json['blog_category_id'];
    authId = json['auth_id'];
    title = json['title'];
    slug = json['slug'];
    blogImage = json['blog_image'];
    content = json['content'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    likeCount = json['like_count'];
    isAstroFollow = json['is_astro_follow'];
    isLikes = json['is_likes'];
    day = json['day'];
    astrologer = json['astrologer'] != null ? Astrologer.fromJson(json['astrologer']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  num? id;
  num? blogCategoryId;
  String? authId;
  String? title;
  String? slug;
  String? blogImage;
  String? content;
  String? status;
  String? createdAt;
  String? updatedAt;
  num? likeCount;
  bool? isAstroFollow;
  bool? isLikes;
  String? day;
  Astrologer? astrologer;
  User? user;
  RxBool liked = false.obs;
  RxInt count = 0.obs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['blog_category_id'] = blogCategoryId;
    map['auth_id'] = authId;
    map['title'] = title;
    map['slug'] = slug;
    map['blog_image'] = blogImage;
    map['content'] = content;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['like_count'] = likeCount;
    map['is_astro_follow'] = isAstroFollow;
    map['is_likes'] = isLikes;
    map['day'] = day;
    if (astrologer != null) {
      map['astrologer'] = astrologer?.toJson();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

class User {
  User({
    this.id,
    this.userUniId,
    this.name,
    this.avgRating,});

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