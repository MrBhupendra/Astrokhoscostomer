class HoroscopeDailyVedicAstroModel {
  HoroscopeDailyVedicAstroModel({
      this.status, 
      this.response,});

  HoroscopeDailyVedicAstroModel.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'] != null ? Response.fromJson(json['response']) : null;
  }
  num? status;
  Response? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    return map;
  }

}

class Response {
  Response({
      this.totalScore, 
      this.luckyColor, 
      this.luckyColorCode, 
      this.luckyNumber, 
      this.physique, 
      this.status, 
      this.finances, 
      this.relationship, 
      this.career, 
      this.travel, 
      this.family, 
      this.friends, 
      this.health, 
      this.botResponse, 
      this.zodiac,});

  Response.fromJson(dynamic json) {
    totalScore = json['total_score'];
    luckyColor = json['lucky_color'];
    luckyColorCode = json['lucky_color_code'];
    luckyNumber = json['lucky_number'] != null ? json['lucky_number'].cast<num>() : [];
    physique = json['physique'];
    status = json['status'];
    finances = json['finances'];
    relationship = json['relationship'];
    career = json['career'];
    travel = json['travel'];
    family = json['family'];
    friends = json['friends'];
    health = json['health'];
    botResponse = json['bot_response'];
    zodiac = json['zodiac'];
  }
  num? totalScore;
  String? luckyColor;
  String? luckyColorCode;
  List<num>? luckyNumber;
  num? physique;
  num? status;
  num? finances;
  num? relationship;
  num? career;
  num? travel;
  num? family;
  num? friends;
  num? health;
  String? botResponse;
  String? zodiac;




  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_score'] = totalScore;
    map['lucky_color'] = luckyColor;
    map['lucky_color_code'] = luckyColorCode;
    map['lucky_number'] = luckyNumber;
    map['physique'] = physique;
    map['status'] = status;
    map['finances'] = finances;
    map['relationship'] = relationship;
    map['career'] = career;
    map['travel'] = travel;
    map['family'] = family;
    map['friends'] = friends;
    map['health'] = health;
    map['bot_response'] = botResponse;
    map['zodiac'] = zodiac;
    return map;
  }

}