class KundliAshtakvargaModel {
  KundliAshtakvargaModel({
    this.status,
    this.response,
  });

  KundliAshtakvargaModel.fromJson(dynamic json) {
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
    this.ashtakvargaOrder,
    this.ashtakvargaPoints,
    this.ashtakvargaTotal,
  });

  Response.fromJson(dynamic json) {
    ashtakvargaOrder = json['ashtakvarga_order'] != null ? json['ashtakvarga_order'].cast<String>() : [];
    ashtakvargaPoints = json['ashtakvarga_points'] != null
        ? List<List<int>>.from(json['ashtakvarga_points'].map((dynamic e) =>
    List<int>.from(e.map((dynamic i) => i))))
        : [];
    ashtakvargaTotal = json['ashtakvarga_total'] != null ? json['ashtakvarga_total'].cast<int>() : [];
  }

  List<String>? ashtakvargaOrder;
  List<List<int>>? ashtakvargaPoints;
  List<int>? ashtakvargaTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ashtakvarga_order'] = ashtakvargaOrder;
    map['ashtakvarga_points'] = ashtakvargaPoints;
    map['ashtakvarga_total'] = ashtakvargaTotal;
    return map;
  }
}
