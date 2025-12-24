class ServiceAstrologerListModel {
  ServiceAstrologerListModel({
    this.status,
    this.data,
    this.offset,
    this.msg,
  });

  ServiceAstrologerListModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ServiceAstrologerData.fromJson(v));
      });
    }
    offset = json['offset'];
    msg = json['msg'];
  }

  num? status;
  List<ServiceAstrologerData>? data;
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

class ServiceAstrologerData {
  ServiceAstrologerData({
    this.id,
    this.serviceId,
    this.astrologerUniId,
    this.price,
    this.description,
    this.duration,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.astrologer,
    this.user,
    this.service,
  });

  ServiceAstrologerData.fromJson(dynamic json) {
    id = json['id'];
    serviceId = json['service_id'];
    astrologerUniId = json['astrologer_uni_id'];
    price = json['price'];
    description = json['description'];
    duration = json['duration'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    astrologer = json['astrologer'] != null
        ? Astrologer.fromJson(json['astrologer'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  num? id;
  num? serviceId;
  String? astrologerUniId;
  num? price;
  String? description;
  num? duration;
  num? status;
  String? createdAt;
  String? updatedAt;
  Astrologer? astrologer;
  User? user;
  Service? service;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['service_id'] = serviceId;
    map['astrologer_uni_id'] = astrologerUniId;
    map['price'] = price;
    map['description'] = description;
    map['duration'] = duration;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (astrologer != null) {
      map['astrologer'] = astrologer?.toJson();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (service != null) {
      map['service'] = service?.toJson();
    }
    return map;
  }
}

class Service {
  Service({
    this.id,
    this.serviceCategoryId,
    this.serviceName,
    this.slug,
    this.serviceImage,
    this.serviceDescription,
  });

  Service.fromJson(dynamic json) {
    id = json['id'];
    serviceCategoryId = json['service_category_id'];
    serviceName = json['service_name'];
    slug = json['slug'];
    serviceImage = json['service_image'];
    serviceDescription = json['service_description'];
  }

  num? id;
  String? serviceCategoryId;
  String? serviceName;
  String? slug;
  String? serviceImage;
  String? serviceDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['service_category_id'] = serviceCategoryId;
    map['service_name'] = serviceName;
    map['slug'] = slug;
    map['service_image'] = serviceImage;
    map['service_description'] = serviceDescription;
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
  });

  Astrologer.fromJson(dynamic json) {
    id = json['id'];
    astrologerUniId = json['astrologer_uni_id'];
    displayName = json['display_name'];
    slug = json['slug'];
    astroImg = json['astro_img'];
    experience = json['experience'];
    languagesList = json['languages_list'];
    categoriesList = json['categories_list'];
  }

  num? id;
  String? astrologerUniId;
  String? displayName;
  String? slug;
  String? astroImg;
  num? experience;
  String? languagesList;
  String? categoriesList;

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
    return map;
  }
}
