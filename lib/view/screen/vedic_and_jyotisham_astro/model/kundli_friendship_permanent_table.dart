class KundliFriendshipPermanentTable {
  KundliFriendshipPermanentTable({
    this.sun,
    this.moon,
    this.mars,
    this.mercury,
    this.jupiter,
    this.venus,
    this.saturn,});

  KundliFriendshipPermanentTable.fromJson(dynamic json) {
    sun = json['Sun'] != null ? Sun.fromJson(json['Sun']) : null;
    moon = json['Moon'] != null ? Moon.fromJson(json['Moon']) : null;
    mars = json['Mars'] != null ? Mars.fromJson(json['Mars']) : null;
    mercury = json['Mercury'] != null ? Mercury.fromJson(json['Mercury']) : null;
    jupiter = json['Jupiter'] != null ? Jupiter.fromJson(json['Jupiter']) : null;
    venus = json['Venus'] != null ? Venus.fromJson(json['Venus']) : null;
    saturn = json['Saturn'] != null ? Saturn.fromJson(json['Saturn']) : null;
  }
  Sun? sun;
  Moon? moon;
  Mars? mars;
  Mercury? mercury;
  Jupiter? jupiter;
  Venus? venus;
  Saturn? saturn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (sun != null) {
      map['Sun'] = sun?.toJson();
    }
    if (moon != null) {
      map['Moon'] = moon?.toJson();
    }
    if (mars != null) {
      map['Mars'] = mars?.toJson();
    }
    if (mercury != null) {
      map['Mercury'] = mercury?.toJson();
    }
    if (jupiter != null) {
      map['Jupiter'] = jupiter?.toJson();
    }
    if (venus != null) {
      map['Venus'] = venus?.toJson();
    }
    if (saturn != null) {
      map['Saturn'] = saturn?.toJson();
    }
    return map;
  }

}

class Saturn {
  Saturn({
    this.friends,
    this.neutral,
    this.enemies,});

  Saturn.fromJson(dynamic json) {
    friends = json['Friends'] != null ? json['Friends'].cast<String>() : [];
    neutral = json['Neutral'] != null ? json['Neutral'].cast<String>() : [];
    enemies = json['Enemies'] != null ? json['Enemies'].cast<String>() : [];
  }
  List<String>? friends;
  List<String>? neutral;
  List<String>? enemies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Friends'] = friends;
    map['Neutral'] = neutral;
    map['Enemies'] = enemies;
    return map;
  }

}

class Venus {
  Venus({
    this.friends,
    this.neutral,
    this.enemies,});

  Venus.fromJson(dynamic json) {
    friends = json['Friends'] != null ? json['Friends'].cast<String>() : [];
    neutral = json['Neutral'] != null ? json['Neutral'].cast<String>() : [];
    enemies = json['Enemies'] != null ? json['Enemies'].cast<String>() : [];
  }
  List<String>? friends;
  List<String>? neutral;
  List<String>? enemies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Friends'] = friends;
    map['Neutral'] = neutral;
    map['Enemies'] = enemies;
    return map;
  }

}

class Jupiter {
  Jupiter({
    this.friends,
    this.neutral,
    this.enemies,});

  Jupiter.fromJson(dynamic json) {
    friends = json['Friends'] != null ? json['Friends'].cast<String>() : [];
    neutral = json['Neutral'] != null ? json['Neutral'].cast<String>() : [];
    enemies = json['Enemies'] != null ? json['Enemies'].cast<String>() : [];
  }
  List<String>? friends;
  List<String>? neutral;
  List<String>? enemies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Friends'] = friends;
    map['Neutral'] = neutral;
    map['Enemies'] = enemies;
    return map;
  }

}

class Mercury {
  Mercury({
    this.friends,
    this.neutral,
    this.enemies,});

  Mercury.fromJson(dynamic json) {
    friends = json['Friends'] != null ? json['Friends'].cast<String>() : [];
    neutral = json['Neutral'] != null ? json['Neutral'].cast<String>() : [];
    enemies = json['Enemies'] != null ? json['Enemies'].cast<String>() : [];
  }
  List<String>? friends;
  List<String>? neutral;
  List<String>? enemies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Friends'] = friends;
    map['Neutral'] = neutral;
    map['Enemies'] = enemies;
    return map;
  }

}

class Mars {
  Mars({
    this.friends,
    this.neutral,
    this.enemies,});

  Mars.fromJson(dynamic json) {
    friends = json['Friends'] != null ? json['Friends'].cast<String>() : [];
    neutral = json['Neutral'] != null ? json['Neutral'].cast<String>() : [];
    enemies = json['Enemies'] != null ? json['Enemies'].cast<String>() : [];
  }
  List<String>? friends;
  List<String>? neutral;
  List<String>? enemies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Friends'] = friends;
    map['Neutral'] = neutral;
    map['Enemies'] = enemies;
    return map;
  }

}

class Moon {
  Moon({
    this.friends,
    this.neutral,
    this.enemies,});

  Moon.fromJson(dynamic json) {
    friends = json['Friends'] != null ? json['Friends'].cast<String>() : [];
    neutral = json['Neutral'] != null ? json['Neutral'].cast<String>() : [];
    enemies = json['Enemies'] != null ? json['Enemies'].cast<String>() : [];
  }
  List<String>? friends;
  List<String>? neutral;
  List<String>? enemies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Friends'] = friends;
    map['Neutral'] = neutral;
    map['Enemies'] = enemies;
    return map;
  }

}

class Sun {
  Sun({
    this.friends,
    this.neutral,
    this.enemies,});

  Sun.fromJson(dynamic json) {
    friends = json['Friends'] != null ? json['Friends'].cast<String>() : [];
    neutral = json['Neutral'] != null ? json['Neutral'].cast<String>() : [];
    enemies = json['Enemies'] != null ? json['Enemies'].cast<String>() : [];
  }
  List<String>? friends;
  List<String>? neutral;
  List<String>? enemies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Friends'] = friends;
    map['Neutral'] = neutral;
    map['Enemies'] = enemies;
    return map;
  }

}