class PanchangTestModel {
  PanchangTestModel({
      this.status, 
      this.response, 
      this.callsRemaining,});

  PanchangTestModel.fromJson(dynamic json) {
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
      this.day, 
      this.tithi, 
      this.nakshatra, 
      this.karana, 
      this.yoga, 
      this.ayanamsa, 
      this.rasi, 
      this.advancedDetails, 
      this.rahukaal, 
      this.gulika, 
      this.yamakanta, 
      this.date,});

  Response.fromJson(dynamic json) {
    day = json['day'] != null ? Day.fromJson(json['day']) : null;
    tithi = json['tithi'] != null ? Tithi.fromJson(json['tithi']) : null;
    nakshatra = json['nakshatra'] != null ? Nakshatra.fromJson(json['nakshatra']) : null;
    karana = json['karana'] != null ? Karana.fromJson(json['karana']) : null;
    yoga = json['yoga'] != null ? Yoga.fromJson(json['yoga']) : null;
    ayanamsa = json['ayanamsa'] != null ? Ayanamsa.fromJson(json['ayanamsa']) : null;
    rasi = json['rasi'] != null ? Rasi.fromJson(json['rasi']) : null;
    advancedDetails = json['advanced_details'] != null ? AdvancedDetails.fromJson(json['advanced_details']) : null;
    rahukaal = json['rahukaal'];
    gulika = json['gulika'];
    yamakanta = json['yamakanta'];
    date = json['date'];
  }
  Day? day;
  Tithi? tithi;
  Nakshatra? nakshatra;
  Karana? karana;
  Yoga? yoga;
  Ayanamsa? ayanamsa;
  Rasi? rasi;
  AdvancedDetails? advancedDetails;
  String? rahukaal;
  String? gulika;
  String? yamakanta;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (day != null) {
      map['day'] = day?.toJson();
    }
    if (tithi != null) {
      map['tithi'] = tithi?.toJson();
    }
    if (nakshatra != null) {
      map['nakshatra'] = nakshatra?.toJson();
    }
    if (karana != null) {
      map['karana'] = karana?.toJson();
    }
    if (yoga != null) {
      map['yoga'] = yoga?.toJson();
    }
    if (ayanamsa != null) {
      map['ayanamsa'] = ayanamsa?.toJson();
    }
    if (rasi != null) {
      map['rasi'] = rasi?.toJson();
    }
    if (advancedDetails != null) {
      map['advanced_details'] = advancedDetails?.toJson();
    }
    map['rahukaal'] = rahukaal;
    map['gulika'] = gulika;
    map['yamakanta'] = yamakanta;
    map['date'] = date;
    return map;
  }

}

class AdvancedDetails {
  AdvancedDetails({
      this.sunRise, 
      this.sunSet, 
      this.moonRise, 
      this.moonSet, 
      this.solarNoon, 
      this.nextFullMoon, 
      this.nextNewMoon, 
      this.masa, 
      this.moonYoginiNivas, 
      this.ahargana, 
      this.years, 
      this.vaara, 
      this.dishaShool, 
      this.abhijitMuhurta,});

  AdvancedDetails.fromJson(dynamic json) {
    sunRise = json['sun_rise'];
    sunSet = json['sun_set'];
    moonRise = json['moon_rise'];
    moonSet = json['moon_set'];
    solarNoon = json['solar_noon'];
    nextFullMoon = json['next_full_moon'];
    nextNewMoon = json['next_new_moon'];
    masa = json['masa'] != null ? Masa.fromJson(json['masa']) : null;
    moonYoginiNivas = json['moon_yogini_nivas'];
    ahargana = json['ahargana'];
    years = json['years'] != null ? Years.fromJson(json['years']) : null;
    vaara = json['vaara'];
    dishaShool = json['disha_shool'];
    abhijitMuhurta = json['abhijitMuhurta'] != null ? AbhijitMuhurta.fromJson(json['abhijitMuhurta']) : null;
  }
  String? sunRise;
  String? sunSet;
  String? moonRise;
  String? moonSet;
  String? solarNoon;
  String? nextFullMoon;
  String? nextNewMoon;
  Masa? masa;
  String? moonYoginiNivas;
  num? ahargana;
  Years? years;
  String? vaara;
  String? dishaShool;
  AbhijitMuhurta? abhijitMuhurta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sun_rise'] = sunRise;
    map['sun_set'] = sunSet;
    map['moon_rise'] = moonRise;
    map['moon_set'] = moonSet;
    map['solar_noon'] = solarNoon;
    map['next_full_moon'] = nextFullMoon;
    map['next_new_moon'] = nextNewMoon;
    if (masa != null) {
      map['masa'] = masa?.toJson();
    }
    map['moon_yogini_nivas'] = moonYoginiNivas;
    map['ahargana'] = ahargana;
    if (years != null) {
      map['years'] = years?.toJson();
    }
    map['vaara'] = vaara;
    map['disha_shool'] = dishaShool;
    if (abhijitMuhurta != null) {
      map['abhijitMuhurta'] = abhijitMuhurta?.toJson();
    }
    return map;
  }

}

class AbhijitMuhurta {
  AbhijitMuhurta({
      this.start, 
      this.end,});

  AbhijitMuhurta.fromJson(dynamic json) {
    start = json['start'];
    end = json['end'];
  }
  String? start;
  String? end;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['start'] = start;
    map['end'] = end;
    return map;
  }

}

class Years {
  Years({
      this.kali, 
      this.saka, 
      this.vikramSamvaat, 
      this.kaliSamvaatName, 
      this.vikramSamvaatName, 
      this.sakaSamvaatName, 
      this.kaliSamvaatNumber, 
      this.sakaSamvaatNumber, 
      this.vikramSamvaatNumber,});

  Years.fromJson(dynamic json) {
    kali = json['kali'];
    saka = json['saka'];
    vikramSamvaat = json['vikram_samvaat'];
    kaliSamvaatName = json['kali_samvaat_name'];
    vikramSamvaatName = json['vikram_samvaat_name'];
    sakaSamvaatName = json['saka_samvaat_name'];
    kaliSamvaatNumber = json['kali_samvaat_number'];
    sakaSamvaatNumber = json['saka_samvaat_number'];
    vikramSamvaatNumber = json['vikram_samvaat_number'];
  }
  num? kali;
  num? saka;
  num? vikramSamvaat;
  String? kaliSamvaatName;
  String? vikramSamvaatName;
  String? sakaSamvaatName;
  num? kaliSamvaatNumber;
  num? sakaSamvaatNumber;
  num? vikramSamvaatNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['kali'] = kali;
    map['saka'] = saka;
    map['vikram_samvaat'] = vikramSamvaat;
    map['kali_samvaat_name'] = kaliSamvaatName;
    map['vikram_samvaat_name'] = vikramSamvaatName;
    map['saka_samvaat_name'] = sakaSamvaatName;
    map['kali_samvaat_number'] = kaliSamvaatNumber;
    map['saka_samvaat_number'] = sakaSamvaatNumber;
    map['vikram_samvaat_number'] = vikramSamvaatNumber;
    return map;
  }

}

class Masa {
  Masa({
      this.amantaNumber, 
      this.amantaDate, 
      this.amantaName, 
      this.alternateAmantaName, 
      this.amantaStart, 
      this.amantaEnd, 
      this.adhikMaasa, 
      this.ayana, 
      this.realAyana, 
      this.tamilMonthNum, 
      this.tamilMonth, 
      this.tamilDay, 
      this.purnimantaDate, 
      this.purnimantaNumber, 
      this.purnimantaName, 
      this.alternatePurnimantaName, 
      this.purnimantaStart, 
      this.purnimantaEnd, 
      this.moonPhase, 
      this.paksha, 
      this.ritu, 
      this.rituTamil, 
      this.rituOdia,});

  Masa.fromJson(dynamic json) {
    amantaNumber = json['amanta_number'];
    amantaDate = json['amanta_date'];
    amantaName = json['amanta_name'];
    alternateAmantaName = json['alternate_amanta_name'];
    amantaStart = json['amanta_start'];
    amantaEnd = json['amanta_end'];
    adhikMaasa = json['adhik_maasa'];
    ayana = json['ayana'];
    realAyana = json['real_ayana'];
    tamilMonthNum = json['tamil_month_num'];
    tamilMonth = json['tamil_month'];
    tamilDay = json['tamil_day'];
    purnimantaDate = json['purnimanta_date'];
    purnimantaNumber = json['purnimanta_number'];
    purnimantaName = json['purnimanta_name'];
    alternatePurnimantaName = json['alternate_purnimanta_name'];
    purnimantaStart = json['purnimanta_start'];
    purnimantaEnd = json['purnimanta_end'];
    moonPhase = json['moon_phase'];
    paksha = json['paksha'];
    ritu = json['ritu'];
    rituTamil = json['ritu_tamil'];
    rituOdia = json['rituOdia'];
  }
  String? amantaNumber;
  String? amantaDate;
  String? amantaName;
  String? alternateAmantaName;
  String? amantaStart;
  String? amantaEnd;
  bool? adhikMaasa;
  String? ayana;
  String? realAyana;
  num? tamilMonthNum;
  String? tamilMonth;
  num? tamilDay;
  String? purnimantaDate;
  String? purnimantaNumber;
  String? purnimantaName;
  String? alternatePurnimantaName;
  String? purnimantaStart;
  String? purnimantaEnd;
  String? moonPhase;
  String? paksha;
  String? ritu;
  String? rituTamil;
  String? rituOdia;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amanta_number'] = amantaNumber;
    map['amanta_date'] = amantaDate;
    map['amanta_name'] = amantaName;
    map['alternate_amanta_name'] = alternateAmantaName;
    map['amanta_start'] = amantaStart;
    map['amanta_end'] = amantaEnd;
    map['adhik_maasa'] = adhikMaasa;
    map['ayana'] = ayana;
    map['real_ayana'] = realAyana;
    map['tamil_month_num'] = tamilMonthNum;
    map['tamil_month'] = tamilMonth;
    map['tamil_day'] = tamilDay;
    map['purnimanta_date'] = purnimantaDate;
    map['purnimanta_number'] = purnimantaNumber;
    map['purnimanta_name'] = purnimantaName;
    map['alternate_purnimanta_name'] = alternatePurnimantaName;
    map['purnimanta_start'] = purnimantaStart;
    map['purnimanta_end'] = purnimantaEnd;
    map['moon_phase'] = moonPhase;
    map['paksha'] = paksha;
    map['ritu'] = ritu;
    map['ritu_tamil'] = rituTamil;
    map['rituOdia'] = rituOdia;
    return map;
  }

}

class Rasi {
  Rasi({
      this.name,});

  Rasi.fromJson(dynamic json) {
    name = json['name'];
  }
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }

}

class Ayanamsa {
  Ayanamsa({
      this.name,});

  Ayanamsa.fromJson(dynamic json) {
    name = json['name'];
  }
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }

}

class Yoga {
  Yoga({
      this.name, 
      this.number, 
      this.start, 
      this.end, 
      this.meaning, 
      this.special, 
      this.nextYoga,});

  Yoga.fromJson(dynamic json) {
    name = json['name'];
    number = json['number'];
    start = json['start'];
    end = json['end'];
    meaning = json['meaning'];
    special = json['special'];
    nextYoga = json['next_yoga'];
  }
  String? name;
  num? number;
  String? start;
  String? end;
  String? meaning;
  String? special;
  String? nextYoga;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['number'] = number;
    map['start'] = start;
    map['end'] = end;
    map['meaning'] = meaning;
    map['special'] = special;
    map['next_yoga'] = nextYoga;
    return map;
  }

}

class Karana {
  Karana({
      this.name, 
      this.lord, 
      this.diety, 
      this.type, 
      this.number, 
      this.start, 
      this.end, 
      this.special, 
      this.nextKarana,});

  Karana.fromJson(dynamic json) {
    name = json['name'];
    lord = json['lord'];
    diety = json['diety'];
    type = json['type'];
    number = json['number'];
    start = json['start'];
    end = json['end'];
    special = json['special'];
    nextKarana = json['next_karana'];
  }
  String? name;
  String? lord;
  String? diety;
  String? type;
  num? number;
  String? start;
  String? end;
  String? special;
  String? nextKarana;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['lord'] = lord;
    map['diety'] = diety;
    map['type'] = type;
    map['number'] = number;
    map['start'] = start;
    map['end'] = end;
    map['special'] = special;
    map['next_karana'] = nextKarana;
    return map;
  }

}

class Nakshatra {
  Nakshatra({
      this.name, 
      this.lord, 
      this.diety, 
      this.number, 
      this.start, 
      this.end, 
      this.nextNakshatra, 
      this.meaning, 
      this.special, 
      this.summary, 
      this.words,});

  Nakshatra.fromJson(dynamic json) {
    name = json['name'];
    lord = json['lord'];
    diety = json['diety'];
    number = json['number'];
    start = json['start'];
    end = json['end'];
    nextNakshatra = json['next_nakshatra'];
    meaning = json['meaning'];
    special = json['special'];
    summary = json['summary'];
    words = json['words'];
  }
  String? name;
  String? lord;
  String? diety;
  num? number;
  String? start;
  String? end;
  String? nextNakshatra;
  String? meaning;
  String? special;
  String? summary;
  String? words;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['lord'] = lord;
    map['diety'] = diety;
    map['number'] = number;
    map['start'] = start;
    map['end'] = end;
    map['next_nakshatra'] = nextNakshatra;
    map['meaning'] = meaning;
    map['special'] = special;
    map['summary'] = summary;
    map['words'] = words;
    return map;
  }

}

class Tithi {
  Tithi({
      this.name, 
      this.diety, 
      this.type, 
      this.number, 
      this.start, 
      this.end, 
      this.nextTithi, 
      this.meaning, 
      this.special,});

  Tithi.fromJson(dynamic json) {
    name = json['name'];
    diety = json['diety'];
    type = json['type'];
    number = json['number'];
    start = json['start'];
    end = json['end'];
    nextTithi = json['next_tithi'];
    meaning = json['meaning'];
    special = json['special'];
  }
  String? name;
  String? diety;
  String? type;
  num? number;
  String? start;
  String? end;
  String? nextTithi;
  String? meaning;
  String? special;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['diety'] = diety;
    map['type'] = type;
    map['number'] = number;
    map['start'] = start;
    map['end'] = end;
    map['next_tithi'] = nextTithi;
    map['meaning'] = meaning;
    map['special'] = special;
    return map;
  }

}

class Day {
  Day({
      this.name,});

  Day.fromJson(dynamic json) {
    name = json['name'];
  }
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }

}