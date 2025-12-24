class LiveRequestModel {
  LiveRequestModel({
    this.senderUid,
    this.senderUniId,
    this.orderId,
    this.name,
    this.profileImageUrl,
    this.date,
    this.duration,
    this.isAccepted,
    this.isEnd,
    this.isVideoCall,
    this.callType,
    this.timestamp
  });

  LiveRequestModel.fromJson(dynamic json) {
    senderUid = json['senderUid'];
    senderUniId = json['senderUniId'];
    orderId = json['orderId'];
    name = json['name'];
    profileImageUrl = json['profileImageUrl'];
    date = json['date'];
    duration = json['duration'];
    isAccepted = json['isAccepted'];
    isEnd = json['isEnd'];
    isVideoCall = json['isVideoCall'];
    callType = json['callType'];
    timestamp = json['timestamp'];
  }

  String? senderUid;
  String? senderUniId;
  String? orderId;
  String? name;
  String? profileImageUrl;
  String? date;
  num? duration;
  bool? isAccepted;
  bool? isEnd;
  bool? isVideoCall;
  String? callType;
  dynamic timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['senderUid'] = senderUid;
    map['senderUniId'] = senderUniId;
    map['orderId'] = orderId;
    map['name'] = name;
    map['profileImageUrl'] = profileImageUrl;
    map['date'] = date;
    map['duration'] = duration;
    map['isAccepted'] = isAccepted;
    map['isEnd'] = isEnd;
    map['isVideoCall'] = isVideoCall;
    map['callType'] = callType;
    map['timestamp'] = timestamp;
    return map;
  }
}
