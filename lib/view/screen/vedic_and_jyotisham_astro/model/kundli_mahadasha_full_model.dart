class KundliMahadashaFullModel {
  KundliMahadashaFullModel({
    this.status,
    this.response,});

  KundliMahadashaFullModel.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'] != null ? CurrentDashaMahadashaResponse.fromJson(json['response']) : null;
  }
  num? status;
  CurrentDashaMahadashaResponse? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    return map;
  }

}

class CurrentDashaMahadashaResponse {
  CurrentDashaMahadashaResponse({
    this.mahadasha,});

  CurrentDashaMahadashaResponse.fromJson(dynamic json) {
    if (json['mahadasha'] != null) {
      mahadasha = [];
      json['mahadasha'].forEach((v) {
        mahadasha?.add(CurrentMahadasha.fromJson(v));
      });
    }
  }
  List<CurrentMahadasha>? mahadasha;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (mahadasha != null) {
      map['mahadasha'] = mahadasha?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CurrentMahadasha {
  CurrentMahadasha({
    this.name,
    this.key,
    this.start,
    this.end,});

  CurrentMahadasha.fromJson(dynamic json) {
    name = json['name'];
    key = json['key'];
    start = json['start'];
    end = json['end'];
  }
  String? name;
  String? key;
  String? start;
  String? end;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['key'] = key;
    map['start'] = start;
    map['end'] = end;
    return map;
  }

}

//Antardasha
class CurrentDashaAntardasha {
  CurrentDashaAntardasha({
    this.status,
    this.response,});

  CurrentDashaAntardasha.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'] != null ? CurrentDashaAntardashaResponse.fromJson(json['response']) : null;
  }
  num? status;
  CurrentDashaAntardashaResponse? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    return map;
  }

}

class CurrentDashaAntardashaResponse {
  CurrentDashaAntardashaResponse({
    this.antardasha,});

  CurrentDashaAntardashaResponse.fromJson(dynamic json) {
    if (json['antardasha'] != null) {
      antardasha = [];
      json['antardasha'].forEach((v) {
        antardasha?.add(CurrentAntardasha.fromJson(v));
      });
    }
  }
  List<CurrentAntardasha>? antardasha;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (antardasha != null) {
      map['antardasha'] = antardasha?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CurrentAntardasha {
  CurrentAntardasha({
    this.name,
    this.key,
    this.start,
    this.end,});

  CurrentAntardasha.fromJson(dynamic json) {
    name = json['name'];
    key = json['key'];
    start = json['start'];
    end = json['end'];
  }
  String? name;
  String? key;
  String? start;
  String? end;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['key'] = key;
    map['start'] = start;
    map['end'] = end;
    return map;
  }

}


//Paryantardasha
class CurrentDashaParyantardasha {
  CurrentDashaParyantardasha({
    this.status,
    this.response,});

  CurrentDashaParyantardasha.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'] != null ? CurrentDashaParyantardashaResponse.fromJson(json['response']) : null;
  }
  num? status;
  CurrentDashaParyantardashaResponse? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    return map;
  }

}

class CurrentDashaParyantardashaResponse {
  CurrentDashaParyantardashaResponse({
    this.paryantardasha});

  CurrentDashaParyantardashaResponse.fromJson(dynamic json) {
    if (json['paryantardasha'] != null) {
      paryantardasha = [];
      json['paryantardasha'].forEach((v) {
        paryantardasha?.add(CurrentParyantardasha.fromJson(v));
      });
    }
  }
  List<CurrentParyantardasha>? paryantardasha;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (paryantardasha != null) {
      map['paryantardasha'] = paryantardasha?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CurrentParyantardasha {
  CurrentParyantardasha({
    this.name,
    this.key,
    this.start,
    this.end,});

  CurrentParyantardasha.fromJson(dynamic json) {
    name = json['name'];
    key = json['key'];
    start = json['start'];
    end = json['end'];
  }
  String? name;
  String? key;
  String? start;
  String? end;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['key'] = key;
    map['start'] = start;
    map['end'] = end;
    return map;
  }

}

//Shookshamadasha
class CurrentDashaShookshamadasha {
  CurrentDashaShookshamadasha({
    this.status,
    this.response,});

  CurrentDashaShookshamadasha.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'] != null ? CurrentDashaShookshamadashaResponse.fromJson(json['response']) : null;
  }
  num? status;
  CurrentDashaShookshamadashaResponse? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    return map;
  }

}

class CurrentDashaShookshamadashaResponse {
  CurrentDashaShookshamadashaResponse({
    this.shookshamadasha});

  CurrentDashaShookshamadashaResponse.fromJson(dynamic json) {
    if (json['shookshamadasha'] != null) {
      shookshamadasha = [];
      json['shookshamadasha'].forEach((v) {
        shookshamadasha?.add(CurrentShookshamadasha.fromJson(v));
      });
    }
  }
  List<CurrentShookshamadasha>? shookshamadasha;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (shookshamadasha != null) {
      map['shookshamadasha'] = shookshamadasha?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CurrentShookshamadasha {
  CurrentShookshamadasha({
    this.name,
    this.key,
    this.start,
    this.end,});

  CurrentShookshamadasha.fromJson(dynamic json) {
    name = json['name'];
    key = json['key'];
    start = json['start'];
    end = json['end'];
  }
  String? name;
  String? key;
  String? start;
  String? end;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['key'] = key;
    map['start'] = start;
    map['end'] = end;
    return map;
  }

}

//Pranadasha
class CurrentDashaPranadasha {
  CurrentDashaPranadasha({
    this.status,
    this.response,});

  CurrentDashaPranadasha.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'] != null ? CurrentDashaPranadashaResponse.fromJson(json['response']) : null;
  }
  num? status;
  CurrentDashaPranadashaResponse? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    return map;
  }

}

class CurrentDashaPranadashaResponse {
  CurrentDashaPranadashaResponse({
    this.pranadasha});

  CurrentDashaPranadashaResponse.fromJson(dynamic json) {
    if (json['pranadasha'] != null) {
      pranadasha = [];
      json['pranadasha'].forEach((v) {
        pranadasha?.add(CurrentPranadasha.fromJson(v));
      });
    }
  }
  List<CurrentPranadasha>? pranadasha;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (pranadasha != null) {
      map['pranadasha'] = pranadasha?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CurrentPranadasha {
  CurrentPranadasha({
    this.name,
    this.key,
    this.start,
    this.end,});

  CurrentPranadasha.fromJson(dynamic json) {
    name = json['name'];
    key = json['key'];
    start = json['start'];
    end = json['end'];
  }
  String? name;
  String? key;
  String? start;
  String? end;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['key'] = key;
    map['start'] = start;
    map['end'] = end;
    return map;
  }

}