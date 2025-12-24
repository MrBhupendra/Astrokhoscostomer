class DailyQuoteModel {
  DailyQuoteModel({
      this.status, 
      this.msg, 
      this.offset, 
      this.data,});

  DailyQuoteModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DailyQuoteData.fromJson(v));
      });
    }
  }
  num? status;
  String? msg;
  num? offset;
  List<DailyQuoteData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    map['offset'] = offset;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class DailyQuoteData {
  DailyQuoteData({
      this.id, 
      this.title, 
      this.slug, 
      this.content, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  DailyQuoteData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    content = json['content'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? title;
  String? slug;
  String? content;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    map['content'] = content;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}