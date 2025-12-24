class QuestionProfileModel {
  QuestionProfileModel({
    this.status,
    this.data,
    this.msg,
  });

  QuestionProfileModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  num? status;
  Data? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['msg'] = msg;
    return map;
  }
}

class Data {
  Data(
      {this.name,
      this.gender,
      this.dob,
      this.tob,
      this.pob,
      this.lat,
      this.lon,
      this.lang});

  Data.fromJson(dynamic json) {
    name = json['name'];
    gender = json['gender'];
    dob = json['dob'];
    tob = json['tob'];
    pob = json['pob'];
    lat = json['lat'];
    lon = json['lon'];
    lang = json['lang'];
  }

  String? name;
  String? gender;
  String? dob;
  String? tob;
  String? pob;
  String? lat;
  String? lon;
  String? lang;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['gender'] = gender;
    map['dob'] = dob;
    map['tob'] = tob;
    map['pob'] = pob;
    map['lat'] = lat;
    map['lon'] = lon;
    map['lang'] = lang;
    return map;
  }
}
