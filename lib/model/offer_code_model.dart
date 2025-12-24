class OfferCodeModel {
  OfferCodeModel({
      this.status, 
      this.offset, 
      this.data, 
      this.msg,});

  OfferCodeModel.fromJson(dynamic json) {
    status = json['status'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  num? offset;
  List<Data>? data;
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

class Data {
  Data({
      this.id, 
      this.offerCategory, 
      this.offerName, 
      this.offerCode, 
      this.offerValidityFrom, 
      this.offerValidityTo, 
      this.discount, 
      this.discountAmount, 
      this.minimumOrderAmount, 
      this.userRestriction, 
      this.maxOrderAmount, 
      this.couponDescription, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    offerCategory = json['offer_category'];
    offerName = json['offer_name'];
    offerCode = json['offer_code'];
    offerValidityFrom = json['offer_validity_from'];
    offerValidityTo = json['offer_validity_to'];
    discount = json['discount'];
    discountAmount = json['discount_amount'];
    minimumOrderAmount = json['minimum_order_amount'];
    userRestriction = json['user_restriction'];
    maxOrderAmount = json['max_order_amount'];
    couponDescription = json['coupon_description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? offerCategory;
  String? offerName;
  String? offerCode;
  String? offerValidityFrom;
  String? offerValidityTo;
  String? discount;
  String? discountAmount;
  String? minimumOrderAmount;
  num? userRestriction;
  String? maxOrderAmount;
  String? couponDescription;
  num? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['offer_category'] = offerCategory;
    map['offer_name'] = offerName;
    map['offer_code'] = offerCode;
    map['offer_validity_from'] = offerValidityFrom;
    map['offer_validity_to'] = offerValidityTo;
    map['discount'] = discount;
    map['discount_amount'] = discountAmount;
    map['minimum_order_amount'] = minimumOrderAmount;
    map['user_restriction'] = userRestriction;
    map['max_order_amount'] = maxOrderAmount;
    map['coupon_description'] = couponDescription;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}