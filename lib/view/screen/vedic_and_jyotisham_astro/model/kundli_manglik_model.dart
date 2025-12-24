class KundliManglikModel {
  KundliManglikModel({
      this.status, 
      this.response,});

  KundliManglikModel.fromJson(dynamic json) {
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
      this.manglikByMars, 
      this.factors, 
      this.botResponse, 
      this.manglikBySaturn, 
      this.manglikByRahuketu, 
      this.aspects, 
      this.score,});

  Response.fromJson(dynamic json) {
    manglikByMars = json['manglik_by_mars'];
    factors = json['factors'] != null ? json['factors'].cast<String>() : [];
    botResponse = json['bot_response'];
    manglikBySaturn = json['manglik_by_saturn'];
    manglikByRahuketu = json['manglik_by_rahuketu'];
    aspects = json['aspects'] != null ? json['aspects'].cast<String>() : [];
    score = json['score'];
  }
  bool? manglikByMars;
  List<String>? factors;
  String? botResponse;
  bool? manglikBySaturn;
  bool? manglikByRahuketu;
  List<String>? aspects;
  num? score;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['manglik_by_mars'] = manglikByMars;
    map['factors'] = factors;
    map['bot_response'] = botResponse;
    map['manglik_by_saturn'] = manglikBySaturn;
    map['manglik_by_rahuketu'] = manglikByRahuketu;
    map['aspects'] = aspects;
    map['score'] = score;
    return map;
  }

}