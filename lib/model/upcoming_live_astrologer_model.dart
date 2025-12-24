class UpcomingLiveAstrologerModel {
  UpcomingLiveAstrologerModel({
      this.status, 
      this.msg, 
      this.offset, 
      this.data,});

  UpcomingLiveAstrologerModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(UpcomingLiveAstrologerData.fromJson(v));
      });
    }
  }
  num? status;
  String? msg;
  num? offset;
  List<UpcomingLiveAstrologerData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    map['offset'] = offset;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class UpcomingLiveAstrologerData {
  UpcomingLiveAstrologerData({
      this.id, 
      this.astrologerUniId, 
      this.scheduleType, 
      this.date, 
      this.time, 
      this.topic, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.astrologer,});

  UpcomingLiveAstrologerData.fromJson(dynamic json) {
    id = json['id'];
    astrologerUniId = json['astrologer_uni_id'];
    scheduleType = json['schedule_type'];
    date = json['date'];
    time = json['time'];
    topic = json['topic'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    astrologer = json['astrologer'] != null ? Astrologer.fromJson(json['astrologer']) : null;
  }
  num? id;
  String? astrologerUniId;
  String? scheduleType;
  String? date;
  String? time;
  String? topic;
  num? status;
  String? createdAt;
  String? updatedAt;
  Astrologer? astrologer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['astrologer_uni_id'] = astrologerUniId;
    map['schedule_type'] = scheduleType;
    map['date'] = date;
    map['time'] = time;
    map['topic'] = topic;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (astrologer != null) {
      map['astrologer'] = astrologer?.toJson();
    }
    return map;
  }

}

class Astrologer {
  Astrologer({
      this.id, 
      this.astrologerUniId, 
      this.displayName, 
      this.slug, 
      this.astroImg,});

  Astrologer.fromJson(dynamic json) {
    id = json['id'];
    astrologerUniId = json['astrologer_uni_id'];
    displayName = json['display_name'];
    slug = json['slug'];
    astroImg = json['astro_img'];
  }
  num? id;
  String? astrologerUniId;
  String? displayName;
  String? slug;
  String? astroImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['astrologer_uni_id'] = astrologerUniId;
    map['display_name'] = displayName;
    map['slug'] = slug;
    map['astro_img'] = astroImg;
    return map;
  }

}