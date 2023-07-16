import 'package:cloud_firestore/cloud_firestore.dart';

class UserAiFortune {
  String fortuneText;
  Timestamp fortuneDate;
  String fortuneNo;

  UserAiFortune({
    required this.fortuneText,
    required this.fortuneDate,
    required this.fortuneNo,
  });

  factory UserAiFortune.fromJson(Map<String, dynamic> json) => UserAiFortune(
        fortuneText: json["fortuneText"],
        fortuneDate: json["fortuneDate"] as Timestamp,
        fortuneNo: json["fortuneNo"],
      );

  Map<String, dynamic> toJson() => {
        "fortuneText": fortuneText,
        "fortuneDate": fortuneDate,
        "fortuneNo": fortuneNo,
      };
}