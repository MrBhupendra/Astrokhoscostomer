import 'package:astro_brahmand/model/product_category_model.dart';
import 'package:astro_brahmand/model/service_category_model.dart';

import 'astrologer_model.dart';
import 'banner_model.dart';
import 'blog_model.dart';
import 'group_puja_category_model.dart';

class DashboardModel {
  DashboardModel({
    this.status,
    this.data,
    this.msg,
  });

  DashboardModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? DashboardData.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  num? status;
  DashboardData? data;
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

class DashboardData {
  DashboardData({
    this.banners,
    this.liveAstrologers,
    this.services,
    this.groupPoojaCategories,
    this.blogs,
    this.productCategories,
    this.videosection,
    this.inProgressOrder,
    this.inReview,
    this.architectServiceStatus,
    this.chatChannels
  });

  DashboardData.fromJson(dynamic json) {
    if (json['banners'] != null) {
      banners = [];
      json['banners'].forEach((v) {
        banners?.add(BannersData.fromJson(v));
      });
    }
    if (json['live_astrologers'] != null) {
      liveAstrologers = [];
      json['live_astrologers'].forEach((v) {
        liveAstrologers?.add(AstrologerData.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = [];
      json['services'].forEach((v) {
        services?.add(ServiceCategoryData.fromJson(v));
      });
    }
    if (json['groupPujaCategory'] != null) {
      groupPoojaCategories = [];
      json['groupPujaCategory'].forEach((v) {
        groupPoojaCategories?.add(GroupPoojaCategoryData.fromJson(v));
      });
    }
    if (json['blogs'] != null) {
      blogs = [];
      json['blogs'].forEach((v) {
        blogs?.add(BlogsData.fromJson(v));
      });
    }
    if (json['product_categories'] != null) {
      productCategories = [];
      json['product_categories'].forEach((v) {
        productCategories?.add(ProductCategoriesData.fromJson(v));
      });
    }
    if (json['videosection'] != null) {
      videosection = [];
      json['videosection'].forEach((v) {
        videosection?.add(Videosection.fromJson(v));
      });
    }
    inProgressOrder = json['in_progress_order'] != null
        ? InProgressOrder.fromJson(json['in_progress_order'])
        : null;
    inReview = json['in_review'] != null ? InReview.fromJson(json['in_review']) : null;
    architectServiceStatus = json['architect_service_status'];
    if (json['chat_channels'] != null) {
      chatChannels = [];
      json['chat_channels'].forEach((v) {
        chatChannels?.add(ChatChannels.fromJson(v));
      });
    }
  }

  List<BannersData>? banners;
  List<AstrologerData>? liveAstrologers;
  List<ServiceCategoryData>? services;
  List<GroupPoojaCategoryData>? groupPoojaCategories;
  List<BlogsData>? blogs;
  List<ProductCategoriesData>? productCategories;
  List<Videosection>? videosection;
  InProgressOrder? inProgressOrder;
  InReview? inReview;
  num? architectServiceStatus;
  List<ChatChannels>? chatChannels;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (banners != null) {
      map['banners'] = banners?.map((v) => v.toJson()).toList();
    }
    if (liveAstrologers != null) {
      map['live_astrologers'] =
          liveAstrologers?.map((v) => v.toJson()).toList();
    }
    if (services != null) {
      map['services'] = services?.map((v) => v.toJson()).toList();
    }
    if (groupPoojaCategories != null) {
      map['groupPujaCategory'] = groupPoojaCategories?.map((v) => v.toJson()).toList();
    }
    if (blogs != null) {
      map['blogs'] = blogs?.map((v) => v.toJson()).toList();
    }
    if (productCategories != null) {
      map['product_categories'] =
          productCategories?.map((v) => v.toJson()).toList();
    }
    if (videosection != null) {
      map['videosection'] = videosection?.map((v) => v.toJson()).toList();
    }
    if (inReview != null) {
      map['in_review'] = inReview?.toJson();
    }
    if (inProgressOrder != null) {
      map['in_progress_order'] = inProgressOrder?.toJson();
    }
    map['architect_service_status'] = architectServiceStatus;
    if (chatChannels != null) {
      map['chat_channels'] = chatChannels?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ChatChannels {
  ChatChannels({
    this.id,
    this.userUniId,
    this.channelName,
    this.status,
    this.trash,
    this.createdAt,
    this.updatedAt,
    this.customerImg,
    this.astroImg,
    this.displayName,
    this.userName,});

  ChatChannels.fromJson(dynamic json) {
    id = json['id'];
    userUniId = json['user_uni_id'];
    channelName = json['channel_name'];
    status = json['status'];
    trash = json['trash'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerImg = json['customer_img'];
    astroImg = json['astro_img'];
    displayName = json['display_name'];
    userName = json['user_name'];
  }
  num? id;
  String? userUniId;
  String? channelName;
  num? status;
  num? trash;
  String? createdAt;
  String? updatedAt;
  String? customerImg;
  String? astroImg;
  String? displayName;
  String? userName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_uni_id'] = userUniId;
    map['channel_name'] = channelName;
    map['status'] = status;
    map['trash'] = trash;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['customer_img'] = customerImg;
    map['astro_img'] = astroImg;
    map['display_name'] = displayName;
    map['user_name'] = userName;
    return map;
  }

}

class InReview {
  InReview({
    this.isReview,
    this.idForReview,
    this.displayNameForReview,
    this.uniqeid,
    this.astroImg,});

  InReview.fromJson(dynamic json) {
    isReview = json['is_review'];
    idForReview = json['id_for_review'];
    displayNameForReview = json['display_name_for_review'];
    uniqeid = json['uniqeid'];
    astroImg = json['astro_img'];
  }
  num? isReview;
  String? idForReview;
  String? displayNameForReview;
  String? uniqeid;
  String? astroImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_review'] = isReview;
    map['id_for_review'] = idForReview;
    map['display_name_for_review'] = displayNameForReview;
    map['uniqeid'] = uniqeid;
    map['astro_img'] = astroImg;
    return map;
  }

}

class InProgressOrder {
  InProgressOrder({
    this.status,
    this.astroName,
    this.astroImage,
    this.astroUniId,
    this.uniqeid,
    this.channelName,
    this.callType,
    this.token,
    this.isVirtualAstrologer,
  });

  InProgressOrder.fromJson(dynamic json) {
    status = json['status'];
    astroName = json['astro_name'];
    astroImage = json['astro_image'];
    astroUniId = json['astro_uni_id'];
    uniqeid = json['uniqeid'];
    channelName = json['channel_name'];
    callType = json['call_type'];
    token = json['token'];
    isVirtualAstrologer = json['is_virtual'];
  }

  num? status;
  String? astroName;
  String? astroImage;
  String? astroUniId;
  String? uniqeid;
  String? channelName;
  String? callType;
  String? token;
  int? isVirtualAstrologer;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['astro_name'] = astroName;
    map['astro_image'] = astroImage;
    map['astro_uni_id'] = astroUniId;
    map['uniqeid'] = uniqeid;
    map['channel_name'] = channelName;
    map['call_type'] = callType;
    map['token'] = token;
    map['is_virtual'] = isVirtualAstrologer;
    return map;
  }
}

class Videosection {
  Videosection({
    this.id,
    this.title,
    this.videoType,
    this.url,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.embedd,
  });

  Videosection.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    videoType = json['video_type'];
    url = json['url'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    embedd = json['embedd'];
  }

  num? id;
  String? title;
  String? videoType;
  String? url;
  num? status;
  String? createdAt;
  String? updatedAt;
  String? embedd;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['video_type'] = videoType;
    map['url'] = url;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['embedd'] = embedd;
    return map;
  }
}
