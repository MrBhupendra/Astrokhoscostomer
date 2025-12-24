class LiveGiftListModel {
  LiveGiftListModel({
    this.status,
    this.walletBalance,
    this.data,
    this.msg,
  });

  LiveGiftListModel.fromJson(dynamic json) {
    status = json['status'];
    walletBalance = json['wallet_balance'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(LiveGiftData.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  num? status;
  num? walletBalance;
  List<LiveGiftData>? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['wallet_balance'] = walletBalance;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }
}

class LiveGiftData {
  LiveGiftData({
    this.id,
    this.giftName,
    this.giftPrice,
    this.giftImage,
  });

  LiveGiftData.fromJson(dynamic json) {
    id = json['id'];
    giftName = json['gift_name'];
    giftPrice = json['gift_price'];
    giftImage = json['gift_image'];
  }

  num? id;
  String? giftName;
  String? giftPrice;
  String? giftImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['gift_name'] = giftName;
    map['gift_price'] = giftPrice;
    map['gift_image'] = giftImage;
    return map;
  }
}
