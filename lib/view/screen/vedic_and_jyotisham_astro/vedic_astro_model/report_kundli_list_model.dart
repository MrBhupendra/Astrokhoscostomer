class ReportKundliListModel {
  ReportKundliListModel({
      this.status, 
      this.offset, 
      this.data, 
      this.msg,});

  ReportKundliListModel.fromJson(dynamic json) {
    status = json['status'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ReportData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  num? offset;
  List<ReportData>? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['offset'] = offset;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class ReportData {
  ReportData({
      this.id, 
      this.title, 
      this.description, 
      this.paidKundliManualImage, 
      this.maritalStatus, 
      this.slug, 
      this.price, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  ReportData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    paidKundliManualImage = json['paid_kundli_manual_image'];
    maritalStatus = json['marital_status'];
    slug = json['slug'];
    price = json['price'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? title;
  String? description;
  String? paidKundliManualImage;
  String? maritalStatus;
  String? slug;
  num? price;
  num? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['paid_kundli_manual_image'] = paidKundliManualImage;
    map['marital_status'] = maritalStatus;
    map['slug'] = slug;
    map['price'] = price;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}