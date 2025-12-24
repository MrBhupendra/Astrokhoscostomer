class UserAddressModel {
  UserAddressModel({
      this.status, 
      this.data, 
      this.msg,});

  UserAddressModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AddressData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  List<AddressData>? data;
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

class AddressData {
  AddressData({
      this.id, 
      this.userUniId, 
      this.name, 
      this.email, 
      this.phone, 
      this.houseNo, 
      this.streetArea, 
      this.landmark, 
      this.city, 
      this.state, 
      this.country, 
      this.address, 
      this.latitude, 
      this.longitude, 
      this.pincode, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  AddressData.fromJson(dynamic json) {
    id = json['id'];
    userUniId = json['user_uni_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    houseNo = json['house_no'];
    streetArea = json['street_area'];
    landmark = json['landmark'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    pincode = json['pincode'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? userUniId;
  String? name;
  String? email;
  String? phone;
  String? houseNo;
  String? streetArea;
  String? landmark;
  String? city;
  String? state;
  String? country;
  String? address;
  String? latitude;
  String? longitude;
  num? pincode;
  num? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_uni_id'] = userUniId;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['house_no'] = houseNo;
    map['street_area'] = streetArea;
    map['landmark'] = landmark;
    map['city'] = city;
    map['state'] = state;
    map['country'] = country;
    map['address'] = address;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['pincode'] = pincode;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}