class ReportOrderListModel {
  ReportOrderListModel({
      this.status, 
      this.offset, 
      this.data, 
      this.msg,});

  ReportOrderListModel.fromJson(dynamic json) {
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
      this.paidKundliManualId, 
      this.userUniId, 
      this.orderId, 
      this.requestBody, 
      this.pdfFile, 
      this.totalAmount, 
      this.orderFor, 
      this.status, 
      this.paymentStatus, 
      this.createdAt, 
      this.updatedAt, 
      this.title, 
      this.description, 
      this.paidKundliManualImage,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    paidKundliManualId = json['paid_kundli_manual_id'];
    userUniId = json['user_uni_id'];
    orderId = json['order_id'];
    requestBody = json['request_body'];
    pdfFile = json['pdf_file'];
    totalAmount = json['total_amount'];
    orderFor = json['order_for'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    description = json['description'];
    paidKundliManualImage = json['paid_kundli_manual_image'];
  }
  num? id;
  num? paidKundliManualId;
  String? userUniId;
  String? orderId;
  String? requestBody;
  String? pdfFile;
  num? totalAmount;
  String? orderFor;
  num? status;
  num? paymentStatus;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? description;
  String? paidKundliManualImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['paid_kundli_manual_id'] = paidKundliManualId;
    map['user_uni_id'] = userUniId;
    map['order_id'] = orderId;
    map['request_body'] = requestBody;
    map['pdf_file'] = pdfFile;
    map['total_amount'] = totalAmount;
    map['order_for'] = orderFor;
    map['status'] = status;
    map['payment_status'] = paymentStatus;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['title'] = title;
    map['description'] = description;
    map['paid_kundli_manual_image'] = paidKundliManualImage;
    return map;
  }

}