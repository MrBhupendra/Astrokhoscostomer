class AstroQuestionCustomerListModel {
  AstroQuestionCustomerListModel({
      this.status, 
      this.offset, 
      this.data, 
      this.msg,});

  AstroQuestionCustomerListModel.fromJson(dynamic json) {
    status = json['status'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AstroQuestionCustomerListData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  num? offset;
  List<AstroQuestionCustomerListData>? data;
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

class AstroQuestionCustomerListData {
  AstroQuestionCustomerListData({
      this.id, 
      this.customerUniId, 
      this.astrologerUniId, 
      this.orderId, 
      this.question, 
      this.answer, 
      this.totalAmount, 
      this.answerStatus, 
      this.status, 
      this.paymentStatus, 
      this.createdAt, 
      this.updatedAt, 
      this.customerName, 
      this.customerImg, 
      this.astrologerName, 
      this.astroImg,});

  AstroQuestionCustomerListData.fromJson(dynamic json) {
    id = json['id'];
    customerUniId = json['customer_uni_id'];
    astrologerUniId = json['astrologer_uni_id'];
    orderId = json['order_id'];
    question = json['question'];
    answer = json['answer'];
    totalAmount = json['total_amount'];
    answerStatus = json['answer_status'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerName = json['customer_name'];
    customerImg = json['customer_img'];
    astrologerName = json['astrologer_name'];
    astroImg = json['astro_img'];
  }
  num? id;
  String? customerUniId;
  String? astrologerUniId;
  String? orderId;
  String? question;
  String? answer;
  String? totalAmount;
  num? answerStatus;
  num? status;
  num? paymentStatus;
  String? createdAt;
  String? updatedAt;
  String? customerName;
  String? customerImg;
  String? astrologerName;
  String? astroImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['customer_uni_id'] = customerUniId;
    map['astrologer_uni_id'] = astrologerUniId;
    map['order_id'] = orderId;
    map['question'] = question;
    map['answer'] = answer;
    map['total_amount'] = totalAmount;
    map['answer_status'] = answerStatus;
    map['status'] = status;
    map['payment_status'] = paymentStatus;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['customer_name'] = customerName;
    map['customer_img'] = customerImg;
    map['astrologer_name'] = astrologerName;
    map['astro_img'] = astroImg;
    return map;
  }

}