class ShubhmuhratHoraModel {
  ShubhmuhratHoraModel({
      this.status, 
      this.response,});

  ShubhmuhratHoraModel.fromJson(dynamic json) {
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
      this.horas, 
      this.dayOfWeek,});

  Response.fromJson(dynamic json) {
    if (json['horas'] != null) {
      horas = [];
      json['horas'].forEach((v) {
        horas?.add(Horas.fromJson(v));
      });
    }
    dayOfWeek = json['day_of_week'];
  }
  List<Horas>? horas;
  String? dayOfWeek;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (horas != null) {
      map['horas'] = horas?.map((v) => v.toJson()).toList();
    }
    map['day_of_week'] = dayOfWeek;
    return map;
  }

}

class Horas {
  Horas({
      this.start, 
      this.end, 
      this.hora, 
      this.benefits, 
      this.luckyGem,});

  Horas.fromJson(dynamic json) {
    start = json['start'];
    end = json['end'];
    hora = json['hora'];
    benefits = json['benefits'];
    luckyGem = json['lucky_gem'];
  }
  String? start;
  String? end;
  String? hora;
  String? benefits;
  String? luckyGem;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['start'] = start;
    map['end'] = end;
    map['hora'] = hora;
    map['benefits'] = benefits;
    map['lucky_gem'] = luckyGem;
    return map;
  }

}