class GroupPujasListModel {
  GroupPujasListModel({
      this.status, 
      this.data, 
      this.offset, 
      this.msg,});

  GroupPujasListModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(GroupPoojaListData.fromJson(v));
      });
    }
    offset = json['offset'];
    msg = json['msg'];
  }
  num? status;
  List<GroupPoojaListData>? data;
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

class GroupPoojaListData {
  GroupPoojaListData({
      this.id, 
      this.groupPujaCategoryId, 
      this.groupPujaName, 
      this.metaKey, 
      this.metaTitle, 
      this.metaDescription, 
      this.slug, 
      this.groupPujaImage, 
      this.groupPujaDescription, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.title,});

  GroupPoojaListData.fromJson(dynamic json) {
    id = json['id'];
    groupPujaCategoryId = json['group_puja_category_id'];
    groupPujaName = json['group_puja_name'];
    metaKey = json['meta_key'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    slug = json['slug'];
    groupPujaImage = json['group_puja_image'];
    groupPujaDescription = json['group_puja_description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
  }
  num? id;
  num? groupPujaCategoryId;
  String? groupPujaName;
  String? metaKey;
  String? metaTitle;
  String? metaDescription;
  String? slug;
  String? groupPujaImage;
  String? groupPujaDescription;
  num? status;
  String? createdAt;
  String? updatedAt;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['group_puja_category_id'] = groupPujaCategoryId;
    map['group_puja_name'] = groupPujaName;
    map['meta_key'] = metaKey;
    map['meta_title'] = metaTitle;
    map['meta_description'] = metaDescription;
    map['slug'] = slug;
    map['group_puja_image'] = groupPujaImage;
    map['group_puja_description'] = groupPujaDescription;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['title'] = title;
    return map;
  }

}