class KundliBasicsAvakhadaModel {
  KundliBasicsAvakhadaModel({
    this.status,
    this.response,});

  KundliBasicsAvakhadaModel.fromJson(dynamic json) {
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
    this.gana,
    this.yoni,
    this.vasya,
    this.nadi,
    this.varna,
    this.paya,
    this.tatva,
    this.lifeStone,
    this.luckyStone,
    this.fortuneStone,
    this.nameStart,
    this.ascendantSign,
    this.ascendantNakshatra,
    this.rasi,
    this.rasiLord,
    this.nakshatra,
    this.nakshatraLord,
    this.nakshatraPada,
    this.sunSign,
    this.tithi,
    this.karana,
    this.yoga,});

  Response.fromJson(dynamic json) {
    gana = json['gana'];
    yoni = json['yoni'];
    vasya = json['vasya'];
    nadi = json['nadi'];
    varna = json['varna'];
    paya = json['paya'];
    tatva = json['tatva'];
    lifeStone = json['life_stone'];
    luckyStone = json['lucky_stone'];
    fortuneStone = json['fortune_stone'];
    nameStart = json['name_start'];
    ascendantSign = json['ascendant_sign'];
    ascendantNakshatra = json['ascendant_nakshatra'];
    rasi = json['rasi'];
    rasiLord = json['rasi_lord'];
    nakshatra = json['nakshatra'];
    nakshatraLord = json['nakshatra_lord'];
    nakshatraPada = json['nakshatra_pada'];
    sunSign = json['sun_sign'];
    tithi = json['tithi'];
    karana = json['karana'];
    yoga = json['yoga'];
  }
  String? gana;
  String? yoni;
  String? vasya;
  String? nadi;
  String? varna;
  String? paya;
  String? tatva;
  String? lifeStone;
  String? luckyStone;
  String? fortuneStone;
  String? nameStart;
  String? ascendantSign;
  String? ascendantNakshatra;
  String? rasi;
  String? rasiLord;
  String? nakshatra;
  String? nakshatraLord;
  num? nakshatraPada;
  String? sunSign;
  String? tithi;
  String? karana;
  String? yoga;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gana'] = gana;
    map['yoni'] = yoni;
    map['vasya'] = vasya;
    map['nadi'] = nadi;
    map['varna'] = varna;
    map['paya'] = paya;
    map['tatva'] = tatva;
    map['life_stone'] = lifeStone;
    map['lucky_stone'] = luckyStone;
    map['fortune_stone'] = fortuneStone;
    map['name_start'] = nameStart;
    map['ascendant_sign'] = ascendantSign;
    map['ascendant_nakshatra'] = ascendantNakshatra;
    map['rasi'] = rasi;
    map['rasi_lord'] = rasiLord;
    map['nakshatra'] = nakshatra;
    map['nakshatra_lord'] = nakshatraLord;
    map['nakshatra_pada'] = nakshatraPada;
    map['sun_sign'] = sunSign;
    map['tithi'] = tithi;
    map['karana'] = karana;
    map['yoga'] = yoga;
    return map;
  }

}