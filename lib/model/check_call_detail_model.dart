class CheckCallDetailModel {
  CheckCallDetailModel({
      this.status, 
      this.msg, 
      this.data,});

  CheckCallDetailModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? status;
  String? msg;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.price, 
      this.actualPrice,
      this.time,
      this.isSubscriptionApplied,
      this.busyStatus,
      this.totalWaitingTime, 
      this.totalQueueCount, 
      this.second, 
      this.minutes, 
      this.calltype, 
      this.userWalletAmt, 
      this.firstCallFreeMinutes,});

  Data.fromJson(dynamic json) {
    price = json['price'];
    actualPrice = json['actual_price'];
    time = json['time'];
    isSubscriptionApplied = json['is_subscription_applied'];
    busyStatus = json['busy_status'];
    totalWaitingTime = json['total_waiting_time'];
    totalQueueCount = json['total_queue_count'];
    second = json['second'];
    minutes = json['minutes'];
    calltype = json['calltype'];
    userWalletAmt = json['user_wallet_amt'];
    firstCallFreeMinutes = json['first_call_free_minutes'];
  }
  num? price;
  num? actualPrice;
  num? time;
  num? isSubscriptionApplied;
  num? busyStatus;
  String? totalWaitingTime;
  String? totalQueueCount;
  num? second;
  num? minutes;
  String? calltype;
  num? userWalletAmt;
  String? firstCallFreeMinutes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = price;
    map['actual_price'] = actualPrice;
    map['time'] = time;
    map['is_subscription_applied'] = isSubscriptionApplied;
    map['busy_status'] = busyStatus;
    map['total_waiting_time'] = totalWaitingTime;
    map['total_queue_count'] = totalQueueCount;
    map['second'] = second;
    map['minutes'] = minutes;
    map['calltype'] = calltype;
    map['user_wallet_amt'] = userWalletAmt;
    map['first_call_free_minutes'] = firstCallFreeMinutes;
    return map;
  }

}