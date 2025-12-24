class MatchingNakshatraModel {
  MatchingNakshatraModel({
    this.status,
    this.response,});

  MatchingNakshatraModel.fromJson(dynamic json) {
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
    this.dina,
    this.gana,
    this.mahendra,
    this.sthree,
    this.yoni,
    this.rasi,
    this.rasiathi,
    this.vasya,
    this.rajju,
    this.vedha,
    this.score,
    this.botResponse,});

  Response.fromJson(dynamic json) {
    dina = json['dina'] != null ? Dina.fromJson(json['dina']) : null;
    gana = json['gana'] != null ? Gana.fromJson(json['gana']) : null;
    mahendra = json['mahendra'] != null ? Mahendra.fromJson(json['mahendra']) : null;
    sthree = json['sthree'] != null ? Sthree.fromJson(json['sthree']) : null;
    yoni = json['yoni'] != null ? Yoni.fromJson(json['yoni']) : null;
    rasi = json['rasi'] != null ? Rasi.fromJson(json['rasi']) : null;
    rasiathi = json['rasiathi'] != null ? Rasiathi.fromJson(json['rasiathi']) : null;
    vasya = json['vasya'] != null ? Vasya.fromJson(json['vasya']) : null;
    rajju = json['rajju'] != null ? Rajju.fromJson(json['rajju']) : null;
    vedha = json['vedha'] != null ? Vedha.fromJson(json['vedha']) : null;
    score = json['score'];
    botResponse = json['bot_response'];
  }
  Dina? dina;
  Gana? gana;
  Mahendra? mahendra;
  Sthree? sthree;
  Yoni? yoni;
  Rasi? rasi;
  Rasiathi? rasiathi;
  Vasya? vasya;
  Rajju? rajju;
  Vedha? vedha;
  num? score;
  String? botResponse;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dina != null) {
      map['dina'] = dina?.toJson();
    }
    if (gana != null) {
      map['gana'] = gana?.toJson();
    }
    if (mahendra != null) {
      map['mahendra'] = mahendra?.toJson();
    }
    if (sthree != null) {
      map['sthree'] = sthree?.toJson();
    }
    if (yoni != null) {
      map['yoni'] = yoni?.toJson();
    }
    if (rasi != null) {
      map['rasi'] = rasi?.toJson();
    }
    if (rasiathi != null) {
      map['rasiathi'] = rasiathi?.toJson();
    }
    if (vasya != null) {
      map['vasya'] = vasya?.toJson();
    }
    if (rajju != null) {
      map['rajju'] = rajju?.toJson();
    }
    if (vedha != null) {
      map['vedha'] = vedha?.toJson();
    }
    map['score'] = score;
    map['bot_response'] = botResponse;
    return map;
  }

}

class Vedha {
  Vedha({
    this.boyStar,
    this.girlStar,
    this.vedha,
    this.description,
    this.name,
    this.fullScore,});

  Vedha.fromJson(dynamic json) {
    boyStar = json['boy_star'];
    girlStar = json['girl_star'];
    vedha = json['vedha'];
    description = json['description'];
    name = json['name'];
    fullScore = json['full_score'];
  }
  String? boyStar;
  String? girlStar;
  num? vedha;
  String? description;
  String? name;
  num? fullScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy_star'] = boyStar;
    map['girl_star'] = girlStar;
    map['vedha'] = vedha;
    map['description'] = description;
    map['name'] = name;
    map['full_score'] = fullScore;
    return map;
  }

}

class Rajju {
  Rajju({
    this.boyRajju,
    this.girlRajju,
    this.rajju,
    this.description,
    this.name,
    this.fullScore,});

  Rajju.fromJson(dynamic json) {
    boyRajju = json['boy_rajju'];
    girlRajju = json['girl_rajju'];
    rajju = json['rajju'];
    description = json['description'];
    name = json['name'];
    fullScore = json['full_score'];
  }
  String? boyRajju;
  String? girlRajju;
  num? rajju;
  String? description;
  String? name;
  num? fullScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy_rajju'] = boyRajju;
    map['girl_rajju'] = girlRajju;
    map['rajju'] = rajju;
    map['description'] = description;
    map['name'] = name;
    map['full_score'] = fullScore;
    return map;
  }

}

class Vasya {
  Vasya({
    this.boyRasi,
    this.girlRasi,
    this.vasya,
    this.description,
    this.name,
    this.fullScore,});

  Vasya.fromJson(dynamic json) {
    boyRasi = json['boy_rasi'];
    girlRasi = json['girl_rasi'];
    vasya = json['vasya'];
    description = json['description'];
    name = json['name'];
    fullScore = json['full_score'];
  }
  String? boyRasi;
  String? girlRasi;
  num? vasya;
  String? description;
  String? name;
  num? fullScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy_rasi'] = boyRasi;
    map['girl_rasi'] = girlRasi;
    map['vasya'] = vasya;
    map['description'] = description;
    map['name'] = name;
    map['full_score'] = fullScore;
    return map;
  }

}

class Rasiathi {
  Rasiathi({
    this.boyLord,
    this.girlLord,
    this.rasiathi,
    this.description,
    this.name,
    this.fullScore,});

  Rasiathi.fromJson(dynamic json) {
    boyLord = json['boy_lord'];
    girlLord = json['girl_lord'];
    rasiathi = json['rasiathi'];
    description = json['description'];
    name = json['name'];
    fullScore = json['full_score'];
  }
  String? boyLord;
  String? girlLord;
  num? rasiathi;
  String? description;
  String? name;
  num? fullScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy_lord'] = boyLord;
    map['girl_lord'] = girlLord;
    map['rasiathi'] = rasiathi;
    map['description'] = description;
    map['name'] = name;
    map['full_score'] = fullScore;
    return map;
  }

}

class Rasi {
  Rasi({
    this.boyRasi,
    this.girlRasi,
    this.rasi,
    this.description,
    this.name,
    this.fullScore,});

  Rasi.fromJson(dynamic json) {
    boyRasi = json['boy_rasi'];
    girlRasi = json['girl_rasi'];
    rasi = json['rasi'];
    description = json['description'];
    name = json['name'];
    fullScore = json['full_score'];
  }
  String? boyRasi;
  String? girlRasi;
  num? rasi;
  String? description;
  String? name;
  num? fullScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy_rasi'] = boyRasi;
    map['girl_rasi'] = girlRasi;
    map['rasi'] = rasi;
    map['description'] = description;
    map['name'] = name;
    map['full_score'] = fullScore;
    return map;
  }

}

class Yoni {
  Yoni({
    this.boyYoni,
    this.girlYoni,
    this.yoni,
    this.description,
    this.name,
    this.fullScore,});

  Yoni.fromJson(dynamic json) {
    boyYoni = json['boy_yoni'];
    girlYoni = json['girl_yoni'];
    yoni = json['yoni'];
    description = json['description'];
    name = json['name'];
    fullScore = json['full_score'];
  }
  String? boyYoni;
  String? girlYoni;
  num? yoni;
  String? description;
  String? name;
  num? fullScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy_yoni'] = boyYoni;
    map['girl_yoni'] = girlYoni;
    map['yoni'] = yoni;
    map['description'] = description;
    map['name'] = name;
    map['full_score'] = fullScore;
    return map;
  }

}

class Sthree {
  Sthree({
    this.boyStar,
    this.girlStar,
    this.sthree,
    this.description,
    this.name,
    this.fullScore,});

  Sthree.fromJson(dynamic json) {
    boyStar = json['boy_star'];
    girlStar = json['girl_star'];
    sthree = json['sthree'];
    description = json['description'];
    name = json['name'];
    fullScore = json['full_score'];
  }
  String? boyStar;
  String? girlStar;
  num? sthree;
  String? description;
  String? name;
  num? fullScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy_star'] = boyStar;
    map['girl_star'] = girlStar;
    map['sthree'] = sthree;
    map['description'] = description;
    map['name'] = name;
    map['full_score'] = fullScore;
    return map;
  }

}

class Mahendra {
  Mahendra({
    this.boyStar,
    this.girlStar,
    this.mahendra,
    this.description,
    this.name,
    this.fullScore,});

  Mahendra.fromJson(dynamic json) {
    boyStar = json['boy_star'];
    girlStar = json['girl_star'];
    mahendra = json['mahendra'];
    description = json['description'];
    name = json['name'];
    fullScore = json['full_score'];
  }
  String? boyStar;
  String? girlStar;
  num? mahendra;
  String? description;
  String? name;
  num? fullScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy_star'] = boyStar;
    map['girl_star'] = girlStar;
    map['mahendra'] = mahendra;
    map['description'] = description;
    map['name'] = name;
    map['full_score'] = fullScore;
    return map;
  }

}

class Gana {
  Gana({
    this.boyGana,
    this.girlGana,
    this.gana,
    this.description,
    this.name,
    this.fullScore,});

  Gana.fromJson(dynamic json) {
    boyGana = json['boy_gana'];
    girlGana = json['girl_gana'];
    gana = json['gana'];
    description = json['description'];
    name = json['name'];
    fullScore = json['full_score'];
  }
  String? boyGana;
  String? girlGana;
  num? gana;
  String? description;
  String? name;
  num? fullScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy_gana'] = boyGana;
    map['girl_gana'] = girlGana;
    map['gana'] = gana;
    map['description'] = description;
    map['name'] = name;
    map['full_score'] = fullScore;
    return map;
  }

}

class Dina {
  Dina({
    this.boyStar,
    this.girlStar,
    this.dina,
    this.description,
    this.name,
    this.fullScore,});

  Dina.fromJson(dynamic json) {
    boyStar = json['boy_star'];
    girlStar = json['girl_star'];
    dina = json['dina'];
    description = json['description'];
    name = json['name'];
    fullScore = json['full_score'];
  }
  String? boyStar;
  String? girlStar;
  num? dina;
  String? description;
  String? name;
  num? fullScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy_star'] = boyStar;
    map['girl_star'] = girlStar;
    map['dina'] = dina;
    map['description'] = description;
    map['name'] = name;
    map['full_score'] = fullScore;
    return map;
  }

}