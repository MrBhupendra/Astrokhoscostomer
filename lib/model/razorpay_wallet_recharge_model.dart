import 'package:astro_brahmand/model/razorpay_model.dart';

class RazorpayWalletRechargeModel {
  RazorpayWalletRechargeModel({
    this.status,
    this.msg,
    this.data,
    this.razorpayQrData,
    this.walletData,
  });

  RazorpayWalletRechargeModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];

    // payment_method = razorpay_qr
    if (json['razorpay_qr_data'] != null) {
      razorpayQrData = RazorpayQrProceedData.fromJson(json['razorpay_qr_data']);
      if (json['data'] != null) {
        walletData = WalletRechargeProceedData.fromJson(json['data']);
      }
    } else if (json['data'] != null) {
      // payment_method = razorpay (checkout)
      data = PaymentGateway.fromJson(json['data']);
    }
  }

  num? status;
  String? msg;
  /// Razorpay checkout gateway fields (razorpay flow only)
  PaymentGateway? data;
  /// QR block from proceedPaymentRequest when payment_method = razorpay_qr
  RazorpayQrProceedData? razorpayQrData;
  /// Wallet recharge row (order_id, amount, etc.) for razorpay_qr flow
  WalletRechargeProceedData? walletData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (razorpayQrData != null) {
      map['razorpay_qr_data'] = razorpayQrData?.toJson();
    }
    if (walletData != null) {
      map['wallet_data'] = walletData?.toJson();
    }
    return map;
  }
}

/// Matches backend `razorpay_qr_data` object
class RazorpayQrProceedData {
  RazorpayQrProceedData({
    this.status,
    this.msg,
    this.qrId,
    this.imageUrl,
    this.closeBy,
  });

  RazorpayQrProceedData.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    qrId = json['qr_id']?.toString();
    imageUrl = json['image_url']?.toString();
    closeBy = json['close_by'];
    // Fallback from nested Razorpay entity
    if ((qrId == null || qrId!.isEmpty) && json['data'] != null) {
      qrId = json['data']['id']?.toString();
    }
    if ((imageUrl == null || imageUrl!.isEmpty) && json['data'] != null) {
      imageUrl = json['data']['image_url']?.toString();
    }
  }

  num? status;
  String? msg;
  String? qrId;
  String? imageUrl;
  num? closeBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    map['qr_id'] = qrId;
    map['image_url'] = imageUrl;
    map['close_by'] = closeBy;
    return map;
  }
}

/// Wallet `data` object in razorpay_qr proceed response
class WalletRechargeProceedData {
  WalletRechargeProceedData({
    this.orderId,
    this.amount,
    this.walletAmount,
  });

  WalletRechargeProceedData.fromJson(dynamic json) {
    orderId = json['order_id']?.toString();
    amount = json['amount'] is num
        ? json['amount']
        : num.tryParse(json['amount']?.toString() ?? '');
    walletAmount = json['wallet_amount']?.toString();
  }

  String? orderId;
  num? amount;
  String? walletAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = orderId;
    map['amount'] = amount;
    map['wallet_amount'] = walletAmount;
    return map;
  }
}
