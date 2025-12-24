class BannerModel{
}

class BannersData {
  BannersData({
    this.id,
    this.bannerCategoryId,
    this.title,
    this.subject,
    this.bannerImage,
    this.url,
    this.status,
    this.createdAt,
    this.updatedAt,});

  BannersData.fromJson(dynamic json) {
    id = json['id'];
    bannerCategoryId = json['banner_category_id'];
    title = json['title'];
    subject = json['subject'];
    bannerImage = json['banner_image'];
    url = json['url'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  num? bannerCategoryId;
  String? title;
  String? subject;
  String? bannerImage;
  String? url;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['banner_category_id'] = bannerCategoryId;
    map['title'] = title;
    map['subject'] = subject;
    map['banner_image'] = bannerImage;
    map['url'] = url;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}