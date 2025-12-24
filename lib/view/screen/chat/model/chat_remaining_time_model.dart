class ChatRemainingTimeModel {
  ChatRemainingTimeModel({
      this.status, 
      this.msg, 
      this.isChatInProgress, 
      this.minutes,
      this.second,
      this.popupAfterDuration,
  });

  ChatRemainingTimeModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    isChatInProgress = json['is_chat_in_progress'];
    minutes = json['minutes'];
    second = json['second'];
    popupAfterDuration = json['popup_after_duration'];
  }
  num? status;
  String? msg;
  num? isChatInProgress;
  num? minutes;
  num? second;
  num? popupAfterDuration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    map['is_chat_in_progress'] = isChatInProgress;
    map['minutes'] = minutes;
    map['second'] = second;
    map['popup_after_duration'] = popupAfterDuration;
    return map;
  }

}