class RechargeData {
  RechargeData({
    this.id,
    this.amount,
    this.currencyCode,
    this.payableAmount,
  });

  RechargeData.fromJson(dynamic json) {
    id = json['id'];
    amount = json['amount'];
    currencyCode = json['currency_code'];
    payableAmount = json['payable_amount'];
  }

  num? id;
  String? amount;
  String? currencyCode;
  num? payableAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['amount'] = amount;
    map['currency_code'] = currencyCode;
    map['payable_amount'] = payableAmount;
    return map;
  }
}