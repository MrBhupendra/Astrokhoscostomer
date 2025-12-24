class SanjeeviniModel {
  SanjeeviniModel({this.status, this.data, this.msg, this.offset});

  SanjeeviniModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SanjeeviniData.fromJson(v));
      });
    }
    msg = json['msg'];
    offset = json['offset'];
  }

  num? status;
  List<SanjeeviniData>? data;
  String? msg;
  num? offset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    map['offset'] = offset;
    return map;
  }
}

class SanjeeviniData {
  SanjeeviniData({
    this.id,
    this.title,
    this.description,
    this.sanjeeviniImage,
    this.slug,
    this.price,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.paymentStatus,
  });

  SanjeeviniData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    sanjeeviniImage = json['sanjeevini_image'];
    slug = json['slug'];
    price = json['price'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    paymentStatus = json['payment_status'];
  }

  num? id;
  String? title;
  String? description;
  String? sanjeeviniImage;
  String? slug;
  num? price;
  num? status;
  String? createdAt;
  String? updatedAt;
  num? paymentStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['sanjeevini_image'] = sanjeeviniImage;
    map['slug'] = slug;
    map['price'] = price;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['payment_status'] = paymentStatus;
    return map;
  }
}
