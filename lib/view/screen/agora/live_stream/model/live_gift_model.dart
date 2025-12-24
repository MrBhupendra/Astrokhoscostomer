class LiveGiftModel {
  LiveGiftModel({
    this.senderUniId,
    this.name,
    this.profileImageUrl,
    this.date,
    this.giftName,
    this.giftImageUrl,
    this.giftPrice,
  });

  LiveGiftModel.fromJson(dynamic json) {
    senderUniId = json['senderUniId'];
    name = json['name'];
    profileImageUrl = json['profileImageUrl'];
    date = json['date'];
    giftName = json['giftName'];
    giftImageUrl = json['giftImageUrl'];
    giftPrice = json['giftPrice'];
  }

  String? senderUniId;
  String? name;
  String? profileImageUrl;
  String? date;
  String? giftName;
  String? giftImageUrl;
  String? giftPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['senderUniId'] = senderUniId;
    map['name'] = name;
    map['profileImageUrl'] = profileImageUrl;
    map['date'] = date;
    map['giftName'] = giftName;
    map['giftImageUrl'] = giftImageUrl;
    map['giftPrice'] = giftPrice;
    return map;
  }
}
