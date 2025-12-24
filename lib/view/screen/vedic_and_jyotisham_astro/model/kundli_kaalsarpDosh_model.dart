class KundliKaalsarpDoshModel {
  KundliKaalsarpDoshModel({
      this.status, 
      this.response,});

  KundliKaalsarpDoshModel.fromJson(dynamic json) {
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
      this.doshaDirection, 
      this.doshaType, 
      this.rahuKetuAxis, 
      this.botResponse, 
      this.remedies,});

  Response.fromJson(dynamic json) {
    isDoshaPresent = json['is_dosha_present'];
    doshaDirection = json['dosha_direction'];
    doshaType = json['dosha_type'];
    rahuKetuAxis = json['rahu_ketu_axis'];
    botResponse = json['bot_response'];
    remedies = json['remedies'] != null ? json['remedies'].cast<String>() : [];
  }
  bool? isDoshaPresent;
  String? doshaDirection;
  String? doshaType;
  String? rahuKetuAxis;
  String? botResponse;
  List<String>? remedies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_dosha_present'] = isDoshaPresent;
    map['dosha_direction'] = doshaDirection;
    map['dosha_type'] = doshaType;
    map['rahu_ketu_axis'] = rahuKetuAxis;
    map['bot_response'] = botResponse;
    map['remedies'] = remedies;
    return map;
  }

}