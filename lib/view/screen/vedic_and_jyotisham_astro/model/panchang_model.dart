import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';import '../../../../utill/app_constants.dart';
import '../../splash/controller/config_controller.dart';

class PanchangModel {
  PanchangModel({
    this.status,
    this.response,});

  PanchangModel.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'] != null ? PanchangResponse.fromJson(json['response']) : null;
  }
  num? status;
  PanchangResponse? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    return map;
  }

}

class PanchangResponse {
  PanchangResponse({
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

  PanchangResponse.fromJson(dynamic json) {
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
    nextFullMoon = json['next_full_moon'];
    nextNewMoon = json['next_new_moon'];
    masa = json['masa'] != null ? Masa.fromJson(json['masa']) : null;
    moonYoginiNivas = json['moon_yogini_nivas'];
    ahargana = json['ahargana'];
    years = json['years'] != null ? Years.fromJson(json['years']) : null;
    vaara = json['vaara'];
    dishaShool = json['disha_shool'];

    final ConfigController configController = Get.find();
    String? activeKundliApi = configController.config.data?.activeKundliApi.toString();
    abhijitMuhurta = activeKundliApi == AppConstants.jyotisham ? json['abhijitMuhurta'] != null ? AbhijitMuhurta.fromJson(json['abhijitMuhurta']) : null
        : json['abhijit_muhurta'] != null ? AbhijitMuhurta.fromJson(json['abhijit_muhurta']) : null;
  }
  String? sunRise;
  String? sunSet;
  String? moonRise;
  String? moonSet;
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


    final ConfigController configController = Get.find();
    String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

    if (abhijitMuhurta != null) {
      activeKundliApi == AppConstants.jyotisham ? map['abhijitMuhurta'] : map['abhijit_muhurta'] = abhijitMuhurta?.toJson();
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
    this.kaliSamvaatNumber,
    this.kaliSamvaatName,
    this.vikramSamvaatNumber,
    this.vikramSamvaatName,
    this.sakaSamvaatNumber,
    this.sakaSamvaatName,});

  Years.fromJson(dynamic json) {
    kali = json['kali'];
    saka = json['saka'];
    vikramSamvaat = json['vikram_samvaat'];
    kaliSamvaatNumber = json['kali_samvaat_number'];
    kaliSamvaatName = json['kali_samvaat_name'];
    vikramSamvaatNumber = json['vikram_samvaat_number'];
    vikramSamvaatName = json['vikram_samvaat_name'];
    sakaSamvaatNumber = json['saka_samvaat_number'];
    sakaSamvaatName = json['saka_samvaat_name'];
  }
  num? kali;
  num? saka;
  num? vikramSamvaat;
  num? kaliSamvaatNumber;
  String? kaliSamvaatName;
  num? vikramSamvaatNumber;
  String? vikramSamvaatName;
  num? sakaSamvaatNumber;
  String? sakaSamvaatName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['kali'] = kali;
    map['saka'] = saka;
    map['vikram_samvaat'] = vikramSamvaat;
    map['kali_samvaat_number'] = kaliSamvaatNumber;
    map['kali_samvaat_name'] = kaliSamvaatName;
    map['vikram_samvaat_number'] = vikramSamvaatNumber;
    map['vikram_samvaat_name'] = vikramSamvaatName;
    map['saka_samvaat_number'] = sakaSamvaatNumber;
    map['saka_samvaat_name'] = sakaSamvaatName;
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
    this.purnimantaDate,
    this.purnimantaNumber,
    this.purnimantaName,
    this.alternatePurnimantaName,
    this.purnimantaStart,
    this.purnimantaEnd,
    this.moonPhase,
    this.paksha,
    this.ritu,
    this.rituTamil,});

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
  }
  num? amantaNumber;
  num? amantaDate;
  String? amantaName;
  String? alternateAmantaName;
  String? amantaStart;
  String? amantaEnd;
  bool? adhikMaasa;
  String? ayana;
  String? realAyana;
  num? purnimantaDate;
  num? purnimantaNumber;
  String? purnimantaName;
  String? alternatePurnimantaName;
  String? purnimantaStart;
  String? purnimantaEnd;
  String? moonPhase;
  String? paksha;
  String? ritu;
  String? rituTamil;

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
    this.nextYoga,
    this.meaning,
    this.special,});

  Yoga.fromJson(dynamic json) {
    name = json['name'];
    number = json['number'];
    start = json['start'];
    end = json['end'];
    nextYoga = json['next_yoga'];
    meaning = json['meaning'];
    special = json['special'];
  }
  String? name;
  num? number;
  String? start;
  String? end;
  String? nextYoga;
  String? meaning;
  String? special;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['number'] = number;
    map['start'] = start;
    map['end'] = end;
    map['next_yoga'] = nextYoga;
    map['meaning'] = meaning;
    map['special'] = special;
    return map;
  }

}

class Karana {
  Karana({
    this.name,
    this.number,
    this.type,
    this.lord,
    this.diety,
    this.start,
    this.end,
    this.special,
    this.nextKarana,});

  Karana.fromJson(dynamic json) {
    name = json['name'];
    number = json['number'];
    type = json['type'];
    lord = json['lord'];
    diety = json['diety'];
    start = json['start'];
    end = json['end'];
    special = json['special'];
    nextKarana = json['next_karana'];
  }
  String? name;
  num? number;
  String? type;
  String? lord;
  String? diety;
  String? start;
  String? end;
  String? special;
  String? nextKarana;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['number'] = number;
    map['type'] = type;
    map['lord'] = lord;
    map['diety'] = diety;
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
    this.number,
    this.lord,
    this.diety,
    this.start,
    this.nextNakshatra,
    this.end,
    this.meaning,
    this.special,
    this.summary,});

  Nakshatra.fromJson(dynamic json) {
    name = json['name'];
    number = json['number'];
    lord = json['lord'];
    diety = json['diety'];
    start = json['start'];
    nextNakshatra = json['next_nakshatra'];
    end = json['end'];
    meaning = json['meaning'];
    special = json['special'];
    summary = json['summary'];
  }
  String? name;
  num? number;
  String? lord;
  String? diety;
  String? start;
  String? nextNakshatra;
  String? end;
  String? meaning;
  String? special;
  String? summary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['number'] = number;
    map['lord'] = lord;
    map['diety'] = diety;
    map['start'] = start;
    map['next_nakshatra'] = nextNakshatra;
    map['end'] = end;
    map['meaning'] = meaning;
    map['special'] = special;
    map['summary'] = summary;
    return map;
  }

}

class Tithi {
  Tithi({
    this.name,
    this.number,
    this.nextTithi,
    this.type,
    this.diety,
    this.start,
    this.end,
    this.meaning,
    this.special,});

  Tithi.fromJson(dynamic json) {
    name = json['name'];
    number = json['number'];
    nextTithi = json['next_tithi'];
    type = json['type'];
    diety = json['diety'];
    start = json['start'];
    end = json['end'];
    meaning = json['meaning'];
    special = json['special'];
  }
  String? name;
  num? number;
  String? nextTithi;
  String? type;
  String? diety;
  String? start;
  String? end;
  String? meaning;
  String? special;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['number'] = number;
    map['next_tithi'] = nextTithi;
    map['type'] = type;
    map['diety'] = diety;
    map['start'] = start;
    map['end'] = end;
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