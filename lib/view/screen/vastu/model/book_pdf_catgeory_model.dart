class BookPdfCategoryModel {
  BookPdfCategoryModel({
      this.status, 
      this.data, 
      this.msg,});

  BookPdfCategoryModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BookPdfCategoryData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  List<BookPdfCategoryData>? data;
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

class BookPdfCategoryData {
  BookPdfCategoryData({
      this.id, 
      this.title, 
      this.slug, 
      this.image, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  BookPdfCategoryData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? title;
  String? slug;
  String? image;
  num? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    map['image'] = image;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}