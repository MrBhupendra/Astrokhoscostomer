class ShubhmuhratChoghadiyaModel {
  ShubhmuhratChoghadiyaModel({
      this.status, 
      this.response,});

  ShubhmuhratChoghadiyaModel.fromJson(dynamic json) {
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
      this.day, 
      this.night, 
      this.dayOfWeek,});

  Response.fromJson(dynamic json) {
    if (json['day'] != null) {
      day = [];
      json['day'].forEach((v) {
        day?.add(Day.fromJson(v));
      });
    }
    if (json['night'] != null) {
      night = [];
      json['night'].forEach((v) {
        night?.add(Night.fromJson(v));
      });
    }
    dayOfWeek = json['day_of_week'];
  }
  List<Day>? day;
  List<Night>? night;
  String? dayOfWeek;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (day != null) {
      map['day'] = day?.map((v) => v.toJson()).toList();
    }
    if (night != null) {
      map['night'] = night?.map((v) => v.toJson()).toList();
    }
    map['day_of_week'] = dayOfWeek;
    return map;
  }

}

class Night {
  Night({
      this.start, 
      this.end, 
      this.muhurat, 
      this.type,});

  Night.fromJson(dynamic json) {
    start = json['start'];
    end = json['end'];
    muhurat = json['muhurat'];
    type = json['type'];
  }
  String? start;
  String? end;
  String? muhurat;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['start'] = start;
    map['end'] = end;
    map['muhurat'] = muhurat;
    map['type'] = type;
    return map;
  }

}

class Day {
  Day({
      this.start, 
      this.end, 
      this.muhurat, 
      this.type,});

  Day.fromJson(dynamic json) {
    start = json['start'];
    end = json['end'];
    muhurat = json['muhurat'];
    type = json['type'];
  }
  String? start;
  String? end;
  String? muhurat;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['start'] = start;
    map['end'] = end;
    map['muhurat'] = muhurat;
    map['type'] = type;
    return map;
  }

}