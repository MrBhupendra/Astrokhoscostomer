class KundliPlanetsModel {
  KundliPlanetsModel({
    this.status,
    this.response,});

  KundliPlanetsModel.fromJson(dynamic json) {
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
    this.p0,
    this.p1,
    this.p2,
    this.p3,
    this.p4,
    this.p5,
    this.p6,
    this.p7,
    this.p8,
    this.p9,
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
    this.panchang,
    this.ghatkaChakra,});

  Response.fromJson(dynamic json) {
    p0 = json['0'] != null ? P0.fromJson(json['0']) : null;
    p1 = json['1'] != null ? P1.fromJson(json['1']) : null;
    p2 = json['2'] != null ? P2.fromJson(json['2']) : null;
    p3 = json['3'] != null ? P3.fromJson(json['3']) : null;
    p4 = json['4'] != null ? P4.fromJson(json['4']) : null;
    p5 = json['5'] != null ? P5.fromJson(json['5']) : null;
    p6 = json['6'] != null ? P6.fromJson(json['6']) : null;
    p7 = json['7'] != null ? P7.fromJson(json['7']) : null;
    p8 = json['8'] != null ? P8.fromJson(json['8']) : null;
    p9 = json['9'] != null ? P9.fromJson(json['9']) : null;
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
    panchang = json['panchang'] != null ? Panchang.fromJson(json['panchang']) : null;
    ghatkaChakra = json['ghatka_chakra'] != null ? GhatkaChakra.fromJson(json['ghatka_chakra']) : null;
  }
  P0? p0;
  P1? p1;
  P2? p2;
  P3? p3;
  P4? p4;
  P5? p5;
  P6? p6;
  P7? p7;
  P8? p8;
  P9? p9;
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
  Panchang? panchang;
  GhatkaChakra? ghatkaChakra;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (p0 != null) {
      map['0'] = p0?.toJson();
    }
    if (p1 != null) {
      map['1'] = p1?.toJson();
    }
    if (p2 != null) {
      map['2'] = p2?.toJson();
    }
    if (p3 != null) {
      map['3'] = p3?.toJson();
    }
    if (p4 != null) {
      map['4'] = p4?.toJson();
    }
    if (p5 != null) {
      map['5'] = p5?.toJson();
    }
    if (p6 != null) {
      map['6'] = p6?.toJson();
    }
    if (p7 != null) {
      map['7'] = p7?.toJson();
    }
    if (p8 != null) {
      map['8'] = p8?.toJson();
    }
    if (p9 != null) {
      map['9'] = p9?.toJson();
    }
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
    if (panchang != null) {
      map['panchang'] = panchang?.toJson();
    }
    if (ghatkaChakra != null) {
      map['ghatka_chakra'] = ghatkaChakra?.toJson();
    }
    return map;
  }

}

class GhatkaChakra {
  GhatkaChakra({
    this.rasi,
    this.tithi,
    this.day,
    this.nakshatra,
    this.tatva,
    this.lord,
    this.sameSexLagna,
    this.oppositeSexLagna,});

  GhatkaChakra.fromJson(dynamic json) {
    rasi = json['rasi'];
    tithi = json['tithi'] != null ? json['tithi'].cast<String>() : [];
    day = json['day'];
    nakshatra = json['nakshatra'];
    tatva = json['tatva'];
    lord = json['lord'];
    sameSexLagna = json['same_sex_lagna'];
    oppositeSexLagna = json['opposite_sex_lagna'];
  }
  String? rasi;
  List<String>? tithi;
  String? day;
  String? nakshatra;
  String? tatva;
  String? lord;
  String? sameSexLagna;
  String? oppositeSexLagna;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rasi'] = rasi;
    map['tithi'] = tithi;
    map['day'] = day;
    map['nakshatra'] = nakshatra;
    map['tatva'] = tatva;
    map['lord'] = lord;
    map['same_sex_lagna'] = sameSexLagna;
    map['opposite_sex_lagna'] = oppositeSexLagna;
    return map;
  }

}

class Panchang {
  Panchang({
    this.ayanamsa,
    this.ayanamsaName,
    this.dayOfBirth,
    this.dayLord,
    this.horaLord,
    this.sunriseAtBirth,
    this.sunsetAtBirth,
    this.karana,
    this.yoga,
    this.tithi,});

  Panchang.fromJson(dynamic json) {
    ayanamsa = json['ayanamsa'];
    ayanamsaName = json['ayanamsa_name'];
    dayOfBirth = json['day_of_birth'];
    dayLord = json['day_lord'];
    horaLord = json['hora_lord'];
    sunriseAtBirth = json['sunrise_at_birth'];
    sunsetAtBirth = json['sunset_at_birth'];
    karana = json['karana'];
    yoga = json['yoga'];
    tithi = json['tithi'];
  }
  num? ayanamsa;
  String? ayanamsaName;
  String? dayOfBirth;
  String? dayLord;
  String? horaLord;
  String? sunriseAtBirth;
  String? sunsetAtBirth;
  String? karana;
  String? yoga;
  String? tithi;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ayanamsa'] = ayanamsa;
    map['ayanamsa_name'] = ayanamsaName;
    map['day_of_birth'] = dayOfBirth;
    map['day_lord'] = dayLord;
    map['hora_lord'] = horaLord;
    map['sunrise_at_birth'] = sunriseAtBirth;
    map['sunset_at_birth'] = sunsetAtBirth;
    map['karana'] = karana;
    map['yoga'] = yoga;
    map['tithi'] = tithi;
    return map;
  }

}

class P9 {
  P9({
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

  P9.fromJson(dynamic json) {
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

class P8 {
  P8({
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

  P8.fromJson(dynamic json) {
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

class P7 {
  P7({
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

  P7.fromJson(dynamic json) {
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

class P6 {
  P6({
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

  P6.fromJson(dynamic json) {
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

class P5 {
  P5({
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

  P5.fromJson(dynamic json) {
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

class P4 {
  P4({
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

  P4.fromJson(dynamic json) {
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

class P3 {
  P3({
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

  P3.fromJson(dynamic json) {
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

class P2 {
  P2({
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

  P2.fromJson(dynamic json) {
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

class P1 {
  P1({
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

  P1.fromJson(dynamic json) {
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

class P0 {
  P0({
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

  P0.fromJson(dynamic json) {
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