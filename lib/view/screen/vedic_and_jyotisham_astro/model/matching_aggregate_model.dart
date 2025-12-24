class MatchingAggregateModel {
  MatchingAggregateModel({
      this.status, 
      this.response,});

  MatchingAggregateModel.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'] != null ? MatchingAggregateResponse.fromJson(json['response']) : null;
  }
  num? status;
  MatchingAggregateResponse? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    return map;
  }

}

class MatchingAggregateResponse {
  MatchingAggregateResponse({
      this.ashtakootScore, 
      this.dashkootScore, 
      this.rajjudosh, 
      this.vedhadosh, 
      this.mangaldosh, 
      this.mangaldoshPoints, 
      this.pitradosh, 
      this.pitradoshPoints, 
      this.kaalsarpdosh, 
      this.kaalsarpPoints, 
      this.manglikdoshSaturn, 
      this.manglikdoshSaturnPoints, 
      this.manglikdoshRahuketu, 
      this.manglikdoshRahuketuPoints, 
      this.score, 
      this.extendedResponse, 
      this.botResponse,});

  MatchingAggregateResponse.fromJson(dynamic json) {
    ashtakootScore = json['ashtakoot_score'];
    dashkootScore = json['dashkoot_score'];
    rajjudosh = json['rajjudosh'];
    vedhadosh = json['vedhadosh'];
    mangaldosh = json['mangaldosh'];
    mangaldoshPoints = json['mangaldosh_points'] != null ? MangaldoshPoints.fromJson(json['mangaldosh_points']) : null;
    pitradosh = json['pitradosh'];
    pitradoshPoints = json['pitradosh_points'] != null ? PitradoshPoints.fromJson(json['pitradosh_points']) : null;
    kaalsarpdosh = json['kaalsarpdosh'];
    kaalsarpPoints = json['kaalsarp_points'] != null ? KaalsarpPoints.fromJson(json['kaalsarp_points']) : null;
    manglikdoshSaturn = json['manglikdosh_saturn'];
    manglikdoshSaturnPoints = json['manglikdosh_saturn_points'] != null ? ManglikdoshSaturnPoints.fromJson(json['manglikdosh_saturn_points']) : null;
    manglikdoshRahuketu = json['manglikdosh_rahuketu'];
    manglikdoshRahuketuPoints = json['manglikdosh_rahuketu_points'] != null ? ManglikdoshRahuketuPoints.fromJson(json['manglikdosh_rahuketu_points']) : null;
    score = json['score'];
    extendedResponse = json['extended_response'];
    botResponse = json['bot_response'];
  }
  String? ashtakootScore;
  String? dashkootScore;
  bool? rajjudosh;
  bool? vedhadosh;
  String? mangaldosh;
  MangaldoshPoints? mangaldoshPoints;
  String? pitradosh;
  PitradoshPoints? pitradoshPoints;
  String? kaalsarpdosh;
  KaalsarpPoints? kaalsarpPoints;
  String? manglikdoshSaturn;
  ManglikdoshSaturnPoints? manglikdoshSaturnPoints;
  String? manglikdoshRahuketu;
  ManglikdoshRahuketuPoints? manglikdoshRahuketuPoints;
  num? score;
  String? extendedResponse;
  String? botResponse;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ashtakoot_score'] = ashtakootScore;
    map['dashkoot_score'] = dashkootScore;
    map['rajjudosh'] = rajjudosh;
    map['vedhadosh'] = vedhadosh;
    map['mangaldosh'] = mangaldosh;
    if (mangaldoshPoints != null) {
      map['mangaldosh_points'] = mangaldoshPoints?.toJson();
    }
    map['pitradosh'] = pitradosh;
    if (pitradoshPoints != null) {
      map['pitradosh_points'] = pitradoshPoints?.toJson();
    }
    map['kaalsarpdosh'] = kaalsarpdosh;
    if (kaalsarpPoints != null) {
      map['kaalsarp_points'] = kaalsarpPoints?.toJson();
    }
    map['manglikdosh_saturn'] = manglikdoshSaturn;
    if (manglikdoshSaturnPoints != null) {
      map['manglikdosh_saturn_points'] = manglikdoshSaturnPoints?.toJson();
    }
    map['manglikdosh_rahuketu'] = manglikdoshRahuketu;
    if (manglikdoshRahuketuPoints != null) {
      map['manglikdosh_rahuketu_points'] = manglikdoshRahuketuPoints?.toJson();
    }
    map['score'] = score;
    map['extended_response'] = extendedResponse;
    map['bot_response'] = botResponse;
    return map;
  }

}

class ManglikdoshRahuketuPoints {
  ManglikdoshRahuketuPoints({
      this.boy, 
      this.girl,});

  ManglikdoshRahuketuPoints.fromJson(dynamic json) {
    boy = json['boy'];
    girl = json['girl'];
  }
  bool? boy;
  bool? girl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy'] = boy;
    map['girl'] = girl;
    return map;
  }

}

class ManglikdoshSaturnPoints {
  ManglikdoshSaturnPoints({
      this.boy, 
      this.girl,});

  ManglikdoshSaturnPoints.fromJson(dynamic json) {
    boy = json['boy'];
    girl = json['girl'];
  }
  bool? boy;
  bool? girl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy'] = boy;
    map['girl'] = girl;
    return map;
  }

}

class KaalsarpPoints {
  KaalsarpPoints({
      this.boy, 
      this.girl,});

  KaalsarpPoints.fromJson(dynamic json) {
    boy = json['boy'];
    girl = json['girl'];
  }
  bool? boy;
  bool? girl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy'] = boy;
    map['girl'] = girl;
    return map;
  }

}

class PitradoshPoints {
  PitradoshPoints({
      this.boy, 
      this.girl,});

  PitradoshPoints.fromJson(dynamic json) {
    boy = json['boy'];
    girl = json['girl'];
  }
  bool? boy;
  bool? girl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy'] = boy;
    map['girl'] = girl;
    return map;
  }

}

class MangaldoshPoints {
  MangaldoshPoints({
      this.boy, 
      this.girl,});

  MangaldoshPoints.fromJson(dynamic json) {
    boy = json['boy'];
    girl = json['girl'];
  }
  num? boy;
  num? girl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy'] = boy;
    map['girl'] = girl;
    return map;
  }

}