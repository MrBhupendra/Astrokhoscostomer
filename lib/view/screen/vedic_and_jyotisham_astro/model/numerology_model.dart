class NumerologyModel {
  NumerologyModel({
      this.status, 
      this.response,});

  NumerologyModel.fromJson(dynamic json) {
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
      this.destiny, 
      this.personality, 
      this.attitude, 
      this.character, 
      this.soul, 
      this.agenda, 
      this.purpose,});

  Response.fromJson(dynamic json) {
    destiny = json['destiny'] != null ? Destiny.fromJson(json['destiny']) : null;
    personality = json['personality'] != null ? Personality.fromJson(json['personality']) : null;
    attitude = json['attitude'] != null ? Attitude.fromJson(json['attitude']) : null;
    character = json['character'] != null ? Character.fromJson(json['character']) : null;
    soul = json['soul'] != null ? Soul.fromJson(json['soul']) : null;
    agenda = json['agenda'] != null ? Agenda.fromJson(json['agenda']) : null;
    purpose = json['purpose'] != null ? Purpose.fromJson(json['purpose']) : null;
  }
  Destiny? destiny;
  Personality? personality;
  Attitude? attitude;
  Character? character;
  Soul? soul;
  Agenda? agenda;
  Purpose? purpose;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (destiny != null) {
      map['destiny'] = destiny?.toJson();
    }
    if (personality != null) {
      map['personality'] = personality?.toJson();
    }
    if (attitude != null) {
      map['attitude'] = attitude?.toJson();
    }
    if (character != null) {
      map['character'] = character?.toJson();
    }
    if (soul != null) {
      map['soul'] = soul?.toJson();
    }
    if (agenda != null) {
      map['agenda'] = agenda?.toJson();
    }
    if (purpose != null) {
      map['purpose'] = purpose?.toJson();
    }
    return map;
  }

}

class Purpose {
  Purpose({
      this.title, 
      this.category, 
      this.number, 
      this.master, 
      this.meaning, 
      this.description,});

  Purpose.fromJson(dynamic json) {
    title = json['title'];
    category = json['category'];
    number = json['number'];
    master = json['master'];
    meaning = json['meaning'];
    description = json['description'];
  }
  String? title;
  String? category;
  String? number;
  bool? master;
  String? meaning;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['category'] = category;
    map['number'] = number;
    map['master'] = master;
    map['meaning'] = meaning;
    map['description'] = description;
    return map;
  }

}

class Agenda {
  Agenda({
      this.title, 
      this.category, 
      this.number, 
      this.master, 
      this.meaning, 
      this.description,});

  Agenda.fromJson(dynamic json) {
    title = json['title'];
    category = json['category'];
    number = json['number'];
    master = json['master'];
    meaning = json['meaning'];
    description = json['description'];
  }
  String? title;
  String? category;
  String? number;
  bool? master;
  String? meaning;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['category'] = category;
    map['number'] = number;
    map['master'] = master;
    map['meaning'] = meaning;
    map['description'] = description;
    return map;
  }

}

class Soul {
  Soul({
      this.title, 
      this.category, 
      this.number, 
      this.master, 
      this.meaning, 
      this.description,});

  Soul.fromJson(dynamic json) {
    title = json['title'];
    category = json['category'];
    number = json['number'];
    master = json['master'];
    meaning = json['meaning'];
    description = json['description'];
  }
  String? title;
  String? category;
  String? number;
  bool? master;
  String? meaning;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['category'] = category;
    map['number'] = number;
    map['master'] = master;
    map['meaning'] = meaning;
    map['description'] = description;
    return map;
  }

}

class Character {
  Character({
      this.title, 
      this.category, 
      this.number, 
      this.master, 
      this.meaning, 
      this.description,});

  Character.fromJson(dynamic json) {
    title = json['title'];
    category = json['category'];
    number = json['number'];
    master = json['master'];
    meaning = json['meaning'];
    description = json['description'];
  }
  String? title;
  String? category;
  String? number;
  bool? master;
  String? meaning;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['category'] = category;
    map['number'] = number;
    map['master'] = master;
    map['meaning'] = meaning;
    map['description'] = description;
    return map;
  }

}

class Attitude {
  Attitude({
      this.title, 
      this.category, 
      this.number, 
      this.master, 
      this.meaning, 
      this.description,});

  Attitude.fromJson(dynamic json) {
    title = json['title'];
    category = json['category'];
    number = json['number'];
    master = json['master'];
    meaning = json['meaning'];
    description = json['description'];
  }
  String? title;
  String? category;
  String? number;
  bool? master;
  String? meaning;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['category'] = category;
    map['number'] = number;
    map['master'] = master;
    map['meaning'] = meaning;
    map['description'] = description;
    return map;
  }

}

class Personality {
  Personality({
      this.title, 
      this.category, 
      this.number, 
      this.master, 
      this.meaning, 
      this.description,});

  Personality.fromJson(dynamic json) {
    title = json['title'];
    category = json['category'];
    number = json['number'];
    master = json['master'];
    meaning = json['meaning'];
    description = json['description'];
  }
  String? title;
  String? category;
  String? number;
  bool? master;
  String? meaning;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['category'] = category;
    map['number'] = number;
    map['master'] = master;
    map['meaning'] = meaning;
    map['description'] = description;
    return map;
  }

}

class Destiny {
  Destiny({
      this.title, 
      this.category, 
      this.number, 
      this.master, 
      this.meaning, 
      this.description,});

  Destiny.fromJson(dynamic json) {
    title = json['title'];
    category = json['category'];
    number = json['number'];
    master = json['master'];
    meaning = json['meaning'];
    description = json['description'];
  }
  String? title;
  String? category;
  String? number;
  bool? master;
  String? meaning;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['category'] = category;
    map['number'] = number;
    map['master'] = master;
    map['meaning'] = meaning;
    map['description'] = description;
    return map;
  }

}