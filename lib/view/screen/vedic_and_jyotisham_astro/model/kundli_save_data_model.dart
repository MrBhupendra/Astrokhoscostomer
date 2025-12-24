class KundliSaveDataModel {
  KundliSaveDataModel({
      this.status, 
      this.data, 
      this.offset, 
      this.msg,});

  KundliSaveDataModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(KundliSavedData.fromJson(v));
      });
    }
    offset = json['offset'];
    msg = json['msg'];
  }
  num? status;
  List<KundliSavedData>? data;
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

class KundliSavedData {
  KundliSavedData({
      this.id, 
      this.userUniId, 
      this.kundaliMethod, 
      this.kundaliType, 
      this.name, 
      this.requestBody, 
      this.createdAt, 
      this.updatedAt,});

  KundliSavedData.fromJson(dynamic json) {
    id = json['id'];
    userUniId = json['user_uni_id'];
    kundaliMethod = json['kundali_method'];
    kundaliType = json['kundali_type'];
    name = json['name'];
    requestBody = json['request_body'] != null ? RequestBody.fromJson(json['request_body']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? userUniId;
  String? kundaliMethod;
  String? kundaliType;
  String? name;
  RequestBody? requestBody;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_uni_id'] = userUniId;
    map['kundali_method'] = kundaliMethod;
    map['kundali_type'] = kundaliType;
    map['name'] = name;
    if (requestBody != null) {
      map['request_body'] = requestBody?.toJson();
    }
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class RequestBody {
  RequestBody({
      this.userUniId, 
      this.kundaliMethod, 
      this.kundaliType, 
      this.name, 
      this.dob, 
      this.tob, 
      this.lat, 
      this.lon, 
      this.timezone, 
      this.place,
    this.language,});

  RequestBody.fromJson(dynamic json) {
    userUniId = json['user_uni_id'];
    kundaliMethod = json['kundali_method'];
    kundaliType = json['kundali_type'];
    name = json['name'];
    dob = json['dob'];
    tob = json['tob'];
    lat = json['lat'];
    lon = json['lon'];
    timezone = json['timezone'];
    place = json['place'];
    language = json['language'];
  }
  String? userUniId;
  String? kundaliMethod;
  String? kundaliType;
  String? name;
  String? dob;
  String? tob;
  String? lat;
  String? lon;
  String? timezone;
  String? place;
  String? language;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_uni_id'] = userUniId;
    map['kundali_method'] = kundaliMethod;
    map['kundali_type'] = kundaliType;
    map['name'] = name;
    map['dob'] = dob;
    map['tob'] = tob;
    map['lat'] = lat;
    map['lon'] = lon;
    map['timezone'] = timezone;
    map['place'] = place;
    map['language'] = language;
    return map;
  }

}