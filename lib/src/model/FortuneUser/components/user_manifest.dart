import 'package:cloud_firestore/cloud_firestore.dart';

class UserManifest {
  String manifestText;
  Timestamp manifestDate;
  String manifestNo;

  UserManifest({
    required this.manifestText,
    required this.manifestDate,
    required this.manifestNo,
  });

  factory UserManifest.fromJson(Map<String, dynamic> json) => UserManifest(
        manifestText: json["manifestText"],
        manifestDate: json["manifestDate"] as Timestamp,
        manifestNo: json["manifestNo"],
      );

  Map<String, dynamic> toJson() => {
        "manifestText": manifestText,
        "manifestDate": manifestDate,
        "manifestNo": manifestNo,
      };
}