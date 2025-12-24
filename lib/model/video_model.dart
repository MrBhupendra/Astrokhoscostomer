class VideoModel {
  VideoModel({
      this.status, 
      this.data, 
      this.offset, 
      this.msg,});

  VideoModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(VideoData.fromJson(v));
      });
    }
    offset = json['offset'];
    msg = json['msg'];
  }
  num? status;
  List<VideoData>? data;
  num? offset;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['offset'] = offset;
    map['msg'] = msg;
    return map;
  }

}

class VideoData {
  VideoData({
      this.id, 
      this.title, 
      this.videoType, 
      this.url, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.embedd,});

  VideoData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    videoType = json['video_type'];
    url = json['url'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    embedd = json['embedd'];
  }
  num? id;
  String? title;
  String? videoType;
  String? url;
  num? status;
  String? createdAt;
  String? updatedAt;
  String? embedd;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['video_type'] = videoType;
    map['url'] = url;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['embedd'] = embedd;
    return map;
  }

}