class LoveComaptibilityModel {
  LoveComaptibilityModel({
      this.status, 
      this.response,});

  LoveComaptibilityModel.fromJson(dynamic json) {
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
      this.boySign, 
      this.girlSign, 
      this.score, 
      this.total, 
      this.botResponse,});

  Response.fromJson(dynamic json) {
    boySign = json['boy_sign'];
    girlSign = json['girl_sign'];
    score = json['score'];
    total = json['total'];
    botResponse = json['bot_response'];
  }
  String? boySign;
  String? girlSign;
  num? score;
  num? total;
  String? botResponse;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['boy_sign'] = boySign;
    map['girl_sign'] = girlSign;
    map['score'] = score;
    map['total'] = total;
    map['bot_response'] = botResponse;
    return map;
  }

}