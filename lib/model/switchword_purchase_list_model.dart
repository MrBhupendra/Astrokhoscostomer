class SwitchwordPurchaseListModel {
  SwitchwordPurchaseListModel({
      this.status, 
      this.offset, 
      this.data, 
      this.msg,});

  SwitchwordPurchaseListModel.fromJson(dynamic json) {
    status = json['status'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SwitchwordPurchaseData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  num? offset;
  List<SwitchwordPurchaseData>? data;
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

class SwitchwordPurchaseData {
  SwitchwordPurchaseData({
      this.id, 
      this.switchwordId, 
      this.userUniId, 
      this.orderId, 
      this.totalAmount, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.title, 
      this.description, 
      this.switchwordImage,});

  SwitchwordPurchaseData.fromJson(dynamic json) {
    id = json['id'];
    switchwordId = json['switchword_id'];
    userUniId = json['user_uni_id'];
    orderId = json['order_id'];
    totalAmount = json['total_amount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    description = json['description'];
    switchwordImage = json['switchword_image'];
  }
  num? id;
  num? switchwordId;
  String? userUniId;
  String? orderId;
  num? totalAmount;
  num? status;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? description;
  String? switchwordImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['switchword_id'] = switchwordId;
    map['user_uni_id'] = userUniId;
    map['order_id'] = orderId;
    map['total_amount'] = totalAmount;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['title'] = title;
    map['description'] = description;
    map['switchword_image'] = switchwordImage;
    return map;
  }

}