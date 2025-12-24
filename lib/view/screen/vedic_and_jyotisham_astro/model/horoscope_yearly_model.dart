class HoroscopeYearlyModel {
  HoroscopeYearlyModel({
    this.status,
    this.response,});

  HoroscopeYearlyModel.fromJson(dynamic json) {
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
    this.phase1,
    this.phase2,
    this.phase3,
    this.phase4,});

  Response.fromJson(dynamic json) {
    phase1 = json['phase_1'] != null ? Phase1.fromJson(json['phase_1']) : null;
    phase2 = json['phase_2'] != null ? Phase2.fromJson(json['phase_2']) : null;
    phase3 = json['phase_3'] != null ? Phase3.fromJson(json['phase_3']) : null;
    phase4 = json['phase_4'] != null ? Phase4.fromJson(json['phase_4']) : null;
  }
  Phase1? phase1;
  Phase2? phase2;
  Phase3? phase3;
  Phase4? phase4;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (phase1 != null) {
      map['phase_1'] = phase1?.toJson();
    }
    if (phase2 != null) {
      map['phase_2'] = phase2?.toJson();
    }
    if (phase3 != null) {
      map['phase_3'] = phase3?.toJson();
    }
    if (phase4 != null) {
      map['phase_4'] = phase4?.toJson();
    }
    return map;
  }

}

class Phase4 {
  Phase4({
    this.score,
    this.period,
    this.prediction,
    this.health,
    this.career,
    this.relationship,
    this.travel,
    this.family,
    this.friends,
    this.finances,
    this.status,
    this.education,});

  Phase4.fromJson(dynamic json) {
    score = json['score'];
    period = json['period'];
    prediction = json['prediction'];
    health = json['health'] != null ? Health.fromJson(json['health']) : null;
    career = json['career'] != null ? Career.fromJson(json['career']) : null;
    relationship = json['relationship'] != null ? Relationship.fromJson(json['relationship']) : null;
    travel = json['travel'] != null ? Travel.fromJson(json['travel']) : null;
    family = json['family'] != null ? Family.fromJson(json['family']) : null;
    friends = json['friends'] != null ? Friends.fromJson(json['friends']) : null;
    finances = json['finances'] != null ? Finances.fromJson(json['finances']) : null;
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    education = json['education'] != null ? Education_3.fromJson(json['education']) : null;
  }
  String? score;
  String? period;
  String? prediction;
  Health? health;
  Career? career;
  Relationship? relationship;
  Travel? travel;
  Family? family;
  Friends? friends;
  Finances? finances;
  Status? status;
  Education_3? education;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['period'] = period;
    map['prediction'] = prediction;
    if (health != null) {
      map['health'] = health?.toJson();
    }
    if (career != null) {
      map['career'] = career?.toJson();
    }
    if (relationship != null) {
      map['relationship'] = relationship?.toJson();
    }
    if (travel != null) {
      map['travel'] = travel?.toJson();
    }
    if (family != null) {
      map['family'] = family?.toJson();
    }
    if (friends != null) {
      map['friends'] = friends?.toJson();
    }
    if (finances != null) {
      map['finances'] = finances?.toJson();
    }
    if (status != null) {
      map['status'] = status?.toJson();
    }
    if (education != null) {
      map['education'] = education?.toJson();
    }
    return map;
  }

}

class Education {
  Education({
    this.score,
    this.prediction,});

  Education.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Status {
  Status({
    this.score,
    this.prediction,});

  Status.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Finances {
  Finances({
    this.score,
    this.prediction,});

  Finances.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Friends {
  Friends({
    this.score,
    this.prediction,});

  Friends.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Family {
  Family({
    this.score,
    this.prediction,});

  Family.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Travel {
  Travel({
    this.score,
    this.prediction,});

  Travel.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Relationship {
  Relationship({
    this.score,
    this.prediction,});

  Relationship.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Career {
  Career({
    this.score,
    this.prediction,});

  Career.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Health {
  Health({
    this.score,
    this.prediction,});

  Health.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}




class Phase3 {
  Phase3({
    this.score,
    this.period,
    this.prediction,
    this.health,
    this.career,
    this.relationship,
    this.travel,
    this.family,
    this.friends,
    this.finances,
    this.status,
    this.education,});

  Phase3.fromJson(dynamic json) {
    score = json['score'];
    period = json['period'];
    prediction = json['prediction'];
    health = json['health'] != null ? Health.fromJson(json['health']) : null;
    career = json['career'] != null ? Career.fromJson(json['career']) : null;
    relationship = json['relationship'] != null ? Relationship.fromJson(json['relationship']) : null;
    travel = json['travel'] != null ? Travel.fromJson(json['travel']) : null;
    family = json['family'] != null ? Family.fromJson(json['family']) : null;
    friends = json['friends'] != null ? Friends.fromJson(json['friends']) : null;
    finances = json['finances'] != null ? Finances.fromJson(json['finances']) : null;
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    education = json['education'] != null ? Education_3.fromJson(json['education']) : null;
  }
  String? score;
  String? period;
  String? prediction;
  Health? health;
  Career? career;
  Relationship? relationship;
  Travel? travel;
  Family? family;
  Friends? friends;
  Finances? finances;
  Status? status;
  Education_3? education;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['period'] = period;
    map['prediction'] = prediction;
    if (health != null) {
      map['health'] = health?.toJson();
    }
    if (career != null) {
      map['career'] = career?.toJson();
    }
    if (relationship != null) {
      map['relationship'] = relationship?.toJson();
    }
    if (travel != null) {
      map['travel'] = travel?.toJson();
    }
    if (family != null) {
      map['family'] = family?.toJson();
    }
    if (friends != null) {
      map['friends'] = friends?.toJson();
    }
    if (finances != null) {
      map['finances'] = finances?.toJson();
    }
    if (status != null) {
      map['status'] = status?.toJson();
    }
    if (education != null) {
      map['education'] = education?.toJson();
    }
    return map;
  }

}

class Education_3 {
  Education_3({
    this.score,
    this.prediction,});

  Education_3.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Status_3 {
  Status_3({
    this.score,
    this.prediction,});

  Status_3.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Finances_3 {
  Finances_3({
    this.score,
    this.prediction,});

  Finances_3.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Friends_3 {
  Friends_3({
    this.score,
    this.prediction,});

  Friends_3.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Family_3 {
  Family_3({
    this.score,
    this.prediction,});

  Family_3.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Travel_3 {
  Travel_3({
    this.score,
    this.prediction,});

  Travel_3.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Relationship_3 {
  Relationship_3({
    this.score,
    this.prediction,});

  Relationship_3.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Career_3 {
  Career_3({
    this.score,
    this.prediction,});

  Career_3.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Health_3 {
  Health_3({
    this.score,
    this.prediction,});

  Health_3.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}





class Phase2 {
  Phase2({
    this.score,
    this.period,
    this.prediction,
    this.health,
    this.career,
    this.relationship,
    this.travel,
    this.family,
    this.friends,
    this.finances,
    this.status,
    this.education,});

  Phase2.fromJson(dynamic json) {
    score = json['score'];
    period = json['period'];
    prediction = json['prediction'];
    health = json['health'] != null ? Health.fromJson(json['health']) : null;
    career = json['career'] != null ? Career.fromJson(json['career']) : null;
    relationship = json['relationship'] != null ? Relationship.fromJson(json['relationship']) : null;
    travel = json['travel'] != null ? Travel.fromJson(json['travel']) : null;
    family = json['family'] != null ? Family.fromJson(json['family']) : null;
    friends = json['friends'] != null ? Friends.fromJson(json['friends']) : null;
    finances = json['finances'] != null ? Finances.fromJson(json['finances']) : null;
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    education = json['education'] != null ? Education_3.fromJson(json['education']) : null;
  }
  String? score;
  String? period;
  String? prediction;
  Health? health;
  Career? career;
  Relationship? relationship;
  Travel? travel;
  Family? family;
  Friends? friends;
  Finances? finances;
  Status? status;
  Education_3? education;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['period'] = period;
    map['prediction'] = prediction;
    if (health != null) {
      map['health'] = health?.toJson();
    }
    if (career != null) {
      map['career'] = career?.toJson();
    }
    if (relationship != null) {
      map['relationship'] = relationship?.toJson();
    }
    if (travel != null) {
      map['travel'] = travel?.toJson();
    }
    if (family != null) {
      map['family'] = family?.toJson();
    }
    if (friends != null) {
      map['friends'] = friends?.toJson();
    }
    if (finances != null) {
      map['finances'] = finances?.toJson();
    }
    if (status != null) {
      map['status'] = status?.toJson();
    }
    if (education != null) {
      map['education'] = education?.toJson();
    }
    return map;
  }

}

class Education_2 {
  Education_2({
    this.score,
    this.prediction,});

  Education_2.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Status_2 {
  Status_2({
    this.score,
    this.prediction,});

  Status_2.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Finances_2 {
  Finances_2({
    this.score,
    this.prediction,});

  Finances_2.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Friends_2 {
  Friends_2({
    this.score,
    this.prediction,});

  Friends_2.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Family_2 {
  Family_2({
    this.score,
    this.prediction,});

  Family_2.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Travel_2 {
  Travel_2({
    this.score,
    this.prediction,});

  Travel_2.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Relationship_2 {
  Relationship_2({
    this.score,
    this.prediction,});

  Relationship_2.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Career_2 {
  Career_2({
    this.score,
    this.prediction,});

  Career_2.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Health_2 {
  Health_2({
    this.score,
    this.prediction,});

  Health_2.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}





class Phase1 {
  Phase1({
    this.score,
    this.period,
    this.prediction,
    this.health,
    this.career,
    this.relationship,
    this.travel,
    this.family,
    this.friends,
    this.finances,
    this.status,
    this.education,});

  Phase1.fromJson(dynamic json) {
    score = json['score'];
    period = json['period'];
    prediction = json['prediction'];
    health = json['health'] != null ? Health.fromJson(json['health']) : null;
    career = json['career'] != null ? Career.fromJson(json['career']) : null;
    relationship = json['relationship'] != null ? Relationship.fromJson(json['relationship']) : null;
    travel = json['travel'] != null ? Travel.fromJson(json['travel']) : null;
    family = json['family'] != null ? Family.fromJson(json['family']) : null;
    friends = json['friends'] != null ? Friends.fromJson(json['friends']) : null;
    finances = json['finances'] != null ? Finances.fromJson(json['finances']) : null;
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    education = json['education'] != null ? Education_3.fromJson(json['education']) : null;
  }
  String? score;
  String? period;
  String? prediction;
  Health? health;
  Career? career;
  Relationship? relationship;
  Travel? travel;
  Family? family;
  Friends? friends;
  Finances? finances;
  Status? status;
  Education_3? education;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['period'] = period;
    map['prediction'] = prediction;
    if (health != null) {
      map['health'] = health?.toJson();
    }
    if (career != null) {
      map['career'] = career?.toJson();
    }
    if (relationship != null) {
      map['relationship'] = relationship?.toJson();
    }
    if (travel != null) {
      map['travel'] = travel?.toJson();
    }
    if (family != null) {
      map['family'] = family?.toJson();
    }
    if (friends != null) {
      map['friends'] = friends?.toJson();
    }
    if (finances != null) {
      map['finances'] = finances?.toJson();
    }
    if (status != null) {
      map['status'] = status?.toJson();
    }
    if (education != null) {
      map['education'] = education?.toJson();
    }
    return map;
  }

}

class Education_1 {
  Education_1({
    this.score,
    this.prediction,});

  Education_1.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Status_1 {
  Status_1({
    this.score,
    this.prediction,});

  Status_1.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Finances_1 {
  Finances_1({
    this.score,
    this.prediction,});

  Finances_1.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Friends_1 {
  Friends_1({
    this.score,
    this.prediction,});

  Friends_1.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Family_1 {
  Family_1({
    this.score,
    this.prediction,});

  Family_1.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Travel_1 {
  Travel_1({
    this.score,
    this.prediction,});

  Travel_1.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Relationship_1 {
  Relationship_1({
    this.score,
    this.prediction,});

  Relationship_1.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Career_1 {
  Career_1({
    this.score,
    this.prediction,});

  Career_1.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}

class Health_1 {
  Health_1({
    this.score,
    this.prediction,});

  Health_1.fromJson(dynamic json) {
    score = json['score'];
    prediction = json['prediction'];
  }
  String? score;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['prediction'] = prediction;
    return map;
  }

}