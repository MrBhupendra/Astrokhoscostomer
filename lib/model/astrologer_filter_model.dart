class AstrologerFilterModel {
  AstrologerFilterModel({
      this.status, 
      this.languageList, 
      this.skillList, 
      this.categoryList, 
      this.msg,});

  AstrologerFilterModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['languageList'] != null) {
      languageList = [];
      json['languageList'].forEach((v) {
        languageList?.add(LanguageList.fromJson(v));
      });
    }
    if (json['skillList'] != null) {
      skillList = [];
      json['skillList'].forEach((v) {
        skillList?.add(SkillList.fromJson(v));
      });
    }
    if (json['categoryList'] != null) {
      categoryList = [];
      json['categoryList'].forEach((v) {
        categoryList?.add(CategoryList.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  List<LanguageList>? languageList;
  List<SkillList>? skillList;
  List<CategoryList>? categoryList;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (languageList != null) {
      map['languageList'] = languageList?.map((v) => v.toJson()).toList();
    }
    if (skillList != null) {
      map['skillList'] = skillList?.map((v) => v.toJson()).toList();
    }
    if (categoryList != null) {
      map['categoryList'] = categoryList?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class CategoryList {
  CategoryList({
      this.id, 
      this.categoryTitle, 
      this.categorySlug, 
      this.categoryImages, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  CategoryList.fromJson(dynamic json) {
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

class SkillList {
  SkillList({
      this.id, 
      this.skillName, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  SkillList.fromJson(dynamic json) {
    id = json['id'];
    skillName = json['skill_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? skillName;
  num? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['skill_name'] = skillName;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class LanguageList {
  LanguageList({
      this.id, 
      this.languageName, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  LanguageList.fromJson(dynamic json) {
    id = json['id'];
    languageName = json['language_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? languageName;
  num? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['language_name'] = languageName;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}