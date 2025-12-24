class ServiceCategoryModel {
  ServiceCategoryModel({
    this.status,
    this.data,
    this.msg,});

  ServiceCategoryModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ServiceCategoryData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  List<ServiceCategoryData>? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}
class ServiceCategoryData {
  ServiceCategoryData({
    this.id,
    this.parentId,
    this.title,
    this.slug,
    this.description,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,});

  ServiceCategoryData.fromJson(dynamic json) {
    id = json['id'];
    parentId = json['parent_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  num? parentId;
  String? title;
  String? slug;
  String? description;
  String? image;
  num? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['parent_id'] = parentId;
    map['title'] = title;
    map['slug'] = slug;
    map['description'] = description;
    map['image'] = image;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}