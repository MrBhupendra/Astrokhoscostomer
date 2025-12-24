class HoroscopeMonthlyJyotishamAstroModel {
  HoroscopeMonthlyJyotishamAstroModel({
      this.status, 
      this.response, 
      this.callsRemaining,});

  HoroscopeMonthlyJyotishamAstroModel.fromJson(dynamic json) {
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
      this.challengingDays, 
      this.horoscopeData,
      this.month, 
      this.standoutDays,
      this.love,
      this.finances,
      this.status,
      this.career,
      this.travel,
      this.family,
      this.friends,
      this.health,
      this.total,
  });

  Response.fromJson(dynamic json) {
    challengingDays = json['challenging_days'];
    horoscopeData = json['horoscope_data'];
    month = json['month'];
    standoutDays = json['standout_days'];
    love = json['love'];
    finances = json['finances'];
    status = json['status'];
    career = json['career'];
    travel = json['travel'];
    family = json['family'];
    friends = json['friends'];
    health = json['health'];
    total = json['total'];
  }
  String? challengingDays;
  String? horoscopeData;
  String? month;
  String? standoutDays;
  int? love;
  int? finances;
  int? status;
  int? career;
  int? travel;
  int? family;
  int? friends;
  int? health;
  int? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['challenging_days'] = challengingDays;
    map['horoscope_data'] = horoscopeData;
    map['month'] = month;
    map['standout_days'] = standoutDays;
    map['love'] = love;
    map['finances'] = finances;
    map['status'] = status;
    map['career'] = career;
    map['travel'] = travel;
    map['family'] = family;
    map['friends'] = friends;
    map['health'] = health;
    map['total'] = total;
    return map;
  }

}