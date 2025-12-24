class SwitchWordModel {
  SwitchWordModel({this.status, this.data, this.msg, this.offset});

  SwitchWordModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SwitchWordData.fromJson(v));
      });
    }
    msg = json['msg'];
    offset = json['offset'];
  }

  num? status;
  List<SwitchWordData>? data;
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

class SwitchWordData {
  SwitchWordData({
    this.id,
    this.title,
    this.description,
    this.switchwordImage,
    this.slug,
    this.price,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.paymentStatus,
  });

  SwitchWordData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    switchwordImage = json['switchword_image'];
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
  String? switchwordImage;
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
    map['switchword_image'] = switchwordImage;
    map['slug'] = slug;
    map['price'] = price;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['payment_status'] = paymentStatus;
    return map;
  }
}
