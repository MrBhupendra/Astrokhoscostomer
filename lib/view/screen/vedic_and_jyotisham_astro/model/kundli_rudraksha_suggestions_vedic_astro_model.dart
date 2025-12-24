class KundliRudrakshaSuggestionsVedicAstroModel {
  KundliRudrakshaSuggestionsVedicAstroModel({
      this.status, 
      this.response,});

  KundliRudrakshaSuggestionsVedicAstroModel.fromJson(dynamic json) {
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
      this.mukhiForDiseaseCure, 
      this.mukhiForMoney, 
      this.mukhiDescription, 
      this.botResponse, 
      this.name,});

  Response.fromJson(dynamic json) {
    mukhiForDiseaseCure = json['mukhi_for_disease_cure'] != null ? json['mukhi_for_disease_cure'].cast<num>() : [];
    mukhiForMoney = json['mukhi_for_money'] != null ? json['mukhi_for_money'].cast<num>() : [];
    mukhiDescription = json['mukhi_description'];
    botResponse = json['bot_response'];
    name = json['name'];
  }
  List<num>? mukhiForDiseaseCure;
  List<num>? mukhiForMoney;
  String? mukhiDescription;
  String? botResponse;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mukhi_for_disease_cure'] = mukhiForDiseaseCure;
    map['mukhi_for_money'] = mukhiForMoney;
    map['mukhi_description'] = mukhiDescription;
    map['bot_response'] = botResponse;
    map['name'] = name;
    return map;
  }

}