class ServicesModel {
  ServicesModel({
      this.status, 
      this.data, 
      this.offset, 
      this.msg,});

  ServicesModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ServicesData.fromJson(v));
      });
    }
    offset = json['offset'];
    msg = json['msg'];
  }
  num? status;
  List<ServicesData>? data;
  num? offset;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['offset'] = offset;
    map['msg'] = msg;
    return map;
  }

}

class ServicesData {
  ServicesData({
      this.id, 
      this.serviceCategoryId, 
      this.serviceName, 
      this.slug, 
      this.serviceImage, 
      this.serviceDescription, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.title,});

  ServicesData.fromJson(dynamic json) {
    id = json['id'];
    serviceCategoryId = json['service_category_id'];
    serviceName = json['service_name'];
    slug = json['slug'];
    serviceImage = json['service_image'];
    serviceDescription = json['service_description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
  }
  num? id;
  String? serviceCategoryId;
  String? serviceName;
  String? slug;
  String? serviceImage;
  String? serviceDescription;
  num? status;
  String? createdAt;
  String? updatedAt;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['service_category_id'] = serviceCategoryId;
    map['service_name'] = serviceName;
    map['slug'] = slug;
    map['service_image'] = serviceImage;
    map['service_description'] = serviceDescription;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['title'] = title;
    return map;
  }

}