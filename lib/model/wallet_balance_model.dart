class WalletBalanceModel {
  WalletBalanceModel({
      this.status, 
      this.msg, 
      this.data, 
      this.errorCode,
      this.isAnonymousReview
  });

  WalletBalanceModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'];
    errorCode = json['error_code'];
    isAnonymousReview = json['is_anonymous_review'];
  }
  num? status;
  String? msg;
  num? data;
  num? errorCode;
  num? isAnonymousReview;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    map['data'] = data;
    map['error_code'] = errorCode;
    map['is_anonymous_review'] = isAnonymousReview;
    return map;
  }

}