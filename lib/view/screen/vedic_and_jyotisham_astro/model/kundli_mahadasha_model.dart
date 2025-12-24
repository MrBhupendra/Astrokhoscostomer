class KundliMahadashaModel {
  KundliMahadashaModel({
    this.status,
    this.response,});

  KundliMahadashaModel.fromJson(dynamic json) {
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
    this.mahadasha,
    this.antardasha,
    this.paryantardasha,
    this.shookshamadasha,
    this.pranadasha,
    this.orderNames,
    this.orderOfDashas,});

  Response.fromJson(dynamic json) {
    mahadasha = json['mahadasha'] != null ? Mahadasha.fromJson(json['mahadasha']) : null;
    antardasha = json['antardasha'] != null ? Antardasha.fromJson(json['antardasha']) : null;
    paryantardasha = json['paryantardasha'] != null ? Paryantardasha.fromJson(json['paryantardasha']) : null;
    shookshamadasha = json['Shookshamadasha'] != null ? Shookshamadasha.fromJson(json['Shookshamadasha']) : null;
    pranadasha = json['Pranadasha'] != null ? Pranadasha.fromJson(json['Pranadasha']) : null;
    orderNames = json['order_names'] != null ? json['order_names'].cast<String>() : [];
    orderOfDashas = json['order_of_dashas'] != null ? OrderOfDashas.fromJson(json['order_of_dashas']) : null;
  }
  Mahadasha? mahadasha;
  Antardasha? antardasha;
  Paryantardasha? paryantardasha;
  Shookshamadasha? shookshamadasha;
  Pranadasha? pranadasha;
  List<String>? orderNames;
  OrderOfDashas? orderOfDashas;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (mahadasha != null) {
      map['mahadasha'] = mahadasha?.toJson();
    }
    if (antardasha != null) {
      map['antardasha'] = antardasha?.toJson();
    }
    if (paryantardasha != null) {
      map['paryantardasha'] = paryantardasha?.toJson();
    }
    if (shookshamadasha != null) {
      map['Shookshamadasha'] = shookshamadasha?.toJson();
    }
    if (pranadasha != null) {
      map['Pranadasha'] = pranadasha?.toJson();
    }
    map['order_names'] = orderNames;
    if (orderOfDashas != null) {
      map['order_of_dashas'] = orderOfDashas?.toJson();
    }
    return map;
  }

}

class OrderOfDashas {
  OrderOfDashas({
    this.major,
    this.minor,
    this.subMinor,
    this.subSubMinor,});

  OrderOfDashas.fromJson(dynamic json) {
    major = json['major'] != null ? Major.fromJson(json['major']) : null;
    minor = json['minor'] != null ? Minor.fromJson(json['minor']) : null;
    subMinor = json['sub_minor'] != null ? SubMinor.fromJson(json['sub_minor']) : null;
    subSubMinor = json['sub_sub_minor'] != null ? SubSubMinor.fromJson(json['sub_sub_minor']) : null;
  }
  Major? major;
  Minor? minor;
  SubMinor? subMinor;
  SubSubMinor? subSubMinor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (major != null) {
      map['major'] = major?.toJson();
    }
    if (minor != null) {
      map['minor'] = minor?.toJson();
    }
    if (subMinor != null) {
      map['sub_minor'] = subMinor?.toJson();
    }
    if (subSubMinor != null) {
      map['sub_sub_minor'] = subSubMinor?.toJson();
    }
    return map;
  }

}

class SubSubMinor {
  SubSubMinor({
    this.name,
    this.start,
    this.end,});

  SubSubMinor.fromJson(dynamic json) {
    name = json['name'];
    start = json['start'];
    end = json['end'];
  }
  String? name;
  String? start;
  String? end;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['start'] = start;
    map['end'] = end;
    return map;
  }

}

class SubMinor {
  SubMinor({
    this.name,
    this.start,
    this.end,});

  SubMinor.fromJson(dynamic json) {
    name = json['name'];
    start = json['start'];
    end = json['end'];
  }
  String? name;
  String? start;
  String? end;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['start'] = start;
    map['end'] = end;
    return map;
  }

}

class Minor {
  Minor({
    this.name,
    this.start,
    this.end,});

  Minor.fromJson(dynamic json) {
    name = json['name'];
    start = json['start'];
    end = json['end'];
  }
  String? name;
  String? start;
  String? end;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['start'] = start;
    map['end'] = end;
    return map;
  }

}

class Major {
  Major({
    this.name,
    this.start,
    this.end,});

  Major.fromJson(dynamic json) {
    name = json['name'];
    start = json['start'];
    end = json['end'];
  }
  String? name;
  String? start;
  String? end;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['start'] = start;
    map['end'] = end;
    return map;
  }

}

class Pranadasha {
  Pranadasha({
    this.name,
    this.start,
    this.end,});

  Pranadasha.fromJson(dynamic json) {
    name = json['name'];
    start = json['start'];
    end = json['end'];
  }
  String? name;
  String? start;
  String? end;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['start'] = start;
    map['end'] = end;
    return map;
  }

}

class Shookshamadasha {
  Shookshamadasha({
    this.name,
    this.start,
    this.end,});

  Shookshamadasha.fromJson(dynamic json) {
    name = json['name'];
    start = json['start'];
    end = json['end'];
  }
  String? name;
  String? start;
  String? end;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['start'] = start;
    map['end'] = end;
    return map;
  }

}

class Paryantardasha {
  Paryantardasha({
    this.name,
    this.start,
    this.end,});

  Paryantardasha.fromJson(dynamic json) {
    name = json['name'];
    start = json['start'];
    end = json['end'];
  }
  String? name;
  String? start;
  String? end;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['start'] = start;
    map['end'] = end;
    return map;
  }

}

class Antardasha {
  Antardasha({
    this.name,
    this.start,
    this.end,});

  Antardasha.fromJson(dynamic json) {
    name = json['name'];
    start = json['start'];
    end = json['end'];
  }
  String? name;
  String? start;
  String? end;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['start'] = start;
    map['end'] = end;
    return map;
  }

}

class Mahadasha {
  Mahadasha({
    this.name,
    this.start,
    this.end,});

  Mahadasha.fromJson(dynamic json) {
    name = json['name'];
    start = json['start'];
    end = json['end'];
  }
  String? name;
  String? start;
  String? end;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['start'] = start;
    map['end'] = end;
    return map;
  }

}