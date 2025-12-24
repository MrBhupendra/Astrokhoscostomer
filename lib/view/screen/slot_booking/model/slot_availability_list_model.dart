class SlotAvailabilityListModel {
  SlotAvailabilityListModel({
      this.status, 
      this.data, 
      this.msg,});

  SlotAvailabilityListModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SlotAvailabilityListData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  List<SlotAvailabilityListData>? data;
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

class SlotAvailabilityListData {
  SlotAvailabilityListData({
      this.id, 
      this.astrologerUniId, 
      this.startTime, 
      this.endTime, 
      this.slotDate, 
      this.perSlotDuration, 
      this.perSlotBreak, 
      this.numberOfSlot, 
      this.price, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.slotList,});

  SlotAvailabilityListData.fromJson(dynamic json) {
    id = json['id'];
    astrologerUniId = json['astrologer_uni_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    slotDate = json['slot_date'];
    perSlotDuration = json['per_slot_duration'];
    perSlotBreak = json['per_slot_break'];
    numberOfSlot = json['number_of_slot'];
    price = json['price'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['slot_list'] != null) {
      slotList = [];
      json['slot_list'].forEach((v) {
        slotList?.add(SlotList.fromJson(v));
      });
    }
  }
  num? id;
  String? astrologerUniId;
  String? startTime;
  String? endTime;
  String? slotDate;
  num? perSlotDuration;
  num? perSlotBreak;
  num? numberOfSlot;
  String? price;
  num? status;
  String? createdAt;
  String? updatedAt;
  List<SlotList>? slotList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['astrologer_uni_id'] = astrologerUniId;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['slot_date'] = slotDate;
    map['per_slot_duration'] = perSlotDuration;
    map['per_slot_break'] = perSlotBreak;
    map['number_of_slot'] = numberOfSlot;
    map['price'] = price;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (slotList != null) {
      map['slot_list'] = slotList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class SlotList {
  SlotList({
      this.isBooked, 
      this.timeFrom, 
      this.timeTo, 
      this.slotStart, 
      this.slotEnd, 
      this.serialNo,});

  SlotList.fromJson(dynamic json) {
    isBooked = json['is_booked'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    slotStart = json['slot_start'];
    slotEnd = json['slot_end'];
    serialNo = json['serial_no'];
  }
  num? isBooked;
  String? timeFrom;
  String? timeTo;
  String? slotStart;
  String? slotEnd;
  num? serialNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_booked'] = isBooked;
    map['time_from'] = timeFrom;
    map['time_to'] = timeTo;
    map['slot_start'] = slotStart;
    map['slot_end'] = slotEnd;
    map['serial_no'] = serialNo;
    return map;
  }

}