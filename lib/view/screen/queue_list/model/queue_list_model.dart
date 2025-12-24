class QueueListModel {
  QueueListModel({
    this.status,
    this.data,
    this.msg,
  });

  QueueListModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(QueueListData.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  num? status;
  List<QueueListData>? data;
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

class QueueListData {
  QueueListData({
    this.id,
    this.uniqeid,
    this.orderDate,
    this.callType,
    this.status,
    this.displayName,
    this.astrologerUniId,
    this.astroImg,
    this.totalWaitingTime,
    this.totalQueueCount,
    this.myQueueNumber,
    this.myWaitingTime,
    this.inProgressWaiting,
    this.intake,
    this.isVirtualAstrologer,
  });

  QueueListData.fromJson(dynamic json) {
    id = json['notification_id'];
    uniqeid = json['uniqeid'];
    orderDate = json['order_date'];
    callType = json['call_type'];
    status = json['status'];
    displayName = json['display_name'];
    astrologerUniId = json['astrologer_uni_id'];
    astroImg = json['astro_img'];
    totalWaitingTime = json['total_waiting_time'];
    totalQueueCount = json['total_queue_count'];
    myQueueNumber = json['my_queue_number'];
    myWaitingTime = json['my_waiting_time'];
    inProgressWaiting = json['in_progress_waiting'];
    isVirtualAstrologer = json['is_virtual'];
    intake = json['intake'] != null ? Intake.fromJson(json['intake']) : null;
  }

  num? id;
  String? uniqeid;
  String? orderDate;
  String? callType;
  String? status;
  String? displayName;
  String? astrologerUniId;
  String? astroImg;
  String? totalWaitingTime;
  String? totalQueueCount;
  num? myQueueNumber;
  num? myWaitingTime;
  String? inProgressWaiting;
  Intake? intake;
  int? isVirtualAstrologer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['notification_id'] = id;
    map['uniqeid'] = uniqeid;
    map['order_date'] = orderDate;
    map['call_type'] = callType;
    map['status'] = status;
    map['display_name'] = displayName;
    map['astrologer_uni_id'] = astrologerUniId;
    map['astro_img'] = astroImg;
    map['total_waiting_time'] = totalWaitingTime;
    map['total_queue_count'] = totalQueueCount;
    map['my_queue_number'] = myQueueNumber;
    map['my_waiting_time'] = myWaitingTime;
    map['in_progress_waiting'] = inProgressWaiting;
    map['is_virtual'] = isVirtualAstrologer;
    if (intake != null) {
      map['intake'] = intake?.toJson();
    }
    return map;
  }
}

class Intake {
  Intake({
    this.id,
    this.userUniId,
    this.uniqeid,
    this.name,
    this.gender,
    this.dob,
    this.tob,
    this.birthPlace,
    this.maritalStatus,
    this.occupation,
    this.topic,
    this.other,
    this.lat,
    this.long,
    this.intakeType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.partnerName,
    this.partnerGender,
    this.partnerDob,
    this.partnerTob,
    this.partnerBirthPlace,
    this.partnerLat,
    this.partnerLong,
  });

  Intake.fromJson(dynamic json) {
    id = json['id'];
    userUniId = json['user_uni_id'];
    uniqeid = json['uniqeid'];
    name = json['name'];
    gender = json['gender'];
    dob = json['dob'];
    tob = json['tob'];
    birthPlace = json['birth_place'];
    maritalStatus = json['marital_status'];
    occupation = json['occupation'];
    topic = json['topic'];
    other = json['other'];
    lat = json['lat'];
    long = json['long'];
    intakeType = json['intake_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    partnerName = json['partner_name'];
    partnerGender = json['partner_gender'];
    partnerDob = json['partner_dob'];
    partnerTob = json['partner_tob'];
    partnerBirthPlace = json['partner_birth_place'];
    partnerLat = json['partner_lat'];
    partnerLong = json['partner_long'];
  }

  num? id;
  String? userUniId;
  String? uniqeid;
  String? name;
  String? gender;
  String? dob;
  String? tob;
  String? birthPlace;
  String? maritalStatus;
  String? occupation;
  String? topic;
  String? other;
  String? lat;
  String? long;
  String? intakeType;
  num? status;
  String? createdAt;
  String? updatedAt;
  String? partnerName;
  String? partnerGender;
  String? partnerDob;
  String? partnerTob;
  String? partnerBirthPlace;
  String? partnerLat;
  String? partnerLong;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_uni_id'] = userUniId;
    map['uniqeid'] = uniqeid;
    map['name'] = name;
    map['gender'] = gender;
    map['dob'] = dob;
    map['tob'] = tob;
    map['birth_place'] = birthPlace;
    map['marital_status'] = maritalStatus;
    map['occupation'] = occupation;
    map['topic'] = topic;
    map['other'] = other;
    map['lat'] = lat;
    map['long'] = long;
    map['intake_type'] = intakeType;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['partner_name'] = partnerName;
    map['partner_gender'] = partnerGender;
    map['partner_dob'] = partnerDob;
    map['partner_tob'] = partnerTob;
    map['partner_birth_place'] = partnerBirthPlace;
    map['partner_lat'] = partnerLat;
    map['partner_long'] = partnerLong;
    return map;
  }
}
