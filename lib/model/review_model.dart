class ReviewModel {
  ReviewModel({
    this.status,
    this.msg,
    this.offset,
    this.reviews,});

  ReviewModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    offset = json['offset'];
    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews?.add(ReviewsData.fromJson(v));
      });
    }
  }
  num? status;
  String? msg;
  num? offset;
  List<ReviewsData>? reviews;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    map['offset'] = offset;
    if (reviews != null) {
      map['reviews'] = reviews?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ReviewsData {
  ReviewsData({
    this.id,
    this.reviewById,
    this.reviewForId,
    this.reviewRating,
    this.reviewComment,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.customer,
    this.reviewByUser,});

  ReviewsData.fromJson(dynamic json) {
    id = json['id'];
    reviewById = json['review_by_id'];
    reviewForId = json['review_for_id'];
    reviewRating = json['review_rating'];
    reviewComment = json['review_comment'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    reviewByUser = json['review_by_user'] != null ? ReviewByUser.fromJson(json['review_by_user']) : null;
  }
  num? id;
  String? reviewById;
  String? reviewForId;
  num? reviewRating;
  String? reviewComment;
  num? status;
  String? createdAt;
  String? updatedAt;
  Customer? customer;
  ReviewByUser? reviewByUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['review_by_id'] = reviewById;
    map['review_for_id'] = reviewForId;
    map['review_rating'] = reviewRating;
    map['review_comment'] = reviewComment;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    if (reviewByUser != null) {
      map['review_by_user'] = reviewByUser?.toJson();
    }
    return map;
  }

}

class ReviewByUser {
  ReviewByUser({
    this.id,
    this.userUniId,
    this.name,});

  ReviewByUser.fromJson(dynamic json) {
    id = json['id'];
    userUniId = json['user_uni_id'];
    name = json['name'];
  }
  num? id;
  String? userUniId;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_uni_id'] = userUniId;
    map['name'] = name;
    return map;
  }

}

class Customer {
  Customer({
    this.id,
    this.customerUniId,
    this.customerImg,});

  Customer.fromJson(dynamic json) {
    id = json['id'];
    customerUniId = json['customer_uni_id'];
    customerImg = json['customer_img'];
  }
  num? id;
  String? customerUniId;
  String? customerImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['customer_uni_id'] = customerUniId;
    map['customer_img'] = customerImg;
    return map;
  }

}