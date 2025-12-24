class CategoryModel {
  CategoryModel({
      this.status, 
      this.data, 
      this.msg,});

  CategoryModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CategoriesData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  List<CategoriesData>? data;
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

class CategoriesData {
  CategoriesData({
      this.id, 
      this.categoryTitle, 
      this.categorySlug, 
      this.categoryImages, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  CategoriesData.fromJson(dynamic json) {
    id = json['id'];
    categoryTitle = json['category_title'];
    categorySlug = json['category_slug'];
    categoryImages = json['category_images'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? categoryTitle;
  String? categorySlug;
  String? categoryImages;
  num? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_title'] = categoryTitle;
    map['category_slug'] = categorySlug;
    map['category_images'] = categoryImages;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}