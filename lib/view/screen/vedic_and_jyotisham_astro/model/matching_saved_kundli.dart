class MatchingSavedKundli {
  MatchingSavedKundli({
      this.status, 
      this.data, 
      this.offset, 
      this.msg,});

  MatchingSavedKundli.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(MatchingSavedKundliData.fromJson(v));
      });
    }
    offset = json['offset'];
    msg = json['msg'];
  }
  num? status;
  List<MatchingSavedKundliData>? data;
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

class MatchingSavedKundliData {
  MatchingSavedKundliData({
      this.id, 
      this.userUniId, 
      this.kundaliMethod, 
      this.kundaliType, 
      this.name, 
      this.requestBody,});

  MatchingSavedKundliData.fromJson(dynamic json) {
    id = json['id'];
    userUniId = json['user_uni_id'];
    kundaliMethod = json['kundali_method'];
    kundaliType = json['kundali_type'];
    name = json['name'];
    requestBody = json['request_body'] != null ? RequestBody.fromJson(json['request_body']) : null;
  }
  num? id;
  String? userUniId;
  String? kundaliMethod;
  String? kundaliType;
  String? name;
  RequestBody? requestBody;

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
    return map;
  }

}

class RequestBody {
  RequestBody({
      this.userUniId, 
      this.kundaliMethod, 
      this.kundaliType, 
      this.boyName, 
      this.boyDob, 
      this.boyTob, 
      this.boyLat, 
      this.boyLon, 
      this.boyTz, 
      this.boyPlace, 
      this.girlName, 
      this.girlDob, 
      this.girlTob, 
      this.girlLat, 
      this.girlLon, 
      this.girlTz, 
      this.girlPlace, 
      this.language,});

  RequestBody.fromJson(dynamic json) {
    userUniId = json['user_uni_id'];
    kundaliMethod = json['kundali_method'];
    kundaliType = json['kundali_type'];
    boyName = json['boy_name'];
    boyDob = json['boy_dob'];
    boyTob = json['boy_tob'];
    boyLat = json['boy_lat'];
    boyLon = json['boy_lon'];
    boyTz = json['boy_tz'];
    boyPlace = json['boy_place'];
    girlName = json['girl_name'];
    girlDob = json['girl_dob'];
    girlTob = json['girl_tob'];
    girlLat = json['girl_lat'];
    girlLon = json['girl_lon'];
    girlTz = json['girl_tz'];
    girlPlace = json['girl_place'];
    language = json['language'];
  }
  String? userUniId;
  String? kundaliMethod;
  String? kundaliType;
  String? boyName;
  String? boyDob;
  String? boyTob;
  String? boyLat;
  String? boyLon;
  String? boyTz;
  String? boyPlace;
  String? girlName;
  String? girlDob;
  String? girlTob;
  String? girlLat;
  String? girlLon;
  String? girlTz;
  String? girlPlace;
  String? language;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_uni_id'] = userUniId;
    map['kundali_method'] = kundaliMethod;
    map['kundali_type'] = kundaliType;
    map['boy_name'] = boyName;
    map['boy_dob'] = boyDob;
    map['boy_tob'] = boyTob;
    map['boy_lat'] = boyLat;
    map['boy_lon'] = boyLon;
    map['boy_tz'] = boyTz;
    map['boy_place'] = boyPlace;
    map['girl_name'] = girlName;
    map['girl_dob'] = girlDob;
    map['girl_tob'] = girlTob;
    map['girl_lat'] = girlLat;
    map['girl_lon'] = girlLon;
    map['girl_tz'] = girlTz;
    map['girl_place'] = girlPlace;
    map['language'] = language;
    return map;
  }

}