class KundliMatchData {
  final String boyName;
  final String boyDob;
  final String boyTob;
  final String boyTz;
  final String boyLat;
  final String boyLong;
  final String boyPlace;
  final String gender;
  final String girlName;
  final String girlDob;
  final String girlTob;
  final String girlTz;
  final String girlLat;
  final String girlLong;
  final String girlPlace;
  final String language;

  KundliMatchData(
      this.boyName,
      this.boyDob,
      this.boyTob,
      this.boyTz,
      this.boyLat,
      this.boyLong,
      this.boyPlace,
      this.gender,
      this.girlName,
      this.girlDob,
      this.girlTob,
      this.girlTz,
      this.girlLat,
      this.girlLong,
      this.girlPlace,
      this.language);
}

class KundliData {
  final String name;
  final String dob;
  final String tob;
  final String timeZone;
  final String latitude;
  final String longitude;
  final String place;
  final String language;

  KundliData(this.name, this.dob, this.tob, this.timeZone, this.latitude,
      this.longitude, this.place, this.language);
}
