class ArchitectInProgressOrderModel {
  ArchitectInProgressOrderModel({
      this.status, 
      this.data, 
      this.msg,});

  ArchitectInProgressOrderModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ArchitectInProgressData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  List<ArchitectInProgressData>? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class ArchitectInProgressData {
  ArchitectInProgressData({
    this.id,
    this.customerUniId,
    this.architectUniId,
    this.orderType,
    this.uniqeid,
    this.orderDate,
    this.orderStart,
    this.orderEnd,
    this.charge,
    this.isReview,
    this.status,
    this.refundValidDate,
    this.createdAt,
    this.updatedAt,
    this.displayName,
    this.astrologerUniId,
    this.astroImg,});

  ArchitectInProgressData.fromJson(dynamic json) {
    id = json['id'];
    customerUniId = json['customer_uni_id'];
    architectUniId = json['architect_uni_id'];
    orderType = json['order_type'];
    uniqeid = json['uniqeid'];
    orderDate = json['order_date'];
    orderStart = json['order_start'];
    orderEnd = json['order_end'];
    charge = json['charge'];
    isReview = json['is_review'];
    status = json['status'];
    refundValidDate = json['refund_valid_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    displayName = json['display_name'];
    astrologerUniId = json['astrologer_uni_id'];
    astroImg = json['astro_img'];
  }
  num? id;
  String? customerUniId;
  String? architectUniId;
  String? orderType;
  String? uniqeid;
  String? orderDate;
  String? orderStart;
  String? orderEnd;
  num? charge;
  num? isReview;
  String? status;
  String? refundValidDate;
  String? createdAt;
  String? updatedAt;
  String? displayName;
  String? astrologerUniId;
  String? astroImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['customer_uni_id'] = customerUniId;
    map['architect_uni_id'] = architectUniId;
    map['order_type'] = orderType;
    map['uniqeid'] = uniqeid;
    map['order_date'] = orderDate;
    map['order_start'] = orderStart;
    map['order_end'] = orderEnd;
    map['charge'] = charge;
    map['is_review'] = isReview;
    map['status'] = status;
    map['refund_valid_date'] = refundValidDate;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['display_name'] = displayName;
    map['astrologer_uni_id'] = astrologerUniId;
    map['astro_img'] = astroImg;
    return map;
  }

}