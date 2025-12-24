class KundliAscendantsModel {
  KundliAscendantsModel({
    this.status,
    this.response,});

  KundliAscendantsModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['response'] != null) {
      response = [];
      json['response'].forEach((v) {
        response?.add(KundliAscendantResponse.fromJson(v));
      });
    }
  }
  num? status;
  List<KundliAscendantResponse>? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (response != null) {
      map['response'] = response?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class KundliAscendantResponse {
  KundliAscendantResponse({
    this.ascendant,
    this.ascendantLord,
    this.ascendantLordLocation,
    this.ascendantLordHouseLocation,
    this.generalPrediction,
    this.personalisedPrediction,
    this.verbalLocation,
    this.ascendantLordStrength,
    this.symbol,
    this.zodiacCharacteristics,
    this.luckyGem,
    this.dayForFasting,
    this.gayatriMantra,
    this.flagshipQualities,
    this.spiritualityAdvice,
    this.goodQualities,
    this.badQualities,});

  KundliAscendantResponse.fromJson(dynamic json) {
    ascendant = json['ascendant'];
    ascendantLord = json['ascendant_lord'];
    ascendantLordLocation = json['ascendant_lord_location'];
    ascendantLordHouseLocation = json['ascendant_lord_house_location'];
    generalPrediction = json['general_prediction'];
    personalisedPrediction = json['personalised_prediction'];
    verbalLocation = json['verbal_location'];
    ascendantLordStrength = json['ascendant_lord_strength'];
    symbol = json['symbol'];
    zodiacCharacteristics = json['zodiac_characteristics'];
    luckyGem = json['lucky_gem'];
    dayForFasting = json['day_for_fasting'];
    gayatriMantra = json['gayatri_mantra'];
    flagshipQualities = json['flagship_qualities'];
    spiritualityAdvice = json['spirituality_advice'];
    goodQualities = json['good_qualities'];
    badQualities = json['bad_qualities'];
  }
  String? ascendant;
  String? ascendantLord;
  String? ascendantLordLocation;
  num? ascendantLordHouseLocation;
  String? generalPrediction;
  String? personalisedPrediction;
  String? verbalLocation;
  String? ascendantLordStrength;
  String? symbol;
  String? zodiacCharacteristics;
  String? luckyGem;
  String? dayForFasting;
  String? gayatriMantra;
  String? flagshipQualities;
  String? spiritualityAdvice;
  String? goodQualities;
  String? badQualities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ascendant'] = ascendant;
    map['ascendant_lord'] = ascendantLord;
    map['ascendant_lord_location'] = ascendantLordLocation;
    map['ascendant_lord_house_location'] = ascendantLordHouseLocation;
    map['general_prediction'] = generalPrediction;
    map['personalised_prediction'] = personalisedPrediction;
    map['verbal_location'] = verbalLocation;
    map['ascendant_lord_strength'] = ascendantLordStrength;
    map['symbol'] = symbol;
    map['zodiac_characteristics'] = zodiacCharacteristics;
    map['lucky_gem'] = luckyGem;
    map['day_for_fasting'] = dayForFasting;
    map['gayatri_mantra'] = gayatriMantra;
    map['flagship_qualities'] = flagshipQualities;
    map['spirituality_advice'] = spiritualityAdvice;
    map['good_qualities'] = goodQualities;
    map['bad_qualities'] = badQualities;
    return map;
  }

}