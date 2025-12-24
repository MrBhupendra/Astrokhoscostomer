class SlotOrdersListModel {
  SlotOrdersListModel({
      this.status, 
      this.offset, 
      this.data, 
      this.msg,});

  SlotOrdersListModel.fromJson(dynamic json) {
    status = json['status'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SlotOrdersData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  num? offset;
  List<SlotOrdersData>? data;
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

class SlotOrdersData {
  SlotOrdersData({
      this.id, 
      this.astrologerUniId, 
      this.customerUniId, 
      this.orderId, 
      this.slotDate, 
      this.slotStart, 
      this.slotEnd, 
      this.slotDuration, 
      this.charge, 
      this.serialNo, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.customerName, 
      this.customerEmail, 
      this.customerPhone, 
      this.customerImg, 
      this.astrologerName, 
      this.astrologerEmail, 
      this.astrologerPhone, 
      this.astrologerDisplayName, 
      this.astrologerImg,});

  SlotOrdersData.fromJson(dynamic json) {
    id = json['id'];
    astrologerUniId = json['astrologer_uni_id'];
    customerUniId = json['customer_uni_id'];
    orderId = json['order_id'];
    slotDate = json['slot_date'];
    slotStart = json['slot_start'];
    slotEnd = json['slot_end'];
    slotDuration = json['slot_duration'];
    charge = json['charge'];
    serialNo = json['serial_no'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerPhone = json['customer_phone'];
    customerImg = json['customer_img'];
    astrologerName = json['astrologer_name'];
    astrologerEmail = json['astrologer_email'];
    astrologerPhone = json['astrologer_phone'];
    astrologerDisplayName = json['astrologer_display_name'];
    astrologerImg = json['astrologer_img'];
  }
  num? id;
  String? astrologerUniId;
  String? customerUniId;
  String? orderId;
  String? slotDate;
  String? slotStart;
  String? slotEnd;
  String? slotDuration;
  String? charge;
  num? serialNo;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? customerName;
  String? customerEmail;
  String? customerPhone;
  String? customerImg;
  String? astrologerName;
  String? astrologerEmail;
  String? astrologerPhone;
  String? astrologerDisplayName;
  String? astrologerImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['astrologer_uni_id'] = astrologerUniId;
    map['customer_uni_id'] = customerUniId;
    map['order_id'] = orderId;
    map['slot_date'] = slotDate;
    map['slot_start'] = slotStart;
    map['slot_end'] = slotEnd;
    map['slot_duration'] = slotDuration;
    map['charge'] = charge;
    map['serial_no'] = serialNo;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['customer_name'] = customerName;
    map['customer_email'] = customerEmail;
    map['customer_phone'] = customerPhone;
    map['customer_img'] = customerImg;
    map['astrologer_name'] = astrologerName;
    map['astrologer_email'] = astrologerEmail;
    map['astrologer_phone'] = astrologerPhone;
    map['astrologer_display_name'] = astrologerDisplayName;
    map['astrologer_img'] = astrologerImg;
    return map;
  }

}