class KundliFriendshipFoldTable {
  KundliFriendshipFoldTable({
    this.sun,
    this.moon,
    this.mars,
    this.mercury,
    this.jupiter,
    this.venus,
    this.saturn,});

  KundliFriendshipFoldTable.fromJson(dynamic json) {
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
    this.intimateFriend,
    this.friends,
    this.neutral,
    this.enemies,
    this.bitterEnemy,});

  Saturn.fromJson(dynamic json) {
    intimateFriend = json['IntimateFriend'] != null ? json['IntimateFriend'].cast<String>() : [];
    friends = json['Friends'] != null ? json['Friends'].cast<String>() : [];
    neutral = json['Neutral'] != null ? json['Neutral'].cast<String>() : [];
    enemies = json['Enemies'] != null ? json['Enemies'].cast<String>() : [];
    bitterEnemy = json['BitterEnemy'] != null ? json['BitterEnemy'].cast<String>() : [];
  }
  List<String>? intimateFriend;
  List<String>? friends;
  List<String>? neutral;
  List<String>? enemies;
  List<String>? bitterEnemy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IntimateFriend'] = intimateFriend;
    map['Friends'] = friends;
    map['Neutral'] = neutral;
    map['Enemies'] = enemies;
    map['BitterEnemy'] = bitterEnemy;
    return map;
  }

}

class Venus {
  Venus({
    this.intimateFriend,
    this.friends,
    this.neutral,
    this.enemies,
    this.bitterEnemy,});

  Venus.fromJson(dynamic json) {
    intimateFriend = json['IntimateFriend'] != null ? json['IntimateFriend'].cast<String>() : [];
    friends = json['Friends'] != null ? json['Friends'].cast<String>() : [];
    neutral = json['Neutral'] != null ? json['Neutral'].cast<String>() : [];
    enemies = json['Enemies'] != null ? json['Enemies'].cast<String>() : [];
    bitterEnemy = json['BitterEnemy'] != null ? json['BitterEnemy'].cast<String>() : [];
  }
  List<String>? intimateFriend;
  List<String>? friends;
  List<String>? neutral;
  List<String>? enemies;
  List<String>? bitterEnemy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IntimateFriend'] = intimateFriend;
    map['Friends'] = friends;
    map['Neutral'] = neutral;
    map['Enemies'] = enemies;
    map['BitterEnemy'] = bitterEnemy;
    return map;
  }

}

class Jupiter {
  Jupiter({
    this.intimateFriend,
    this.friends,
    this.neutral,
    this.enemies,
    this.bitterEnemy,});

  Jupiter.fromJson(dynamic json) {
    intimateFriend = json['IntimateFriend'] != null ? json['IntimateFriend'].cast<String>() : [];
    friends = json['Friends'] != null ? json['Friends'].cast<String>() : [];
    neutral = json['Neutral'] != null ? json['Neutral'].cast<String>() : [];
    enemies = json['Enemies'] != null ? json['Enemies'].cast<String>() : [];
    bitterEnemy = json['BitterEnemy'] != null ? json['BitterEnemy'].cast<String>() : [];
  }
  List<String>? intimateFriend;
  List<String>? friends;
  List<String>? neutral;
  List<String>? enemies;
  List<String>? bitterEnemy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IntimateFriend'] = intimateFriend;
    map['Friends'] = friends;
    map['Neutral'] = neutral;
    map['Enemies'] = enemies;
    map['BitterEnemy'] = bitterEnemy;
    return map;
  }

}

class Mercury {
  Mercury({
    this.intimateFriend,
    this.friends,
    this.neutral,
    this.enemies,
    this.bitterEnemy,});

  Mercury.fromJson(dynamic json) {
    intimateFriend = json['IntimateFriend'] != null ? json['IntimateFriend'].cast<String>() : [];
    friends = json['Friends'] != null ? json['Friends'].cast<String>() : [];
    neutral = json['Neutral'] != null ? json['Neutral'].cast<String>() : [];
    enemies = json['Enemies'] != null ? json['Enemies'].cast<String>() : [];
    bitterEnemy = json['BitterEnemy'] != null ? json['BitterEnemy'].cast<String>() : [];
  }
  List<String>? intimateFriend;
  List<String>? friends;
  List<String>? neutral;
  List<String>? enemies;
  List<String>? bitterEnemy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IntimateFriend'] = intimateFriend;
    map['Friends'] = friends;
    map['Neutral'] = neutral;
    map['Enemies'] = enemies;
    map['BitterEnemy'] = bitterEnemy;
    return map;
  }

}

class Mars {
  Mars({
    this.intimateFriend,
    this.friends,
    this.neutral,
    this.enemies,
    this.bitterEnemy,});

  Mars.fromJson(dynamic json) {
    intimateFriend = json['IntimateFriend'] != null ? json['IntimateFriend'].cast<String>() : [];
    friends = json['Friends'] != null ? json['Friends'].cast<String>() : [];
    neutral = json['Neutral'] != null ? json['Neutral'].cast<String>() : [];
    enemies = json['Enemies'] != null ? json['Enemies'].cast<String>() : [];
    bitterEnemy = json['BitterEnemy'] != null ? json['BitterEnemy'].cast<String>() : [];
  }
  List<String>? intimateFriend;
  List<String>? friends;
  List<String>? neutral;
  List<String>? enemies;
  List<String>? bitterEnemy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IntimateFriend'] = intimateFriend;
    map['Friends'] = friends;
    map['Neutral'] = neutral;
    map['Enemies'] = enemies;
    map['BitterEnemy'] = bitterEnemy;
    return map;
  }

}

class Moon {
  Moon({
    this.intimateFriend,
    this.friends,
    this.neutral,
    this.enemies,
    this.bitterEnemy,});

  Moon.fromJson(dynamic json) {
    intimateFriend = json['IntimateFriend'] != null ? json['IntimateFriend'].cast<String>() : [];
    friends = json['Friends'] != null ? json['Friends'].cast<String>() : [];
    neutral = json['Neutral'] != null ? json['Neutral'].cast<String>() : [];
    enemies = json['Enemies'] != null ? json['Enemies'].cast<String>() : [];
    bitterEnemy = json['BitterEnemy'] != null ? json['BitterEnemy'].cast<String>() : [];
  }
  List<String>? intimateFriend;
  List<String>? friends;
  List<String>? neutral;
  List<String>? enemies;
  List<String>? bitterEnemy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IntimateFriend'] = intimateFriend;
    map['Friends'] = friends;
    map['Neutral'] = neutral;
    map['Enemies'] = enemies;
    map['BitterEnemy'] = bitterEnemy;
    return map;
  }

}

class Sun {
  Sun({
    this.intimateFriend,
    this.friends,
    this.neutral,
    this.enemies,
    this.bitterEnemy,});

  Sun.fromJson(dynamic json) {
    intimateFriend = json['IntimateFriend'] != null ? json['IntimateFriend'].cast<String>() : [];
    friends = json['Friends'] != null ? json['Friends'].cast<String>() : [];
    neutral = json['Neutral'] != null ? json['Neutral'].cast<String>() : [];
    enemies = json['Enemies'] != null ? json['Enemies'].cast<String>() : [];
    bitterEnemy = json['BitterEnemy'] != null ? json['BitterEnemy'].cast<String>() : [];
  }
  List<String>? intimateFriend;
  List<String>? friends;
  List<String>? neutral;
  List<String>? enemies;
  List<String>? bitterEnemy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IntimateFriend'] = intimateFriend;
    map['Friends'] = friends;
    map['Neutral'] = neutral;
    map['Enemies'] = enemies;
    map['BitterEnemy'] = bitterEnemy;
    return map;
  }

}