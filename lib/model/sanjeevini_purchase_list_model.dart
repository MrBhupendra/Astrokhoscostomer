class SanjeeviniPurchaseListModel {
  SanjeeviniPurchaseListModel({
      this.status, 
      this.offset, 
      this.data, 
      this.msg,});

  SanjeeviniPurchaseListModel.fromJson(dynamic json) {
    status = json['status'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SanjeeviniPurchaseData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  num? offset;
  List<SanjeeviniPurchaseData>? data;
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

class SanjeeviniPurchaseData {
  SanjeeviniPurchaseData({
      this.id, 
      this.sanjeeviniId, 
      this.userUniId, 
      this.orderId, 
      this.totalAmount, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.title, 
      this.description, 
      this.sanjeeviniImage,});

  SanjeeviniPurchaseData.fromJson(dynamic json) {
    id = json['id'];
    sanjeeviniId = json['sanjeevini_id'];
    userUniId = json['user_uni_id'];
    orderId = json['order_id'];
    totalAmount = json['total_amount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    description = json['description'];
    sanjeeviniImage = json['sanjeevini_image'];
  }
  num? id;
  num? sanjeeviniId;
  String? userUniId;
  String? orderId;
  num? totalAmount;
  num? status;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? description;
  String? sanjeeviniImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['sanjeevini_id'] = sanjeeviniId;
    map['user_uni_id'] = userUniId;
    map['order_id'] = orderId;
    map['total_amount'] = totalAmount;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['title'] = title;
    map['description'] = description;
    map['sanjeevini_image'] = sanjeeviniImage;
    return map;
  }

}