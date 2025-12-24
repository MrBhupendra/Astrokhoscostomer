class SubscriptionListModel {
  SubscriptionListModel({
      this.status, 
      this.offset, 
      this.data, 
      this.msg,});

  SubscriptionListModel.fromJson(dynamic json) {
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
      this.title, 
      this.validityInDays, 
      this.videoCallDuration, 
      this.voiceCallDuration, 
      this.chatDuration,
      this.productOrderCount,
      this.productOrderDiscount,
      this.price, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    validityInDays = json['validity_in_days'];
    videoCallDuration = json['video_call_duration'];
    voiceCallDuration = json['voice_call_duration'];
    chatDuration = json['chat_duration'];
    productOrderCount = json['product_order_count'];
    productOrderDiscount = json['product_order_discount'];
    price = json['price'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? title;
  num? validityInDays;
  num? videoCallDuration;
  num? voiceCallDuration;
  num? chatDuration;
  num? productOrderCount;
  String? productOrderDiscount;
  num? price;
  num? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['validity_in_days'] = validityInDays;
    map['video_call_duration'] = videoCallDuration;
    map['voice_call_duration'] = voiceCallDuration;
    map['chat_duration'] = chatDuration;
    map['product_order_count'] = productOrderCount;
    map['product_order_discount'] = productOrderDiscount;
    map['price'] = price;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}