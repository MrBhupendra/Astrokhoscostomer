class HoroscopeWeeklyJyotishamAstroModel {
  HoroscopeWeeklyJyotishamAstroModel({
      this.status, 
      this.response, 
      this.callsRemaining,});

  HoroscopeWeeklyJyotishamAstroModel.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'] != null ? Response.fromJson(json['response']) : null;
    callsRemaining = json['callsRemaining'];
  }
  num? status;
  Response? response;
  num? callsRemaining;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    map['callsRemaining'] = callsRemaining;
    return map;
  }

}

class Response {
  Response({
      this.week, 
      this.horoscopeData, 
      this.health, 
      this.friends, 
      this.family, 
      this.travel, 
      this.career, 
      this.relationship, 
      this.finance, 
      this.status, 
      this.physique, 
      this.total, 
      this.luckyColor, 
      this.colorCode, 
      this.luckyNumbers,});

  Response.fromJson(dynamic json) {
    week = json['week'];
    horoscopeData = json['horoscope_data'];
    health = json['health'];
    friends = json['friends'];
    family = json['family'];
    travel = json['travel'];
    career = json['career'];
    relationship = json['relationship'];
    finance = json['finance'];
    status = json['status'];
    physique = json['physique'];
    total = json['total'];
    luckyColor = json['lucky_color'];
    colorCode = json['color_code'];
    luckyNumbers = json['lucky_numbers'] != null ? json['lucky_numbers'].cast<num>() : [];
  }
  String? week;
  String? horoscopeData;
  num? health;
  num? friends;
  num? family;
  num? travel;
  num? career;
  num? relationship;
  num? finance;
  num? status;
  num? physique;
  num? total;
  String? luckyColor;
  String? colorCode;
  List<num>? luckyNumbers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['week'] = week;
    map['horoscope_data'] = horoscopeData;
    map['health'] = health;
    map['friends'] = friends;
    map['family'] = family;
    map['travel'] = travel;
    map['career'] = career;
    map['relationship'] = relationship;
    map['finance'] = finance;
    map['status'] = status;
    map['physique'] = physique;
    map['total'] = total;
    map['lucky_color'] = luckyColor;
    map['color_code'] = colorCode;
    map['lucky_numbers'] = luckyNumbers;
    return map;
  }

}