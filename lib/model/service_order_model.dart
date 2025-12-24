class ServiceOrderModel {
  ServiceOrderModel({
      this.status, 
      this.data, 
      this.msg,});

  ServiceOrderModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ServiceOrderData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  List<ServiceOrderData>? data;
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

class ServiceOrderData {
  ServiceOrderData({
      this.id, 
      this.serviceAssignId, 
      this.customerUniId, 
      this.astrologerUniId, 
      this.orderId, 
      this.price, 
      this.availableDuration, 
      this.date, 
      this.time,
      this.fileType,
      this.fileUrl,
      this.status, 
      this.paymentStatus, 
      this.createdAt, 
      this.updatedAt, 
      this.serviceAssign, 
      this.astrologer,
    this.isAvailable,});

  ServiceOrderData.fromJson(dynamic json) {
    id = json['id'];
    serviceAssignId = json['service_assign_id'];
    customerUniId = json['customer_uni_id'];
    astrologerUniId = json['astrologer_uni_id'];
    orderId = json['order_id'];
    price = json['price'];
    availableDuration = json['available_duration'];
    date = json['date'];
    time = json['time'];
    fileType = json['file_type'];
    fileUrl = json['file_url'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    serviceAssign = json['service_assign'] != null ? ServiceAssign.fromJson(json['service_assign']) : null;
    astrologer = json['astrologer'] != null ? Astrologer.fromJson(json['astrologer']) : null;
    isAvailable = json['is_available'];
  }
  num? id;
  num? serviceAssignId;
  String? customerUniId;
  String? astrologerUniId;
  String? orderId;
  num? price;
  num? availableDuration;
  String? date;
  String? time;
  String? fileType;
  String? fileUrl;
  String? status;
  String? paymentStatus;
  String? createdAt;
  String? updatedAt;
  ServiceAssign? serviceAssign;
  Astrologer? astrologer;
  num? isAvailable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['service_assign_id'] = serviceAssignId;
    map['customer_uni_id'] = customerUniId;
    map['astrologer_uni_id'] = astrologerUniId;
    map['order_id'] = orderId;
    map['price'] = price;
    map['available_duration'] = availableDuration;
    map['date'] = date;
    map['time'] = time;
    map['file_type'] = fileType;
    map['file_url'] = fileUrl;
    map['status'] = status;
    map['payment_status'] = paymentStatus;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (serviceAssign != null) {
      map['service_assign'] = serviceAssign?.toJson();
    }
    if (astrologer != null) {
      map['astrologer'] = astrologer?.toJson();
    }
    map['is_available'] = isAvailable;
    return map;
  }

}

class Astrologer {
  Astrologer({
      this.id, 
      this.astrologerUniId, 
      this.displayName, 
      this.slug, 
      this.astroImg,});

  Astrologer.fromJson(dynamic json) {
    id = json['id'];
    astrologerUniId = json['astrologer_uni_id'];
    displayName = json['display_name'];
    slug = json['slug'];
    astroImg = json['astro_img'];
  }
  num? id;
  String? astrologerUniId;
  String? displayName;
  String? slug;
  String? astroImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['astrologer_uni_id'] = astrologerUniId;
    map['display_name'] = displayName;
    map['slug'] = slug;
    map['astro_img'] = astroImg;
    return map;
  }

}

class ServiceAssign {
  ServiceAssign({
      this.id, 
      this.serviceId, 
      this.astrologerUniId, 
      this.price, 
      this.duration, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.service,});

  ServiceAssign.fromJson(dynamic json) {
    id = json['id'];
    serviceId = json['service_id'];
    astrologerUniId = json['astrologer_uni_id'];
    price = json['price'];
    duration = json['duration'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service = json['service'] != null ? Service.fromJson(json['service']) : null;
  }
  num? id;
  num? serviceId;
  String? astrologerUniId;
  num? price;
  num? duration;
  num? status;
  String? createdAt;
  String? updatedAt;
  Service? service;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['service_id'] = serviceId;
    map['astrologer_uni_id'] = astrologerUniId;
    map['price'] = price;
    map['duration'] = duration;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (service != null) {
      map['service'] = service?.toJson();
    }
    return map;
  }

}

class Service {
  Service({
      this.id, 
      this.serviceCategoryId, 
      this.serviceName, 
      this.slug, 
      this.serviceImage, 
      this.serviceDescription,});

  Service.fromJson(dynamic json) {
    id = json['id'];
    serviceCategoryId = json['service_category_id'];
    serviceName = json['service_name'];
    slug = json['slug'];
    serviceImage = json['service_image'];
    serviceDescription = json['service_description'];
  }
  num? id;
  String? serviceCategoryId;
  String? serviceName;
  String? slug;
  String? serviceImage;
  String? serviceDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['service_category_id'] = serviceCategoryId;
    map['service_name'] = serviceName;
    map['slug'] = slug;
    map['service_image'] = serviceImage;
    map['service_description'] = serviceDescription;
    return map;
  }

}