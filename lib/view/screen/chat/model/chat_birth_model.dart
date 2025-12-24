class ChatBirthModel {
  ChatBirthModel({
    this.name,
    this.gender,
    this.dob,
    this.tob,
    this.pob,
    this.latitude,
    this.longitude,
    this.partnerName,
    this.partnerGender,
    this.partnerDob,
    this.partnerTob,
    this.partnerPob,
    this.partnerLatitude,
    this.partnerLongitude,
  });

  ChatBirthModel.fromJson(dynamic json) {
    name = json['name'];
    gender = json['gender'];
    dob = json['dob'];
    tob = json['tob'];
    pob = json['pob'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    partnerName = json['partnerName'];
    partnerGender = json['partnerGender'];
    partnerDob = json['partnerDob'];
    partnerTob = json['partnerTob'];
    partnerPob = json['partnerPob'];
    partnerLatitude = json['partnerLatitude'];
    partnerLongitude = json['partnerLongitude'];
  }

  String? name;
  String? gender;
  String? dob;
  String? tob;
  String? pob;
  String? latitude;
  String? longitude;
  //Partner Detail
  String? partnerName;
  String? partnerGender;
  String? partnerDob;
  String? partnerTob;
  String? partnerPob;
  String? partnerLatitude;
  String? partnerLongitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['gender'] = gender;
    map['dob'] = dob;
    map['tob'] = tob;
    map['pob'] = pob;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['partnerName'] = partnerName;
    map['partnerGender'] = partnerGender;
    map['partnerDob'] = partnerDob;
    map['partnerTob'] = partnerTob;
    map['partnerPob'] = partnerPob;
    map['partnerLatitude'] = partnerLatitude;
    map['partnerLongitude'] = partnerLongitude;
    return map;
  }
}
