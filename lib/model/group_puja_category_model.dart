class GroupPujaCategoryModel {
  GroupPujaCategoryModel({
      this.status, 
      this.data, 
      this.offset, 
      this.msg,});

  GroupPujaCategoryModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(GroupPoojaCategoryData.fromJson(v));
      });
    }
    offset = json['offset'];
    msg = json['msg'];
  }
  num? status;
  List<GroupPoojaCategoryData>? data;
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

class GroupPoojaCategoryData {
  GroupPoojaCategoryData({
      this.id, 
      this.parentId, 
      this.title, 
      this.metaKey, 
      this.metaTitle, 
      this.metaDescription, 
      this.slug, 
      this.description, 
      this.image, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  GroupPoojaCategoryData.fromJson(dynamic json) {
    id = json['id'];
    parentId = json['parent_id'];
    title = json['title'];
    metaKey = json['meta_key'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
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
  String? metaKey;
  String? metaTitle;
  String? metaDescription;
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
    map['meta_key'] = metaKey;
    map['meta_title'] = metaTitle;
    map['meta_description'] = metaDescription;
    map['slug'] = slug;
    map['description'] = description;
    map['image'] = image;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}