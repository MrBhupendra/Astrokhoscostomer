class OrderHistoryModel {
  OrderHistoryModel({
      this.status, 
      this.msg, 
      this.offset, 
      this.data,});

  OrderHistoryModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(OrderHistoryData.fromJson(v));
      });
    }
  }
  num? status;
  String? msg;
  num? offset;
  List<OrderHistoryData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    map['offset'] = offset;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class OrderHistoryData {
  OrderHistoryData({
      this.id, 
      this.userUniId, 
      this.referenceId, 
      this.transactionCode, 
      this.walletHistoryDescription, 
      this.transactionAmount, 
      this.amount, 
      this.mainType, 
      this.createdBy, 
      this.adminPercentage, 
      this.gstAmount, 
      this.astroAmount, 
      this.adminAmount, 
      this.tdsAmount, 
      this.offerAmount, 
      this.gatewayCharge, 
      this.coupanAmount, 
      this.status, 
      this.offerStatus, 
      this.createdAt, 
      this.updatedAt, 
      this.customerUniId, 
      this.astrologerUniId, 
      this.callType, 
      this.uniqeid, 
      this.orderDate, 
      this.callStart, 
      this.callEnd, 
      this.duration, 
      this.charge, 
      this.recording, 
      this.waitingTime, 
      this.waitingForRequest, 
      this.refundValidDate, 
      this.offerType,
      this.displayName,
      this.astroImg, 
      this.phone, 
      this.name, 
      this.email,
      this.callHistoryImagesExists,
  });

  OrderHistoryData.fromJson(dynamic json) {
    id = json['id'];
    userUniId = json['user_uni_id'];
    referenceId = json['reference_id'];
    transactionCode = json['transaction_code'];
    walletHistoryDescription = json['wallet_history_description'];
    transactionAmount = json['transaction_amount'];
    amount = json['amount'];
    mainType = json['main_type'];
    createdBy = json['created_by'];
    adminPercentage = json['admin_percentage'];
    gstAmount = json['gst_amount'];
    astroAmount = json['astro_amount'];
    adminAmount = json['admin_amount'];
    tdsAmount = json['tds_amount'];
    offerAmount = json['offer_amount'];
    gatewayCharge = json['gateway_charge'];
    coupanAmount = json['coupan_amount'];
    status = json['status'];
    offerStatus = json['offer_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerUniId = json['customer_uni_id'];
    astrologerUniId = json['astrologer_uni_id'];
    callType = json['call_type'];
    uniqeid = json['uniqeid'];
    orderDate = json['order_date'];
    callStart = json['call_start'];
    callEnd = json['call_end'];
    duration = json['duration'];
    charge = json['charge'];
    recording = json['recording'];
    waitingTime = json['waiting_time'];
    waitingForRequest = json['waiting_for_request'];
    refundValidDate = json['refund_valid_date'];
    offerType = json['offer_type'];
    displayName = json['display_name'];
    astroImg = json['astro_img'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
    callHistoryImagesExists = json['call_history_images_exists'];
  }
  num? id;
  String? userUniId;
  String? referenceId;
  String? transactionCode;
  String? walletHistoryDescription;
  String? transactionAmount;
  String? amount;
  String? mainType;
  String? createdBy;
  String? adminPercentage;
  String? gstAmount;
  String? astroAmount;
  String? adminAmount;
  String? tdsAmount;
  String? offerAmount;
  String? gatewayCharge;
  String? coupanAmount;
  String? status;
  num? offerStatus;
  String? createdAt;
  String? updatedAt;
  String? customerUniId;
  String? astrologerUniId;
  String? callType;
  String? uniqeid;
  String? orderDate;
  String? callStart;
  String? callEnd;
  String? duration;
  num? charge;
  String? recording;
  num? waitingTime;
  String? waitingForRequest;
  String? refundValidDate;
  String? offerType;
  String? displayName;
  String? astroImg;
  String? phone;
  String? name;
  String? email;
  num? callHistoryImagesExists;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_uni_id'] = userUniId;
    map['reference_id'] = referenceId;
    map['transaction_code'] = transactionCode;
    map['wallet_history_description'] = walletHistoryDescription;
    map['transaction_amount'] = transactionAmount;
    map['amount'] = amount;
    map['main_type'] = mainType;
    map['created_by'] = createdBy;
    map['admin_percentage'] = adminPercentage;
    map['gst_amount'] = gstAmount;
    map['astro_amount'] = astroAmount;
    map['admin_amount'] = adminAmount;
    map['tds_amount'] = tdsAmount;
    map['offer_amount'] = offerAmount;
    map['gateway_charge'] = gatewayCharge;
    map['coupan_amount'] = coupanAmount;
    map['status'] = status;
    map['offer_status'] = offerStatus;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['customer_uni_id'] = customerUniId;
    map['astrologer_uni_id'] = astrologerUniId;
    map['call_type'] = callType;
    map['uniqeid'] = uniqeid;
    map['order_date'] = orderDate;
    map['call_start'] = callStart;
    map['call_end'] = callEnd;
    map['duration'] = duration;
    map['charge'] = charge;
    map['recording'] = recording;
    map['waiting_time'] = waitingTime;
    map['waiting_for_request'] = waitingForRequest;
    map['refund_valid_date'] = refundValidDate;
    map['offer_type'] = offerType;
    map['display_name'] = displayName;
    map['astro_img'] = astroImg;
    map['phone'] = phone;
    map['name'] = name;
    map['email'] = email;
    map['call_history_images_exists'] = callHistoryImagesExists;
    return map;
  }

}