class KundliRudrakshaSuggestionsModel {
  KundliRudrakshaSuggestionsModel({
      this.status, 
      this.response, 
      this.callsRemaining,});

  KundliRudrakshaSuggestionsModel.fromJson(dynamic json) {
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
      this.rudraksh, 
      this.name, 
      this.qualities, 
      this.howToWear, 
      this.timeToWear, 
      this.mantra, 
      this.personalizedResponse, 
      this.purification,});

  Response.fromJson(dynamic json) {
    rudraksh = json['rudraksh'] != null ? json['rudraksh'].cast<String>() : [];
    name = json['name'] != null ? json['name'].cast<String>() : [];
    qualities = json['qualities'] != null ? json['qualities'].cast<String>() : [];
    howToWear = json['how_to_wear'];
    timeToWear = json['time_to_wear'];
    mantra = json['mantra'] != null ? json['mantra'].cast<String>() : [];
    personalizedResponse = json['personalized_response'];
    purification = json['purification'];
  }
  List<String>? rudraksh;
  List<String>? name;
  List<String>? qualities;
  String? howToWear;
  String? timeToWear;
  List<String>? mantra;
  String? personalizedResponse;
  String? purification;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rudraksh'] = rudraksh;
    map['name'] = name;
    map['qualities'] = qualities;
    map['how_to_wear'] = howToWear;
    map['time_to_wear'] = timeToWear;
    map['mantra'] = mantra;
    map['personalized_response'] = personalizedResponse;
    map['purification'] = purification;
    return map;
  }

}