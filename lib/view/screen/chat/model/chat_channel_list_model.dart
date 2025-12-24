class ChatChannelListModel {
  ChatChannelListModel({
    this.status,
    this.data,
    this.msg,});

  ChatChannelListModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ChatChannelListData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  List<ChatChannelListData>? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class ChatChannelListData {
  ChatChannelListData({
    this.id,
    this.channelName,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.customerImg,
    this.astroImg,
    this.displayName,
    this.userName,
    this.uniqeid,
    this.customerUniId,
    this.astrologerUniId,
    this.isChatAllowed,
  });

  ChatChannelListData.fromJson(dynamic json) {
    id = json['id'];
    channelName = json['channel_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerImg = json['customer_img'];
    astroImg = json['astro_img'];
    displayName = json['display_name'];
    userName = json['user_name'];
    uniqeid = json['uniqeid'];
    customerUniId = json['customer_uni_id'];
    astrologerUniId = json['astrologer_uni_id'];
    isChatAllowed = json['is_chat_allowed'];
  }
  num? id;
  String? channelName;
  num? status;
  String? createdAt;
  String? updatedAt;
  String? customerImg;
  String? astroImg;
  String? displayName;
  String? userName;
  String? uniqeid;
  String? customerUniId;
  String? astrologerUniId;
  int? isChatAllowed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['channel_name'] = channelName;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['customer_img'] = customerImg;
    map['astro_img'] = astroImg;
    map['display_name'] = displayName;
    map['user_name'] = userName;
    map['uniqeid'] = uniqeid;
    map['customer_uni_id'] = customerUniId;
    map['astrologer_uni_id'] = astrologerUniId;
    map['is_chat_allowed'] = isChatAllowed;
    return map;
  }

}