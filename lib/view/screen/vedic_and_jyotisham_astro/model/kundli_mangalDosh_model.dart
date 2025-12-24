class KundliMangalDoshModel {
  KundliMangalDoshModel({
      this.status, 
      this.response,});

  KundliMangalDoshModel.fromJson(dynamic json) {
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
      this.factors, 
      this.isDoshaPresentMarsFromLagna, 
      this.isDoshaPresentMarsFromMoon,
      this.isDoshaPresentMarsFromMars,
      this.isAnshik,
      this.isDoshaPresent, 
      this.botResponse, 
      this.score, 
      this.cancellation,});

  Response.fromJson(dynamic json) {
    factors = json['factors'] != null ? Factors.fromJson(json['factors']) : null;
    isDoshaPresentMarsFromLagna = json['is_dosha_present_mars_from_lagna'];
    isDoshaPresentMarsFromMoon = json['is_dosha_present_mars_from_moon'];
    isDoshaPresentMarsFromMars = json['is_dosha_present_mars_from_mars'];
    isAnshik = json['is_anshik'];
    isDoshaPresent = json['is_dosha_present'];
    botResponse = json['bot_response'];
    score = json['score'];

  }
  Factors? factors;
  bool? isDoshaPresentMarsFromLagna;
  bool? isDoshaPresentMarsFromMoon;
  bool? isDoshaPresentMarsFromMars;
  bool? isAnshik;
  bool? isDoshaPresent;
  String? botResponse;
  num? score;
  Cancellation? cancellation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (factors != null) {
      map['factors'] = factors?.toJson();
    }
    map['is_dosha_present_mars_from_lagna'] = isDoshaPresentMarsFromLagna;
    map['is_dosha_present_mars_from_moon'] = isDoshaPresentMarsFromMoon;
    map['is_dosha_present_mars_from_mars'] = isDoshaPresentMarsFromMars;
    map['is_anshik'] = isAnshik;
    map['is_dosha_present'] = isDoshaPresent;
    map['bot_response'] = botResponse;
    map['score'] = score;
    if (cancellation != null) {
      map['cancellation'] = cancellation?.toJson();
    }
    return map;
  }

}

class Cancellation {
  Cancellation({
      this.cancellationScore, 
      this.cancellationReason,});


  num? cancellationScore;
  List<dynamic>? cancellationReason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cancellationScore'] = cancellationScore;
    if (cancellationReason != null) {
      map['cancellationReason'] = cancellationReason?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Factors {
  Factors({
      this.moon, 
      this.mars,
      this.venus,
      this.saturn,});

  Factors.fromJson(dynamic json) {
    moon = json['moon'];
    mars = json['mars'];
    venus = json['venus'];
    saturn = json['saturn'];
  }
  String? moon;
  String? mars;
  String? venus;
  String? saturn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['moon'] = moon;
    map['mars'] = mars;
    map['venus'] = venus;
    map['saturn'] = saturn;
    return map;
  }

}