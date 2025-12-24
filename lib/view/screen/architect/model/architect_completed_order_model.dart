class ArchitectCompletedOrderModel {
  ArchitectCompletedOrderModel({
      this.status, 
      this.offset, 
      this.data, 
      this.msg,});

  ArchitectCompletedOrderModel.fromJson(dynamic json) {
    status = json['status'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ArchitectCompletedOrderData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  num? offset;
  List<ArchitectCompletedOrderData>? data;
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

class ArchitectCompletedOrderData {
  ArchitectCompletedOrderData({
      this.id, 
      this.customerUniId, 
      this.architectUniId, 
      this.orderType, 
      this.uniqeid, 
      this.orderDate, 
      this.orderStart, 
      this.charge, 
      this.isReview, 
      this.status, 
      this.refundValidDate, 
      this.createdAt, 
      this.updatedAt, 
      this.displayName, 
      this.astrologerName, 
      this.astrologerUniId, 
      this.astroImg, 
      this.chatUniqeid,});

  ArchitectCompletedOrderData.fromJson(dynamic json) {
    id = json['id'];
    customerUniId = json['customer_uni_id'];
    architectUniId = json['architect_uni_id'];
    orderType = json['order_type'];
    uniqeid = json['uniqeid'];
    orderDate = json['order_date'];
    orderStart = json['order_start'];
    charge = json['charge'];
    isReview = json['is_review'];
    status = json['status'];
    refundValidDate = json['refund_valid_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    displayName = json['display_name'];
    astrologerName = json['astrologer_name'];
    astrologerUniId = json['astrologer_uni_id'];
    astroImg = json['astro_img'];
    chatUniqeid = json['chat_uniqeid'];
  }
  num? id;
  String? customerUniId;
  String? architectUniId;
  String? orderType;
  String? uniqeid;
  String? orderDate;
  String? orderStart;
  num? charge;
  num? isReview;
  String? status;
  String? refundValidDate;
  String? createdAt;
  String? updatedAt;
  String? displayName;
  String? astrologerName;
  String? astrologerUniId;
  String? astroImg;
  String? chatUniqeid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['customer_uni_id'] = customerUniId;
    map['architect_uni_id'] = architectUniId;
    map['order_type'] = orderType;
    map['uniqeid'] = uniqeid;
    map['order_date'] = orderDate;
    map['order_start'] = orderStart;
    map['charge'] = charge;
    map['is_review'] = isReview;
    map['status'] = status;
    map['refund_valid_date'] = refundValidDate;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['display_name'] = displayName;
    map['astrologer_name'] = astrologerName;
    map['astrologer_uni_id'] = astrologerUniId;
    map['astro_img'] = astroImg;
    map['chat_uniqeid'] = chatUniqeid;
    return map;
  }

}