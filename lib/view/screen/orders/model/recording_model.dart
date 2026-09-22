class RecordingModel {
  RecordingModel({
    this.status,
    this.url,
    this.msg,
  });

  RecordingModel.fromJson(Map<String, dynamic> json) {
    // The API may send `status` as a number or as a string, so parse both.
    status = json['status'] is num
        ? json['status'] as num
        : num.tryParse(json['status']?.toString() ?? '');
    url = json['url']?.toString();
    msg = json['msg']?.toString();
  }

  num? status;
  String? url;
  String? msg;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['status'] = status;
    map['url'] = url;
    map['msg'] = msg;
    return map;
  }
}

