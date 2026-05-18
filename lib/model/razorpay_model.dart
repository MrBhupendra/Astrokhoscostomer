class RazorpayModel {
  RazorpayModel({
      this.status, 
      this.orderId, 
      this.paymentGatewayStatus, 
      this.paymentGateway, 
      this.msg,});

  RazorpayModel.fromJson(dynamic json) {
    status = json['status'];
    orderId = json['order_id'];
    paymentGatewayStatus = json['payment_gateway_status'];
    paymentGateway = json['payment_gateway'] != null ? PaymentGateway.fromJson(json['payment_gateway']) : null;
    msg = json['msg'];
  }
  num? status;
  String? orderId;
  num? paymentGatewayStatus;
  PaymentGateway? paymentGateway;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['order_id'] = orderId;
    map['payment_gateway_status'] = paymentGatewayStatus;
    if (paymentGateway != null) {
      map['payment_gateway'] = paymentGateway?.toJson();
    }
    map['msg'] = msg;
    return map;
  }

}

class PaymentGateway {
  PaymentGateway({
      this.phone, 
      this.amount, 
      this.razorpayId, 
      this.email, 
      this.name, 
      this.orderId,
      this.qrId,
      this.qrImageUrl,});

  PaymentGateway.fromJson(dynamic json) {
    phone = json['phone'];
    amount = json['amount'];
    razorpayId = json['razorpay_id'];
    email = json['email'];
    name = json['name'];
    orderId = json['order_id'];
    // Returned when payment_method = razorpay_qr in proceedPaymentRequest
    qrId = json['qr_id'];
    qrImageUrl = json['image_url'] ?? json['qr_image_url'] ?? json['qr_image'];
  }
  String? phone;
  num? amount;
  String? razorpayId;
  String? email;
  String? name;
  String? orderId;
  String? qrId;
  String? qrImageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = phone;
    map['amount'] = amount;
    map['razorpay_id'] = razorpayId;
    map['email'] = email;
    map['name'] = name;
    map['order_id'] = orderId;
    map['qr_id'] = qrId;
    map['image_url'] = qrImageUrl;
    return map;
  }

}