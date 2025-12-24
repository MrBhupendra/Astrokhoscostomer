class ReportOrderListModel {
  ReportOrderListModel({
      this.status, 
      this.data, 
      this.msg,});

  ReportOrderListModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ReportOrderData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  List<ReportOrderData>? data;
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

class ReportOrderData {
  ReportOrderData({
      this.id, 
      this.userUniId, 
      this.orderId, 
      this.requestBody, 
      this.pdfFile, 
      this.totalAmount, 
      this.orderFor, 
      this.status, 
      this.paymentStatus, 
      this.createdAt, 
      this.updatedAt,});

  ReportOrderData.fromJson(dynamic json) {
    id = json['id'];
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
  }
  num? id;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
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
    return map;
  }

}