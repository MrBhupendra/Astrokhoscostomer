import 'kundli_friendship_fold_table.dart';
import 'kundli_friendship_permanent_table.dart';
import 'kundli_friendship_temporary_table.dart';

class KundliFriendModel {
  KundliFriendModel({
      this.status, 
      this.response, 
      this.callsRemaining,});

  KundliFriendModel.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'] != null ? Response.fromJson(json['response']) : null;
    callsRemaining = json['callsRemaining'];
  }
  num? status;
  Response? response;
  num? callsRemaining;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    map['callsRemaining'] = callsRemaining;
    return map;
  }

}

class Response {
  Response({
    this.permanentTable,
    this.temporaryTable,
    this.fiveFoldTable,});

  Response.fromJson(dynamic json) {
    permanentTable = json['permanent_table'] != null ? KundliFriendshipPermanentTable.fromJson(json['permanent_table']) : null;
    temporaryTable = json['temporary_friendship'] != null ? KundliFriendshipTemporaryTable.fromJson(json['temporary_friendship']) : null;
    fiveFoldTable = json['five_fold_friendship'] != null ? KundliFriendshipFoldTable.fromJson(json['five_fold_friendship']) : null;
  }
  KundliFriendshipPermanentTable? permanentTable;
  KundliFriendshipTemporaryTable? temporaryTable;
  KundliFriendshipFoldTable? fiveFoldTable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (permanentTable != null) {
      map['permanent_table'] = permanentTable?.toJson();
    }
    if (temporaryTable != null) {
      map['temporary_friendship'] = temporaryTable?.toJson();
    }
    if (fiveFoldTable != null) {
      map['five_fold_friendship'] = fiveFoldTable?.toJson();
    }
    return map;
  }
}