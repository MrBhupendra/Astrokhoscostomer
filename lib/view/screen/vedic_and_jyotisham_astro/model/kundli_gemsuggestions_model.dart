class KundliGemsuggestionsModel {
  KundliGemsuggestionsModel({
      this.status, 
      this.response, 
      this.callsRemaining,});

  KundliGemsuggestionsModel.fromJson(dynamic json) {
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
      this.name, 
      this.gem, 
      this.otherName, 
      this.color, 
      this.planet, 
      this.description, 
      this.goodResults, 
      this.diseasesCure, 
      this.finger, 
      this.weight, 
      this.day, 
      this.metal, 
      this.substitute, 
      this.notToWearWith, 
      this.flawResults, 
      this.timeToWearShort, 
      this.timeToWear, 
      this.methods, 
      this.mantra, 
      this.key,});

  Response.fromJson(dynamic json) {
    name = json['name'];
    gem = json['gem'];
    otherName = json['other_name'];
    color = json['color'];
    planet = json['planet'];
    description = json['description'];
    goodResults = json['good_results'] != null ? json['good_results'].cast<String>() : [];
    diseasesCure = json['diseases_cure'] != null ? json['diseases_cure'].cast<String>() : [];
    finger = json['finger'];
    weight = json['weight'];
    day = json['day'];
    metal = json['metal'];
    substitute = json['substitute'] != null ? json['substitute'].cast<String>() : [];
    notToWearWith = json['not_to_wear_with'] != null ? json['not_to_wear_with'].cast<String>() : [];
    if (json['flaw_results'] != null) {
      flawResults = [];
      json['flaw_results'].forEach((v) {
        flawResults?.add(FlawResults.fromJson(v));
      });
    }
    timeToWearShort = json['time_to_wear_short'];
    timeToWear = json['time_to_wear'];
    methods = json['methods'];
    mantra = json['mantra'];
    key = json['key'];
  }
  String? name;
  String? gem;
  String? otherName;
  String? color;
  String? planet;
  String? description;
  List<String>? goodResults;
  List<String>? diseasesCure;
  String? finger;
  String? weight;
  String? day;
  String? metal;
  List<String>? substitute;
  List<String>? notToWearWith;
  List<FlawResults>? flawResults;
  String? timeToWearShort;
  String? timeToWear;
  String? methods;
  String? mantra;
  String? key;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['gem'] = gem;
    map['other_name'] = otherName;
    map['color'] = color;
    map['planet'] = planet;
    map['description'] = description;
    map['good_results'] = goodResults;
    map['diseases_cure'] = diseasesCure;
    map['finger'] = finger;
    map['weight'] = weight;
    map['day'] = day;
    map['metal'] = metal;
    map['substitute'] = substitute;
    map['not_to_wear_with'] = notToWearWith;
    if (flawResults != null) {
      map['flaw_results'] = flawResults?.map((v) => v.toJson()).toList();
    }
    map['time_to_wear_short'] = timeToWearShort;
    map['time_to_wear'] = timeToWear;
    map['methods'] = methods;
    map['mantra'] = mantra;
    map['key'] = key;
    return map;
  }

}

class FlawResults {
  FlawResults({
      this.flawType, 
      this.flawEffects,});

  FlawResults.fromJson(dynamic json) {
    flawType = json['flaw_type'];
    flawEffects = json['flaw_effects'];
  }
  String? flawType;
  String? flawEffects;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['flaw_type'] = flawType;
    map['flaw_effects'] = flawEffects;
    return map;
  }

}