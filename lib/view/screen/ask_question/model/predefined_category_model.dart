class PredefinedCategoryModel {
  PredefinedCategoryModel({
      this.status, 
      this.msg, 
      this.offset, 
      this.predefinedMessageCategory,});

  PredefinedCategoryModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    offset = json['offset'];
    if (json['predefined_message_category'] != null) {
      predefinedMessageCategory = [];
      json['predefined_message_category'].forEach((v) {
        predefinedMessageCategory?.add(PredefinedMessageCategory.fromJson(v));
      });
    }
  }
  num? status;
  String? msg;
  num? offset;
  List<PredefinedMessageCategory>? predefinedMessageCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    map['offset'] = offset;
    if (predefinedMessageCategory != null) {
      map['predefined_message_category'] = predefinedMessageCategory?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class PredefinedMessageCategory {
  PredefinedMessageCategory({
      this.id, 
      this.title, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  PredefinedMessageCategory.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? title;
  num? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}