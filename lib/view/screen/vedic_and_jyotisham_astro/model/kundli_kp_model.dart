class KundliKpModel {
  KundliKpModel({
      this.status, 
      this.response,});

  KundliKpModel.fromJson(dynamic json) {
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
      this.k0,
      this.k1,
      this.k2,
      this.k3,
      this.k4,
      this.k5,
      this.k6,
      this.k7,
      this.k8,
      this.k9,
      this.midheaven, 
      this.ascendant,});

  Response.fromJson(dynamic json) {
     k0= json['0'] != null ? K0.fromJson(json['0']) : null;
     k1= json['1'] != null ? K1.fromJson(json['1']) : null;
     k2= json['2'] != null ? K2.fromJson(json['2']) : null;
     k3= json['3'] != null ? K3.fromJson(json['3']) : null;
     k4= json['4'] != null ? K4.fromJson(json['4']) : null;
     k5= json['5'] != null ? K5.fromJson(json['5']) : null;
     k6= json['6'] != null ? K6.fromJson(json['6']) : null;
     k7= json['7'] != null ? K7.fromJson(json['7']) : null;
     k8= json['8'] != null ? K8.fromJson(json['8']) : null;
     k9= json['9'] != null ? K9.fromJson(json['9']) : null;
    midheaven = json['midheaven'];
    ascendant = json['ascendant'];
  }
  K0? k0;
  K1? k1;
  K2? k2;
  K3? k3;
  K4? k4;
  K5? k5;
  K6? k6;
  K7? k7;
  K8? k8;
  K9? k9;
  num? midheaven;
  num? ascendant;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if ( k0!= null) {
      map['0'] = k0?.toJson();
    }
    if ( k1!= null) {
      map['1'] = k1?.toJson();
    }
    if ( k2!= null) {
      map['2'] = k2?.toJson();
    }
    if ( k3!= null) {
      map['3'] = k3?.toJson();
    }
    if ( k4!= null) {
      map['4'] = k4?.toJson();
    }
    if ( k5!= null) {
      map['5'] = k5?.toJson();
    }
    if ( k6!= null) {
      map['6'] = k6?.toJson();
    }
    if ( k7!= null) {
      map['7'] = k7?.toJson();
    }
    if ( k8!= null) {
      map['8'] = k8?.toJson();
    }
    if ( k9!= null) {
      map['9'] = k9?.toJson();
    }
    map['midheaven'] = midheaven;
    map['ascendant'] = ascendant;
    return map;
  }

}

class K9 {
  K9({
      this.rasiNo, 
      this.zodiac, 
      this.retro, 
      this.name, 
      this.house, 
      this.globalDegree, 
      this.localDegree, 
      this.pseudoRasiNo, 
      this.pseudoRasi, 
      this.pseudoRasiLord, 
      this.pseudoNakshatra, 
      this.pseudoNakshatraNo, 
      this.pseudoNakshatraPada, 
      this.pseudoNakshatraLord, 
      this.subLord, 
      this.subSubLord, 
      this.fullName,});

  K9.fromJson(dynamic json) {
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    retro = json['retro'];
    name = json['name'];
    house = json['house'];
    globalDegree = json['global_degree'];
    localDegree = json['local_degree'];
    pseudoRasiNo = json['pseudo_rasi_no'];
    pseudoRasi = json['pseudo_rasi'];
    pseudoRasiLord = json['pseudo_rasi_lord'];
    pseudoNakshatra = json['pseudo_nakshatra'];
    pseudoNakshatraNo = json['pseudo_nakshatra_no'];
    pseudoNakshatraPada = json['pseudo_nakshatra_pada'];
    pseudoNakshatraLord = json['pseudo_nakshatra_lord'];
    subLord = json['sub_lord'];
    subSubLord = json['sub_sub_lord'];
    fullName = json['full_name'];
  }
  num? rasiNo;
  String? zodiac;
  bool? retro;
  String? name;
  num? house;
  num? globalDegree;
  num? localDegree;
  num? pseudoRasiNo;
  String? pseudoRasi;
  String? pseudoRasiLord;
  String? pseudoNakshatra;
  num? pseudoNakshatraNo;
  num? pseudoNakshatraPada;
  String? pseudoNakshatraLord;
  String? subLord;
  String? subSubLord;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['retro'] = retro;
    map['name'] = name;
    map['house'] = house;
    map['global_degree'] = globalDegree;
    map['local_degree'] = localDegree;
    map['pseudo_rasi_no'] = pseudoRasiNo;
    map['pseudo_rasi'] = pseudoRasi;
    map['pseudo_rasi_lord'] = pseudoRasiLord;
    map['pseudo_nakshatra'] = pseudoNakshatra;
    map['pseudo_nakshatra_no'] = pseudoNakshatraNo;
    map['pseudo_nakshatra_pada'] = pseudoNakshatraPada;
    map['pseudo_nakshatra_lord'] = pseudoNakshatraLord;
    map['sub_lord'] = subLord;
    map['sub_sub_lord'] = subSubLord;
    map['full_name'] = fullName;
    return map;
  }

}

class K8 {
  K8({
      this.rasiNo, 
      this.zodiac, 
      this.retro, 
      this.name, 
      this.house, 
      this.globalDegree, 
      this.localDegree, 
      this.pseudoRasiNo, 
      this.pseudoRasi, 
      this.pseudoRasiLord, 
      this.pseudoNakshatra, 
      this.pseudoNakshatraNo, 
      this.pseudoNakshatraPada, 
      this.pseudoNakshatraLord, 
      this.subLord, 
      this.subSubLord, 
      this.fullName,});

  K8.fromJson(dynamic json) {
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    retro = json['retro'];
    name = json['name'];
    house = json['house'];
    globalDegree = json['global_degree'];
    localDegree = json['local_degree'];
    pseudoRasiNo = json['pseudo_rasi_no'];
    pseudoRasi = json['pseudo_rasi'];
    pseudoRasiLord = json['pseudo_rasi_lord'];
    pseudoNakshatra = json['pseudo_nakshatra'];
    pseudoNakshatraNo = json['pseudo_nakshatra_no'];
    pseudoNakshatraPada = json['pseudo_nakshatra_pada'];
    pseudoNakshatraLord = json['pseudo_nakshatra_lord'];
    subLord = json['sub_lord'];
    subSubLord = json['sub_sub_lord'];
    fullName = json['full_name'];
  }
  num? rasiNo;
  String? zodiac;
  bool? retro;
  String? name;
  num? house;
  num? globalDegree;
  num? localDegree;
  num? pseudoRasiNo;
  String? pseudoRasi;
  String? pseudoRasiLord;
  String? pseudoNakshatra;
  num? pseudoNakshatraNo;
  num? pseudoNakshatraPada;
  String? pseudoNakshatraLord;
  String? subLord;
  String? subSubLord;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['retro'] = retro;
    map['name'] = name;
    map['house'] = house;
    map['global_degree'] = globalDegree;
    map['local_degree'] = localDegree;
    map['pseudo_rasi_no'] = pseudoRasiNo;
    map['pseudo_rasi'] = pseudoRasi;
    map['pseudo_rasi_lord'] = pseudoRasiLord;
    map['pseudo_nakshatra'] = pseudoNakshatra;
    map['pseudo_nakshatra_no'] = pseudoNakshatraNo;
    map['pseudo_nakshatra_pada'] = pseudoNakshatraPada;
    map['pseudo_nakshatra_lord'] = pseudoNakshatraLord;
    map['sub_lord'] = subLord;
    map['sub_sub_lord'] = subSubLord;
    map['full_name'] = fullName;
    return map;
  }

}

class K7 {
  K7({
      this.rasiNo, 
      this.zodiac, 
      this.retro, 
      this.name, 
      this.house, 
      this.globalDegree, 
      this.localDegree, 
      this.pseudoRasiNo, 
      this.pseudoRasi, 
      this.pseudoRasiLord, 
      this.pseudoNakshatra, 
      this.pseudoNakshatraNo, 
      this.pseudoNakshatraPada, 
      this.pseudoNakshatraLord, 
      this.subLord, 
      this.subSubLord, 
      this.fullName,});

  K7.fromJson(dynamic json) {
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    retro = json['retro'];
    name = json['name'];
    house = json['house'];
    globalDegree = json['global_degree'];
    localDegree = json['local_degree'];
    pseudoRasiNo = json['pseudo_rasi_no'];
    pseudoRasi = json['pseudo_rasi'];
    pseudoRasiLord = json['pseudo_rasi_lord'];
    pseudoNakshatra = json['pseudo_nakshatra'];
    pseudoNakshatraNo = json['pseudo_nakshatra_no'];
    pseudoNakshatraPada = json['pseudo_nakshatra_pada'];
    pseudoNakshatraLord = json['pseudo_nakshatra_lord'];
    subLord = json['sub_lord'];
    subSubLord = json['sub_sub_lord'];
    fullName = json['full_name'];
  }
  num? rasiNo;
  String? zodiac;
  bool? retro;
  String? name;
  num? house;
  num? globalDegree;
  num? localDegree;
  num? pseudoRasiNo;
  String? pseudoRasi;
  String? pseudoRasiLord;
  String? pseudoNakshatra;
  num? pseudoNakshatraNo;
  num? pseudoNakshatraPada;
  String? pseudoNakshatraLord;
  String? subLord;
  String? subSubLord;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['retro'] = retro;
    map['name'] = name;
    map['house'] = house;
    map['global_degree'] = globalDegree;
    map['local_degree'] = localDegree;
    map['pseudo_rasi_no'] = pseudoRasiNo;
    map['pseudo_rasi'] = pseudoRasi;
    map['pseudo_rasi_lord'] = pseudoRasiLord;
    map['pseudo_nakshatra'] = pseudoNakshatra;
    map['pseudo_nakshatra_no'] = pseudoNakshatraNo;
    map['pseudo_nakshatra_pada'] = pseudoNakshatraPada;
    map['pseudo_nakshatra_lord'] = pseudoNakshatraLord;
    map['sub_lord'] = subLord;
    map['sub_sub_lord'] = subSubLord;
    map['full_name'] = fullName;
    return map;
  }

}

class K6 {
  K6({
      this.rasiNo, 
      this.zodiac, 
      this.retro, 
      this.name, 
      this.house, 
      this.globalDegree, 
      this.localDegree, 
      this.pseudoRasiNo, 
      this.pseudoRasi, 
      this.pseudoRasiLord, 
      this.pseudoNakshatra, 
      this.pseudoNakshatraNo, 
      this.pseudoNakshatraPada, 
      this.pseudoNakshatraLord, 
      this.subLord, 
      this.subSubLord, 
      this.fullName,});

  K6.fromJson(dynamic json) {
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    retro = json['retro'];
    name = json['name'];
    house = json['house'];
    globalDegree = json['global_degree'];
    localDegree = json['local_degree'];
    pseudoRasiNo = json['pseudo_rasi_no'];
    pseudoRasi = json['pseudo_rasi'];
    pseudoRasiLord = json['pseudo_rasi_lord'];
    pseudoNakshatra = json['pseudo_nakshatra'];
    pseudoNakshatraNo = json['pseudo_nakshatra_no'];
    pseudoNakshatraPada = json['pseudo_nakshatra_pada'];
    pseudoNakshatraLord = json['pseudo_nakshatra_lord'];
    subLord = json['sub_lord'];
    subSubLord = json['sub_sub_lord'];
    fullName = json['full_name'];
  }
  num? rasiNo;
  String? zodiac;
  bool? retro;
  String? name;
  num? house;
  num? globalDegree;
  num? localDegree;
  num? pseudoRasiNo;
  String? pseudoRasi;
  String? pseudoRasiLord;
  String? pseudoNakshatra;
  num? pseudoNakshatraNo;
  num? pseudoNakshatraPada;
  String? pseudoNakshatraLord;
  String? subLord;
  String? subSubLord;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['retro'] = retro;
    map['name'] = name;
    map['house'] = house;
    map['global_degree'] = globalDegree;
    map['local_degree'] = localDegree;
    map['pseudo_rasi_no'] = pseudoRasiNo;
    map['pseudo_rasi'] = pseudoRasi;
    map['pseudo_rasi_lord'] = pseudoRasiLord;
    map['pseudo_nakshatra'] = pseudoNakshatra;
    map['pseudo_nakshatra_no'] = pseudoNakshatraNo;
    map['pseudo_nakshatra_pada'] = pseudoNakshatraPada;
    map['pseudo_nakshatra_lord'] = pseudoNakshatraLord;
    map['sub_lord'] = subLord;
    map['sub_sub_lord'] = subSubLord;
    map['full_name'] = fullName;
    return map;
  }

}

class K5 {
  K5({
      this.rasiNo, 
      this.zodiac, 
      this.retro, 
      this.name, 
      this.house, 
      this.globalDegree, 
      this.localDegree, 
      this.pseudoRasiNo, 
      this.pseudoRasi, 
      this.pseudoRasiLord, 
      this.pseudoNakshatra, 
      this.pseudoNakshatraNo, 
      this.pseudoNakshatraPada, 
      this.pseudoNakshatraLord, 
      this.subLord, 
      this.subSubLord, 
      this.fullName,});

  K5.fromJson(dynamic json) {
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    retro = json['retro'];
    name = json['name'];
    house = json['house'];
    globalDegree = json['global_degree'];
    localDegree = json['local_degree'];
    pseudoRasiNo = json['pseudo_rasi_no'];
    pseudoRasi = json['pseudo_rasi'];
    pseudoRasiLord = json['pseudo_rasi_lord'];
    pseudoNakshatra = json['pseudo_nakshatra'];
    pseudoNakshatraNo = json['pseudo_nakshatra_no'];
    pseudoNakshatraPada = json['pseudo_nakshatra_pada'];
    pseudoNakshatraLord = json['pseudo_nakshatra_lord'];
    subLord = json['sub_lord'];
    subSubLord = json['sub_sub_lord'];
    fullName = json['full_name'];
  }
  num? rasiNo;
  String? zodiac;
  bool? retro;
  String? name;
  num? house;
  num? globalDegree;
  num? localDegree;
  num? pseudoRasiNo;
  String? pseudoRasi;
  String? pseudoRasiLord;
  String? pseudoNakshatra;
  num? pseudoNakshatraNo;
  num? pseudoNakshatraPada;
  String? pseudoNakshatraLord;
  String? subLord;
  String? subSubLord;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['retro'] = retro;
    map['name'] = name;
    map['house'] = house;
    map['global_degree'] = globalDegree;
    map['local_degree'] = localDegree;
    map['pseudo_rasi_no'] = pseudoRasiNo;
    map['pseudo_rasi'] = pseudoRasi;
    map['pseudo_rasi_lord'] = pseudoRasiLord;
    map['pseudo_nakshatra'] = pseudoNakshatra;
    map['pseudo_nakshatra_no'] = pseudoNakshatraNo;
    map['pseudo_nakshatra_pada'] = pseudoNakshatraPada;
    map['pseudo_nakshatra_lord'] = pseudoNakshatraLord;
    map['sub_lord'] = subLord;
    map['sub_sub_lord'] = subSubLord;
    map['full_name'] = fullName;
    return map;
  }

}

class K4 {
  K4({
      this.rasiNo, 
      this.zodiac, 
      this.retro, 
      this.name, 
      this.house, 
      this.globalDegree, 
      this.localDegree, 
      this.pseudoRasiNo, 
      this.pseudoRasi, 
      this.pseudoRasiLord, 
      this.pseudoNakshatra, 
      this.pseudoNakshatraNo, 
      this.pseudoNakshatraPada, 
      this.pseudoNakshatraLord, 
      this.subLord, 
      this.subSubLord, 
      this.fullName,});

  K4.fromJson(dynamic json) {
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    retro = json['retro'];
    name = json['name'];
    house = json['house'];
    globalDegree = json['global_degree'];
    localDegree = json['local_degree'];
    pseudoRasiNo = json['pseudo_rasi_no'];
    pseudoRasi = json['pseudo_rasi'];
    pseudoRasiLord = json['pseudo_rasi_lord'];
    pseudoNakshatra = json['pseudo_nakshatra'];
    pseudoNakshatraNo = json['pseudo_nakshatra_no'];
    pseudoNakshatraPada = json['pseudo_nakshatra_pada'];
    pseudoNakshatraLord = json['pseudo_nakshatra_lord'];
    subLord = json['sub_lord'];
    subSubLord = json['sub_sub_lord'];
    fullName = json['full_name'];
  }
  num? rasiNo;
  String? zodiac;
  bool? retro;
  String? name;
  num? house;
  num? globalDegree;
  num? localDegree;
  num? pseudoRasiNo;
  String? pseudoRasi;
  String? pseudoRasiLord;
  String? pseudoNakshatra;
  num? pseudoNakshatraNo;
  num? pseudoNakshatraPada;
  String? pseudoNakshatraLord;
  String? subLord;
  String? subSubLord;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['retro'] = retro;
    map['name'] = name;
    map['house'] = house;
    map['global_degree'] = globalDegree;
    map['local_degree'] = localDegree;
    map['pseudo_rasi_no'] = pseudoRasiNo;
    map['pseudo_rasi'] = pseudoRasi;
    map['pseudo_rasi_lord'] = pseudoRasiLord;
    map['pseudo_nakshatra'] = pseudoNakshatra;
    map['pseudo_nakshatra_no'] = pseudoNakshatraNo;
    map['pseudo_nakshatra_pada'] = pseudoNakshatraPada;
    map['pseudo_nakshatra_lord'] = pseudoNakshatraLord;
    map['sub_lord'] = subLord;
    map['sub_sub_lord'] = subSubLord;
    map['full_name'] = fullName;
    return map;
  }

}

class K3 {
  K3({
      this.rasiNo, 
      this.zodiac, 
      this.retro, 
      this.name, 
      this.house, 
      this.globalDegree, 
      this.localDegree, 
      this.pseudoRasiNo, 
      this.pseudoRasi, 
      this.pseudoRasiLord, 
      this.pseudoNakshatra, 
      this.pseudoNakshatraNo, 
      this.pseudoNakshatraPada, 
      this.pseudoNakshatraLord, 
      this.subLord, 
      this.subSubLord, 
      this.fullName,});

  K3.fromJson(dynamic json) {
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    retro = json['retro'];
    name = json['name'];
    house = json['house'];
    globalDegree = json['global_degree'];
    localDegree = json['local_degree'];
    pseudoRasiNo = json['pseudo_rasi_no'];
    pseudoRasi = json['pseudo_rasi'];
    pseudoRasiLord = json['pseudo_rasi_lord'];
    pseudoNakshatra = json['pseudo_nakshatra'];
    pseudoNakshatraNo = json['pseudo_nakshatra_no'];
    pseudoNakshatraPada = json['pseudo_nakshatra_pada'];
    pseudoNakshatraLord = json['pseudo_nakshatra_lord'];
    subLord = json['sub_lord'];
    subSubLord = json['sub_sub_lord'];
    fullName = json['full_name'];
  }
  num? rasiNo;
  String? zodiac;
  bool? retro;
  String? name;
  num? house;
  num? globalDegree;
  num? localDegree;
  num? pseudoRasiNo;
  String? pseudoRasi;
  String? pseudoRasiLord;
  String? pseudoNakshatra;
  num? pseudoNakshatraNo;
  num? pseudoNakshatraPada;
  String? pseudoNakshatraLord;
  String? subLord;
  String? subSubLord;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['retro'] = retro;
    map['name'] = name;
    map['house'] = house;
    map['global_degree'] = globalDegree;
    map['local_degree'] = localDegree;
    map['pseudo_rasi_no'] = pseudoRasiNo;
    map['pseudo_rasi'] = pseudoRasi;
    map['pseudo_rasi_lord'] = pseudoRasiLord;
    map['pseudo_nakshatra'] = pseudoNakshatra;
    map['pseudo_nakshatra_no'] = pseudoNakshatraNo;
    map['pseudo_nakshatra_pada'] = pseudoNakshatraPada;
    map['pseudo_nakshatra_lord'] = pseudoNakshatraLord;
    map['sub_lord'] = subLord;
    map['sub_sub_lord'] = subSubLord;
    map['full_name'] = fullName;
    return map;
  }

}

class K2 {
  K2({
      this.rasiNo, 
      this.zodiac, 
      this.retro, 
      this.name, 
      this.house, 
      this.globalDegree, 
      this.localDegree, 
      this.pseudoRasiNo, 
      this.pseudoRasi, 
      this.pseudoRasiLord, 
      this.pseudoNakshatra, 
      this.pseudoNakshatraNo, 
      this.pseudoNakshatraPada, 
      this.pseudoNakshatraLord, 
      this.subLord, 
      this.subSubLord, 
      this.fullName,});

  K2.fromJson(dynamic json) {
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    retro = json['retro'];
    name = json['name'];
    house = json['house'];
    globalDegree = json['global_degree'];
    localDegree = json['local_degree'];
    pseudoRasiNo = json['pseudo_rasi_no'];
    pseudoRasi = json['pseudo_rasi'];
    pseudoRasiLord = json['pseudo_rasi_lord'];
    pseudoNakshatra = json['pseudo_nakshatra'];
    pseudoNakshatraNo = json['pseudo_nakshatra_no'];
    pseudoNakshatraPada = json['pseudo_nakshatra_pada'];
    pseudoNakshatraLord = json['pseudo_nakshatra_lord'];
    subLord = json['sub_lord'];
    subSubLord = json['sub_sub_lord'];
    fullName = json['full_name'];
  }
  num? rasiNo;
  String? zodiac;
  bool? retro;
  String? name;
  num? house;
  num? globalDegree;
  num? localDegree;
  num? pseudoRasiNo;
  String? pseudoRasi;
  String? pseudoRasiLord;
  String? pseudoNakshatra;
  num? pseudoNakshatraNo;
  num? pseudoNakshatraPada;
  String? pseudoNakshatraLord;
  String? subLord;
  String? subSubLord;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['retro'] = retro;
    map['name'] = name;
    map['house'] = house;
    map['global_degree'] = globalDegree;
    map['local_degree'] = localDegree;
    map['pseudo_rasi_no'] = pseudoRasiNo;
    map['pseudo_rasi'] = pseudoRasi;
    map['pseudo_rasi_lord'] = pseudoRasiLord;
    map['pseudo_nakshatra'] = pseudoNakshatra;
    map['pseudo_nakshatra_no'] = pseudoNakshatraNo;
    map['pseudo_nakshatra_pada'] = pseudoNakshatraPada;
    map['pseudo_nakshatra_lord'] = pseudoNakshatraLord;
    map['sub_lord'] = subLord;
    map['sub_sub_lord'] = subSubLord;
    map['full_name'] = fullName;
    return map;
  }

}

class K1 {
  K1({
      this.rasiNo, 
      this.zodiac, 
      this.retro, 
      this.name, 
      this.house, 
      this.globalDegree, 
      this.localDegree, 
      this.pseudoRasiNo, 
      this.pseudoRasi, 
      this.pseudoRasiLord, 
      this.pseudoNakshatra, 
      this.pseudoNakshatraNo, 
      this.pseudoNakshatraPada, 
      this.pseudoNakshatraLord, 
      this.subLord, 
      this.subSubLord, 
      this.fullName,});

  K1.fromJson(dynamic json) {
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    retro = json['retro'];
    name = json['name'];
    house = json['house'];
    globalDegree = json['global_degree'];
    localDegree = json['local_degree'];
    pseudoRasiNo = json['pseudo_rasi_no'];
    pseudoRasi = json['pseudo_rasi'];
    pseudoRasiLord = json['pseudo_rasi_lord'];
    pseudoNakshatra = json['pseudo_nakshatra'];
    pseudoNakshatraNo = json['pseudo_nakshatra_no'];
    pseudoNakshatraPada = json['pseudo_nakshatra_pada'];
    pseudoNakshatraLord = json['pseudo_nakshatra_lord'];
    subLord = json['sub_lord'];
    subSubLord = json['sub_sub_lord'];
    fullName = json['full_name'];
  }
  num? rasiNo;
  String? zodiac;
  bool? retro;
  String? name;
  num? house;
  num? globalDegree;
  num? localDegree;
  num? pseudoRasiNo;
  String? pseudoRasi;
  String? pseudoRasiLord;
  String? pseudoNakshatra;
  num? pseudoNakshatraNo;
  num? pseudoNakshatraPada;
  String? pseudoNakshatraLord;
  String? subLord;
  String? subSubLord;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['retro'] = retro;
    map['name'] = name;
    map['house'] = house;
    map['global_degree'] = globalDegree;
    map['local_degree'] = localDegree;
    map['pseudo_rasi_no'] = pseudoRasiNo;
    map['pseudo_rasi'] = pseudoRasi;
    map['pseudo_rasi_lord'] = pseudoRasiLord;
    map['pseudo_nakshatra'] = pseudoNakshatra;
    map['pseudo_nakshatra_no'] = pseudoNakshatraNo;
    map['pseudo_nakshatra_pada'] = pseudoNakshatraPada;
    map['pseudo_nakshatra_lord'] = pseudoNakshatraLord;
    map['sub_lord'] = subLord;
    map['sub_sub_lord'] = subSubLord;
    map['full_name'] = fullName;
    return map;
  }

}

class K0 {
  K0({
      this.rasiNo, 
      this.zodiac, 
      this.retro, 
      this.name, 
      this.house, 
      this.globalDegree, 
      this.localDegree, 
      this.pseudoRasiNo, 
      this.pseudoRasi, 
      this.pseudoRasiLord, 
      this.pseudoNakshatra, 
      this.pseudoNakshatraNo, 
      this.pseudoNakshatraPada, 
      this.pseudoNakshatraLord, 
      this.subLord, 
      this.subSubLord, 
      this.fullName,});

  K0.fromJson(dynamic json) {
    rasiNo = json['rasi_no'];
    zodiac = json['zodiac'];
    retro = json['retro'];
    name = json['name'];
    house = json['house'];
    globalDegree = json['global_degree'];
    localDegree = json['local_degree'];
    pseudoRasiNo = json['pseudo_rasi_no'];
    pseudoRasi = json['pseudo_rasi'];
    pseudoRasiLord = json['pseudo_rasi_lord'];
    pseudoNakshatra = json['pseudo_nakshatra'];
    pseudoNakshatraNo = json['pseudo_nakshatra_no'];
    pseudoNakshatraPada = json['pseudo_nakshatra_pada'];
    pseudoNakshatraLord = json['pseudo_nakshatra_lord'];
    subLord = json['sub_lord'];
    subSubLord = json['sub_sub_lord'];
    fullName = json['full_name'];
  }
  num? rasiNo;
  String? zodiac;
  bool? retro;
  String? name;
  num? house;
  num? globalDegree;
  num? localDegree;
  num? pseudoRasiNo;
  String? pseudoRasi;
  String? pseudoRasiLord;
  String? pseudoNakshatra;
  num? pseudoNakshatraNo;
  num? pseudoNakshatraPada;
  String? pseudoNakshatraLord;
  String? subLord;
  String? subSubLord;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rasi_no'] = rasiNo;
    map['zodiac'] = zodiac;
    map['retro'] = retro;
    map['name'] = name;
    map['house'] = house;
    map['global_degree'] = globalDegree;
    map['local_degree'] = localDegree;
    map['pseudo_rasi_no'] = pseudoRasiNo;
    map['pseudo_rasi'] = pseudoRasi;
    map['pseudo_rasi_lord'] = pseudoRasiLord;
    map['pseudo_nakshatra'] = pseudoNakshatra;
    map['pseudo_nakshatra_no'] = pseudoNakshatraNo;
    map['pseudo_nakshatra_pada'] = pseudoNakshatraPada;
    map['pseudo_nakshatra_lord'] = pseudoNakshatraLord;
    map['sub_lord'] = subLord;
    map['sub_sub_lord'] = subSubLord;
    map['full_name'] = fullName;
    return map;
  }

}