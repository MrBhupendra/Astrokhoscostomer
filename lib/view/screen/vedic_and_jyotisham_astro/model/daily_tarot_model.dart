class DailyTarotModel {
  DailyTarotModel({
      this.status, 
      this.response, 
      this.callsRemaining,});

  DailyTarotModel.fromJson(dynamic json) {
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
      this.name, 
      this.key, 
      this.value, 
      this.description,});

  Response.fromJson(dynamic json) {
    name = json['name'];
    key = json['key'];
    value = json['value'];
    description = json['description'];
  }
  String? name;
  num? key;
  String? value;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['key'] = key;
    map['value'] = value;
    map['description'] = description;
    return map;
  }

}