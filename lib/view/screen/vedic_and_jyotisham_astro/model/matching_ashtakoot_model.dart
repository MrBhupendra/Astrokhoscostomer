class MatchingAshtakootModel {
  MatchingAshtakootModel({
      this.status, 
      this.response,});

  MatchingAshtakootModel.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'] != null ? MatchingAshtakootResponse.fromJson(json['response']) : null;
  }
  num? status;
  MatchingAshtakootResponse? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    return map;
  }

}

class MatchingAshtakootResponse {
  MatchingAshtakootResponse({
      this.tara, 
      this.gana, 
      this.yoni, 
      this.bhakoot, 
      this.grahamaitri, 
      this.vasya, 
      this.nadi, 
      this.varna, 
      this.score, 
      this.botResponse, 
      this.boyPlanetaryDetails, 
      this.girlPlanetaryDetails, 
      this.boyAstroDetails, 
      this.girlAstroDetails,});

  MatchingAshtakootResponse.fromJson(dynamic json) {
    tara = json['tara'] != null ? Tara.fromJson(json['tara']) : null;
    gana = json['gana'] != null ? Gana.fromJson(json['gana']) : null;
    yoni = json['yoni'] != null ? Yoni.fromJson(json['yoni']) : null;
    bhakoot = json['bhakoot'] != null ? Bhakoot.fromJson(json['bhakoot']) : null;
    grahamaitri = json['grahamaitri'] != null ? Grahamaitri.fromJson(json['grahamaitri']) : null;
    vasya = json['vasya'] != null ? Vasya.fromJson(json['vasya']) : null;
    nadi = json['nadi'] != null ? Nadi.fromJson(json['nadi']) : null;
    varna = json['varna'] != null ? Varna.fromJson(json['varna']) : null;
    score = json['score'];
    botResponse = json['bot_response'];
    boyPlanetaryDetails = json['boy_planetary_details'] != null ? BoyPlanetaryDetails.fromJson(json['boy_planetary_details']) : null;
    girlPlanetaryDetails = json['girl_planetary_details'] != null ? GirlPlanetaryDetails.fromJson(json['girl_planetary_details']) : null;
    boyAstroDetails = json['boy_astro_details'] != null ? BoyAstroDetails.fromJson(json['boy_astro_details']) : null;
    girlAstroDetails = json['girl_astro_details'] != null ? GirlAstroDetails.fromJson(json['girl_astro_details']) : null;
  }
  Tara? tara;
  Gana? gana;
  Yoni? yoni;
  Bhakoot? bhakoot;
  Grahamaitri? grahamaitri;
  Vasya? vasya;
  Nadi? nadi;
  Varna? varna;
  num? score;
  String? botResponse;
  BoyPlanetaryDetails? boyPlanetaryDetails;
  GirlPlanetaryDetails? girlPlanetaryDetails;
  BoyAstroDetails? boyAstroDetails;
  GirlAstroDetails? girlAstroDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tara != null) {
      map['tara'] = tara?.toJson();
    }
    if (gana != null) {
      map['gana'] = gana?.toJson();
    }
    if (yoni != null) {
      map['yoni'] = yoni?.toJson();
    }
    if (bhakoot != null) {
      map['bhakoot'] = bhakoot?.toJson();
    }
    if (grahamaitri != null) {
      map['grahamaitri'] = grahamaitri?.toJson();
    }
    if (vasya != null) {
      map['vasya'] = vasya?.toJson();
    }
    if (nadi != null) {
      map['nadi'] = nadi?.toJson();
    }
    if (varna != null) {
      map['varna'] = varna?.toJson();
    }
    map['score'] = score;
    map['bot_response'] = botResponse;
    if (boyPlanetaryDetails != null) {
      map['boy_planetary_details'] = boyPlanetaryDetails?.toJson();
    }
    if (girlPlanetaryDetails != null) {
      map['girl_planetary_details'] = girlPlanetaryDetails?.toJson();
    }
    if (boyAstroDetails != null) {
      map['boy_astro_details'] = boyAstroDetails?.toJson();
    }
    if (girlAstroDetails != null) {
      map['girl_astro_details'] = girlAstroDetails?.toJson();
    }
    return map;
  }

}

class GirlAstroDetails {
  GirlAstroDetails({
      this.gana, 
      this.yoni, 
      this.vasya, 
      this.nadi, 
      this.varna, 
      this.paya, 
      this.tatva, 
      this.birthDasa, 
      this.currentDasa, 
      this.birthDasaTime, 
      this.currentDasaTime, 
      this.luckyGem, 
      this.luckyNum, 
      this.luckyColors, 
      this.luckyLetters, 
      this.luckyNameStart, 
      this.rasi, 
      this.nakshatra, 
      this.nakshatraPada, 
      this.ascendantSign,});

  GirlAstroDetails.fromJson(dynamic json) {
    gana = json['gana'];
    yoni = json['yoni'];
    vasya = json['vasya'];
    nadi = json['nadi'];
    varna = json['varna'];
    paya = json['paya'];
    tatva = json['tatva'];
    birthDasa = json['birth_dasa'];
    currentDasa = json['current_dasa'];
    birthDasaTime = json['birth_dasa_time'];
    currentDasaTime = json['current_dasa_time'];
    luckyGem = json['lucky_gem'] != null ? json['lucky_gem'].cast<String>() : [];
    luckyNum = json['lucky_num'] != null ? json['lucky_num'].cast<num>() : [];
    luckyColors = json['lucky_colors'] != null ? json['lucky_colors'].cast<String>() : [];
    luckyLetters = json['lucky_letters'] != null ? json['lucky_letters'].cast<String>() : [];
    luckyNameStart = json['lucky_name_start'] != null ? json['lucky_name_start'].cast<String>() : [];
    rasi = json['rasi'];
    nakshatra = json['nakshatra'];
    nakshatraPada = json['nakshatra_pada'];
    ascendantSign = json['ascendant_sign'];
  }
  String? gana;
  String? yoni;
  String? vasya;
  String? nadi;
  String? varna;
  String? paya;
  String? tatva;
  String? birthDasa;
  String? currentDasa;
  String? birthDasaTime;
  String? currentDasaTime;
  List<String>? luckyGem;
  List<num>? luckyNum;
  List<String>? luckyColors;
  List<String>? luckyLetters;
  List<String>? luckyNameStart;
  String? rasi;
  String? nakshatra;
  num? nakshatraPada;
  String? ascendantSign;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gana'] = gana;
    map['yoni'] = yoni;
    map['vasya'] = vasya;
    map['nadi'] = nadi;
    map['varna'] = varna;
    map['paya'] = paya;
    map['tatva'] = tatva;
    map['birth_dasa'] = birthDasa;
    map['current_dasa'] = currentDasa;
    map['birth_dasa_time'] = birthDasaTime;
    map['current_dasa_time'] = currentDasaTime;
    map['lucky_gem'] = luckyGem;
    map['lucky_num'] = luckyNum;
    map['lucky_colors'] = luckyColors;
    map['lucky_letters'] = luckyLetters;
    map['lucky_name_start'] = luckyNameStart;
    map['rasi'] = rasi;
    map['nakshatra'] = nakshatra;
    map['nakshatra_pada'] = nakshatraPada;
    map['ascendant_sign'] = ascendantSign;
    return map;
  }

}

class BoyAstroDetails {
  BoyAstroDetails({
      this.gana, 
      this.yoni, 
      this.vasya, 
      this.nadi, 
      this.varna, 
      this.paya, 
      this.tatva, 
      this.birthDasa, 
      this.currentDasa, 
      this.birthDasaTime, 
      this.currentDasaTime, 
      this.luckyGem, 
      this.luckyNum, 
      this.luckyColors, 
      this.luckyLetters, 
      this.luckyNameStart, 
      this.rasi, 
      this.nakshatra, 
      this.nakshatraPada, 
      this.ascendantSign,});

  BoyAstroDetails.fromJson(dynamic json) {
    gana = json['gana'];
    yoni = json['yoni'];
    vasya = json['vasya'];
    nadi = json['nadi'];
    varna = json['varna'];
    paya = json['paya'];
    tatva = json['tatva'];
    birthDasa = json['birth_dasa'];
    currentDasa = json['current_dasa'];
    birthDasaTime = json['birth_dasa_time'];
    currentDasaTime = json['current_dasa_time'];
    luckyGem = json['lucky_gem'] != null ? json['lucky_gem'].cast<String>() : [];
    luckyNum = json['lucky_num'] != null ? json['lucky_num'].cast<num>() : [];
    luckyColors = json['lucky_colors'] != null ? json['lucky_colors'].cast<String>() : [];
    luckyLetters = json['lucky_letters'] != null ? json['lucky_letters'].cast<String>() : [];
    luckyNameStart = json['lucky_name_start'] != null ? json['lucky_name_start'].cast<String>() : [];
    rasi = json['rasi'];
    nakshatra = json['nakshatra'];
    nakshatraPada = json['nakshatra_pada'];
    ascendantSign = json['ascendant_sign'];
  }
  String? gana;
  String? yoni;
  String? vasya;
  String? nadi;
  String? varna;
  String? paya;
  String? tatva;
  String? birthDasa;
  String? currentDasa;
  String? birthDasaTime;
  String? currentDasaTime;
  List<String>? luckyGem;
  List<num>? luckyNum;
  List<String>? luckyColors;
  List<String>? luckyLetters;
  List<String>? luckyNameStart;
  String? rasi;
  String? nakshatra;
  num? nakshatraPada;
  String? ascendantSign;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gana'] = gana;
    map['yoni'] = yoni;
    map['vasya'] = vasya;
    map['nadi'] = nadi;
    map['varna'] = varna;
    map['paya'] = paya;
    map['tatva'] = tatva;
    map['birth_dasa'] = birthDasa;
    map['current_dasa'] = currentDasa;
    map['birth_dasa_time'] = birthDasaTime;
    map['current_dasa_time'] = currentDasaTime;
    map['lucky_gem'] = luckyGem;
    map['lucky_num'] = luckyNum;
    map['lucky_colors'] = luckyColors;
    map['lucky_letters'] = luckyLetters;
    map['lucky_name_start'] = luckyNameStart;
    map['rasi'] = rasi;
    map['nakshatra'] = nakshatra;
    map['nakshatra_pada'] = nakshatraPada;
    map['ascendant_sign'] = ascendantSign;
    return map;
  }

}

class GirlPlanetaryDetails {
  GirlPlanetaryDetails({
      this.g0, 
      this.g1, 
      this.g2, 
      this.g3, 
      this.g4, 
      this.g5, 
      this.g6, 
      this.g7, 
      this.g8, 
      this.g9,});

  GirlPlanetaryDetails.fromJson(dynamic json) {
    g0 = json['g0'] != null ? G0.fromJson(json['g0']) : null;
    g1 = json['g1'] != null ? G1.fromJson(json['g1']) : null;
    g2 = json['g2'] != null ? G2.fromJson(json['g2']) : null;
    g3 = json['g3'] != null ? G3.fromJson(json['g3']) : null;
    g4 = json['g4'] != null ? G4.fromJson(json['g4']) : null;
    g5 = json['g5'] != null ? G5.fromJson(json['g5']) : null;
    g6 = json['g6'] != null ? G6.fromJson(json['g6']) : null;
    g7 = json['g7'] != null ? G7.fromJson(json['g7']) : null;
    g8 = json['g8'] != null ? G8.fromJson(json['g8']) : null;
    g9 = json['g9'] != null ? G9.fromJson(json['g9']) : null;
  }
  G0? g0;
  G1? g1;
  G2? g2;
  G3? g3;
  G4? g4;
  G5? g5;
  G6? g6;
  G7? g7;
  G8? g8;
  G9? g9;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (g0 != null) {
      map['g0'] = g0?.toJson();
    }
    if (g1 != null) {
      map['g1'] = g1?.toJson();
    }
    if (g2 != null) {
      map['g2'] = g2?.toJson();
    }
    if (g3 != null) {
      map['g3'] = g3?.toJson();
    }
    if (g4 != null) {
      map['g4'] = g4?.toJson();
    }
    if (g5 != null) {
      map['g5'] = g5?.toJson();
    }
    if (g6 != null) {
      map['g6'] = g6?.toJson();
    }
    if (g7 != null) {
      map['g7'] = g7?.toJson();
    }
    if (g8 != null) {
      map['g8'] = g8?.toJson();
    }
    if (g9 != null) {
      map['g9'] = g9?.toJson();
    }
    return map;
  }

}

class G9 {
  G9({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus, 
      this.isCombust,});

  G9.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    map['is_combust'] = isCombust;
    return map;
  }

}

class G8 {
  G8({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus, 
      this.isCombust,});

  G8.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    map['is_combust'] = isCombust;
    return map;
  }

}

class G7 {
  G7({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.speedRadiansPerDay, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus, 
      this.isCombust,});

  G7.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    speedRadiansPerDay = json['speed_radians_per_day'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  num? speedRadiansPerDay;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['speed_radians_per_day'] = speedRadiansPerDay;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    map['is_combust'] = isCombust;
    return map;
  }

}

class G6 {
  G6({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.speedRadiansPerDay, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus, 
      this.isCombust,});

  G6.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    speedRadiansPerDay = json['speed_radians_per_day'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  num? speedRadiansPerDay;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['speed_radians_per_day'] = speedRadiansPerDay;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    map['is_combust'] = isCombust;
    return map;
  }

}

class G5 {
  G5({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.speedRadiansPerDay, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus, 
      this.isCombust,});

  G5.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    speedRadiansPerDay = json['speed_radians_per_day'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  num? speedRadiansPerDay;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['speed_radians_per_day'] = speedRadiansPerDay;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    map['is_combust'] = isCombust;
    return map;
  }

}

class G4 {
  G4({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.speedRadiansPerDay, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus, 
      this.isCombust,});

  G4.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    speedRadiansPerDay = json['speed_radians_per_day'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  num? speedRadiansPerDay;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['speed_radians_per_day'] = speedRadiansPerDay;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    map['is_combust'] = isCombust;
    return map;
  }

}

class G3 {
  G3({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.speedRadiansPerDay, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus, 
      this.isCombust,});

  G3.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    speedRadiansPerDay = json['speed_radians_per_day'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  num? speedRadiansPerDay;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['speed_radians_per_day'] = speedRadiansPerDay;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    map['is_combust'] = isCombust;
    return map;
  }

}

class G2 {
  G2({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.speedRadiansPerDay, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus, 
      this.isCombust,});

  G2.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    speedRadiansPerDay = json['speed_radians_per_day'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  num? speedRadiansPerDay;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['speed_radians_per_day'] = speedRadiansPerDay;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    map['is_combust'] = isCombust;
    return map;
  }

}

class G1 {
  G1({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.speedRadiansPerDay, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus,});

  G1.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    speedRadiansPerDay = json['speed_radians_per_day'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  num? speedRadiansPerDay;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['speed_radians_per_day'] = speedRadiansPerDay;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    return map;
  }

}

class G0 {
  G0({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.lordStatus, 
      this.basicAvastha, 
      this.isCombust,});

  G0.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    lordStatus = json['lord_status'];
    basicAvastha = json['basic_avastha'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? lordStatus;
  String? basicAvastha;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['lord_status'] = lordStatus;
    map['basic_avastha'] = basicAvastha;
    map['is_combust'] = isCombust;
    return map;
  }

}

class BoyPlanetaryDetails {
  BoyPlanetaryDetails({
      this.b0, 
      this.b1, 
      this.b2, 
      this.b3, 
      this.b4, 
      this.b5, 
      this.b6, 
      this.b7, 
      this.b8, 
      this.b9,});

  BoyPlanetaryDetails.fromJson(dynamic json) {
    b0 = json['b0'] != null ? B0.fromJson(json['b0']) : null;
    b1 = json['b1'] != null ? B1.fromJson(json['b1']) : null;
    b2 = json['b2'] != null ? B2.fromJson(json['b2']) : null;
    b3 = json['b3'] != null ? B3.fromJson(json['b3']) : null;
    b4 = json['b4'] != null ? B4.fromJson(json['b4']) : null;
    b5 = json['b5'] != null ? B5.fromJson(json['b5']) : null;
    b6 = json['b6'] != null ? B6.fromJson(json['b6']) : null;
    b7 = json['b7'] != null ? B7.fromJson(json['b7']) : null;
    b8 = json['b8'] != null ? B8.fromJson(json['b8']) : null;
    b9 = json['b9'] != null ? B9.fromJson(json['b9']) : null;
  }
  B0? b0;
  B1? b1;
  B2? b2;
  B3? b3;
  B4? b4;
  B5? b5;
  B6? b6;
  B7? b7;
  B8? b8;
  B9? b9;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (b0 != null) {
      map['b0'] = b0?.toJson();
    }
    if (b1 != null) {
      map['b1'] = b1?.toJson();
    }
    if (b2 != null) {
      map['b2'] = b2?.toJson();
    }
    if (b3 != null) {
      map['b3'] = b3?.toJson();
    }
    if (b4 != null) {
      map['b4'] = b4?.toJson();
    }
    if (b5 != null) {
      map['b5'] = b5?.toJson();
    }
    if (b6 != null) {
      map['b6'] = b6?.toJson();
    }
    if (b7 != null) {
      map['b7'] = b7?.toJson();
    }
    if (b8 != null) {
      map['b8'] = b8?.toJson();
    }
    if (b9 != null) {
      map['b9'] = b9?.toJson();
    }
    return map;
  }

}

class B9 {
  B9({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus, 
      this.isCombust,});

  B9.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    map['is_combust'] = isCombust;
    return map;
  }

}

class B8 {
  B8({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus, 
      this.isCombust,});

  B8.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    map['is_combust'] = isCombust;
    return map;
  }

}

class B7 {
  B7({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.speedRadiansPerDay, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus, 
      this.isCombust,});

  B7.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    speedRadiansPerDay = json['speed_radians_per_day'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  num? speedRadiansPerDay;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['speed_radians_per_day'] = speedRadiansPerDay;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    map['is_combust'] = isCombust;
    return map;
  }

}

class B6 {
  B6({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.speedRadiansPerDay, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus, 
      this.isCombust,});

  B6.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    speedRadiansPerDay = json['speed_radians_per_day'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  num? speedRadiansPerDay;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['speed_radians_per_day'] = speedRadiansPerDay;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    map['is_combust'] = isCombust;
    return map;
  }

}

class B5 {
  B5({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.speedRadiansPerDay, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus, 
      this.isCombust,});

  B5.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    speedRadiansPerDay = json['speed_radians_per_day'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  num? speedRadiansPerDay;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['speed_radians_per_day'] = speedRadiansPerDay;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    map['is_combust'] = isCombust;
    return map;
  }

}

class B4 {
  B4({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.speedRadiansPerDay, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus, 
      this.isCombust,});

  B4.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    speedRadiansPerDay = json['speed_radians_per_day'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  num? speedRadiansPerDay;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['speed_radians_per_day'] = speedRadiansPerDay;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    map['is_combust'] = isCombust;
    return map;
  }

}

class B3 {
  B3({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.speedRadiansPerDay, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus, 
      this.isCombust,});

  B3.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    speedRadiansPerDay = json['speed_radians_per_day'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  num? speedRadiansPerDay;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['speed_radians_per_day'] = speedRadiansPerDay;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    map['is_combust'] = isCombust;
    return map;
  }

}

class B2 {
  B2({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.speedRadiansPerDay, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus, 
      this.isCombust,});

  B2.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    speedRadiansPerDay = json['speed_radians_per_day'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  num? speedRadiansPerDay;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['speed_radians_per_day'] = speedRadiansPerDay;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    map['is_combust'] = isCombust;
    return map;
  }

}

class B1 {
  B1({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.speedRadiansPerDay, 
      this.retro, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.basicAvastha, 
      this.lordStatus,});

  B1.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    speedRadiansPerDay = json['speed_radians_per_day'];
    retro = json['retro'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    basicAvastha = json['basic_avastha'];
    lordStatus = json['lord_status'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  num? speedRadiansPerDay;
  bool? retro;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? basicAvastha;
  String? lordStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['speed_radians_per_day'] = speedRadiansPerDay;
    map['retro'] = retro;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['basic_avastha'] = basicAvastha;
    map['lord_status'] = lordStatus;
    return map;
  }

}

class B0 {
  B0({
      this.name, 
      this.fullName, 
      this.localDegree, 
      this.globalDegree, 
      this.rasiNo, 
      this.zodiac, 
      this.house, 
      this.nakshatra, 
      this.nakshatraLord, 
      this.nakshatraPada, 
      this.nakshatraNo, 
      this.zodiacLord, 
      this.isPlanetSet, 
      this.lordStatus, 
      this.basicAvastha, 
      this.isCombust,});

  B0.fromJson(dynamic json) {
    name = json['name'];
    fullName = json['full_name'];
    localDegree = json['local_degree'];
    globalDegree = json['global_degree'];
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    house = json['house'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    nakshatraNo = json['nakshatra_no'];
    zodiacLord = json['zodiac_lord'];
    isPlanetSet = json['is_planet_set'];
    lordStatus = json['lord_status'];
    basicAvastha = json['basic_avastha'];
    isCombust = json['is_combust'];
  }
  String? name;
  String? fullName;
  num? localDegree;
  num? globalDegree;
  num? rasiNo;
  String? zodiac;
  num? house;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  num? nakshatraNo;
  String? zodiacLord;
  bool? isPlanetSet;
  String? lordStatus;
  String? basicAvastha;
  bool? isCombust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['full_name'] = fullName;
    map['local_degree'] = localDegree;
    map['global_degree'] = globalDegree;
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['house'] = house;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['nakshatra_no'] = nakshatraNo;
    map['zodiac_lord'] = zodiacLord;
    map['is_planet_set'] = isPlanetSet;
    map['lord_status'] = lordStatus;
    map['basic_avastha'] = basicAvastha;
    map['is_combust'] = isCombust;
    return map;
  }

}

class Varna {
  Varna({
      this.boyVarna, 
      this.girlVarna, 
      this.varna, 
      this.description, 
      this.name, 
      this.fullScore,});

  Varna.fromJson(dynamic json) {
    boyVarna = json['boy_varna'];
    girlVarna = json['girl_varna'];
    varna = json['varna'];
    description = json['description'];
    name = json['name'];
    fullScore = json['full_score'];
  }
  String? boyVarna;
  String? girlVarna;
  num? varna;
  String? description;
  String? name;
  num? fullScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy_varna'] = boyVarna;
    map['girl_varna'] = girlVarna;
    map['varna'] = varna;
    map['description'] = description;
    map['name'] = name;
    map['full_score'] = fullScore;
    return map;
  }

}

class Nadi {
  Nadi({
      this.boyNadi, 
      this.girlNadi, 
      this.nadi, 
      this.description, 
      this.name, 
      this.fullScore,});

  Nadi.fromJson(dynamic json) {
    boyNadi = json['boy_nadi'];
    girlNadi = json['girl_nadi'];
    nadi = json['nadi'];
    description = json['description'];
    name = json['name'];
    fullScore = json['full_score'];
  }
  String? boyNadi;
  String? girlNadi;
  num? nadi;
  String? description;
  String? name;
  num? fullScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy_nadi'] = boyNadi;
    map['girl_nadi'] = girlNadi;
    map['nadi'] = nadi;
    map['description'] = description;
    map['name'] = name;
    map['full_score'] = fullScore;
    return map;
  }

}

class Vasya {
  Vasya({
      this.boyVasya, 
      this.girlVasya, 
      this.vasya, 
      this.description, 
      this.name, 
      this.fullScore,});

  Vasya.fromJson(dynamic json) {
    boyVasya = json['boy_vasya'];
    girlVasya = json['girl_vasya'];
    vasya = json['vasya'];
    description = json['description'];
    name = json['name'];
    fullScore = json['full_score'];
  }
  String? boyVasya;
  String? girlVasya;
  num? vasya;
  String? description;
  String? name;
  num? fullScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy_vasya'] = boyVasya;
    map['girl_vasya'] = girlVasya;
    map['vasya'] = vasya;
    map['description'] = description;
    map['name'] = name;
    map['full_score'] = fullScore;
    return map;
  }

}

class Grahamaitri {
  Grahamaitri({
      this.boyLord, 
      this.girlLord, 
      this.grahamaitri, 
      this.description, 
      this.name, 
      this.fullScore,});

  Grahamaitri.fromJson(dynamic json) {
    boyLord = json['boy_lord'];
    girlLord = json['girl_lord'];
    grahamaitri = json['grahamaitri'];
    description = json['description'];
    name = json['name'];
    fullScore = json['full_score'];
  }
  String? boyLord;
  String? girlLord;
  num? grahamaitri;
  String? description;
  String? name;
  num? fullScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy_lord'] = boyLord;
    map['girl_lord'] = girlLord;
    map['grahamaitri'] = grahamaitri;
    map['description'] = description;
    map['name'] = name;
    map['full_score'] = fullScore;
    return map;
  }

}

class Bhakoot {
  Bhakoot({
      this.boyRasi, 
      this.girlRasi, 
      this.boyRasiName, 
      this.girlRasiName, 
      this.bhakoot, 
      this.description, 
      this.name, 
      this.fullScore,});

  Bhakoot.fromJson(dynamic json) {
    boyRasi = json['boy_rasi'];
    girlRasi = json['girl_rasi'];
    boyRasiName = json['boy_rasi_name'];
    girlRasiName = json['girl_rasi_name'];
    bhakoot = json['bhakoot'];
    description = json['description'];
    name = json['name'];
    fullScore = json['full_score'];
  }
  num? boyRasi;
  num? girlRasi;
  String? boyRasiName;
  String? girlRasiName;
  num? bhakoot;
  String? description;
  String? name;
  num? fullScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy_rasi'] = boyRasi;
    map['girl_rasi'] = girlRasi;
    map['boy_rasi_name'] = boyRasiName;
    map['girl_rasi_name'] = girlRasiName;
    map['bhakoot'] = bhakoot;
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

class Tara {
  Tara({
      this.boyTara, 
      this.girlTara, 
      this.tara, 
      this.description, 
      this.name, 
      this.fullScore,});

  Tara.fromJson(dynamic json) {
    boyTara = json['boy_tara'];
    girlTara = json['girl_tara'];
    tara = json['tara'];
    description = json['description'];
    name = json['name'];
    fullScore = json['full_score'];
  }
  String? boyTara;
  String? girlTara;
  num? tara;
  String? description;
  String? name;
  num? fullScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy_tara'] = boyTara;
    map['girl_tara'] = girlTara;
    map['tara'] = tara;
    map['description'] = description;
    map['name'] = name;
    map['full_score'] = fullScore;
    return map;
  }

}