import 'package:get/get_rx/src/rx_types/rx_types.dart';

class AiProfileModel {
  AiProfileModel({
      this.status, 
      this.offset, 
      this.data, 
      this.msg,});

  AiProfileModel.fromJson(dynamic json) {
    status = json['status'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AiProfileListData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  num? offset;
  List<AiProfileListData>? data;
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

class AiProfileListData {
  AiProfileListData({
      this.id, 
      this.customerUniId, 
      this.name, 
      this.gender, 
      this.dob, 
      this.tob, 
      this.pob, 
      this.lat, 
      this.lon, 
      this.lang, 
      this.isSelected,
      this.isSelfProfile, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.profileImage,});

  AiProfileListData.fromJson(dynamic json) {
    id = json['id'];
    customerUniId = json['customer_uni_id'];
    name = json['name'];
    gender = json['gender'];
    dob = json['dob'];
    tob = json['tob'];
    pob = json['pob'];
    lat = json['lat'];
    lon = json['lon'];
    lang = json['lang'];
    isSelected = (json['is_selected'] != null) ? RxInt(json['is_selected']) : null;
    isSelfProfile = json['is_self_profile'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profileImage = json['profile_image'];
  }
  num? id;
  String? customerUniId;
  String? name;
  String? gender;
  String? dob;
  String? tob;
  String? pob;
  String? lat;
  String? lon;
  String? lang;
  RxInt? isSelected;
  num? isSelfProfile;
  num? status;
  String? createdAt;
  String? updatedAt;
  String? profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['customer_uni_id'] = customerUniId;
    map['name'] = name;
    map['gender'] = gender;
    map['dob'] = dob;
    map['tob'] = tob;
    map['pob'] = pob;
    map['lat'] = lat;
    map['lon'] = lon;
    map['lang'] = lang;
    map['is_selected'] = isSelected?.value;
    map['is_self_profile'] = isSelfProfile;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['profile_image'] = profileImage;
    return map;
  }

}