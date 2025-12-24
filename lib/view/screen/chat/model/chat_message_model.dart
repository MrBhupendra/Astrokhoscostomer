class ChatMessageModel {
  ChatMessageModel({
    this.senderUniId,
    this.name,
    this.text,
    this.profileImageUrl,
    this.date,
    this.fileUrl,
    this.selectedText,
    this.selectedType,
    this.messageType,
  });

  ChatMessageModel.fromJson(dynamic json) {
    senderUniId = json['senderUniId'];
    name = json['name'];
    text = json['text'];
    profileImageUrl = json['profileImageUrl'];
    date = json['date'];
    fileUrl = json['fileUrl'];
    selectedText = json['selectedText'];
    selectedType = json['selectedType'];
    messageType = json['messageType'];
  }

  String? senderUniId;
  String? name;
  String? text;
  String? profileImageUrl;
  String? date;
  String? fileUrl;
  String? selectedText;
  String? selectedType;
  String? messageType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['senderUniId'] = senderUniId;
    map['name'] = name;
    map['text'] = text;
    map['profileImageUrl'] = profileImageUrl;
    map['date'] = date;
    map['fileUrl'] = fileUrl;
    map['selectedText'] = selectedText;
    map['selectedType'] = selectedType;
    map['messageType'] = messageType;
    return map;
  }
}
