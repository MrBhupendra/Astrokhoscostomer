class KundliPitraDoshModel {
  KundliPitraDoshModel({
      this.status, 
      this.response,});

  KundliPitraDoshModel.fromJson(dynamic json) {
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
      this.isDoshaPresent, 
      this.botResponse, 
      this.effects, 
      this.remedies,});

  Response.fromJson(dynamic json) {
    isDoshaPresent = json['is_dosha_present'];
    botResponse = json['bot_response'];
    effects = json['effects'] != null ? json['effects'].cast<String>() : [];
    remedies = json['remedies'] != null ? json['remedies'].cast<String>() : [];
  }
  bool? isDoshaPresent;
  String? botResponse;
  List<String>? effects;
  List<String>? remedies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_dosha_present'] = isDoshaPresent;
    map['bot_response'] = botResponse;
    map['effects'] = effects;
    map['remedies'] = remedies;
    return map;
  }

}