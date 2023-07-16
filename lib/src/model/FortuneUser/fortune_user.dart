// To parse this JSON data, do
//
//     final fortuneUser = fortuneUserFromJson(jsonString);

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dg_fortune/src/enums/user_type_enum.dart';
import 'components/user_ai_fortune.dart';
import 'components/user_manifest.dart';
import 'components/user_settings.dart';


List<FortuneUser> fortuneUserFromJson(String str) => List<FortuneUser>.from(json.decode(str).map((x) => FortuneUser.fromJson(x)));

String fortuneUserToJson(List<FortuneUser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FortuneUser {
  //USER UID NO
  late String userNo;
  // USER NAME (OPTIONAL)
  late String userName;
  // USER MANIFESTS (THEIR OWN TEXTS)
  late List<UserManifest> userManifests;
  // USER EMAIL
  late String userEmail;
  // USER TYPE => ANON,STANDART , PREMIUM
  late UserType userType;
  // USER AI FORTUNES (FROM AI FORTUNE GENERATOR)
  late List<UserAiFortune> userAiFortunes;
  // USER NEXT AI FORTUNE DATE (FOR GENERATE NEW AI FORTUNE)
  late Timestamp userNextAiFortuneDate;
  // USER MESSAGE TOKEN (FOR PUSH NOTIFICATIONS)
  late String userMessageToken;
  // USER SETTINGS
  late UserSettings userSettings;

  FortuneUser.withInfo({
    required this.userNo,
    required this.userName,
    required this.userManifests,
    required this.userEmail,
    required this.userType,
    required this.userAiFortunes,
    required this.userNextAiFortuneDate,
    required this.userMessageToken,
    required this.userSettings,
  });

  FortuneUser();

  factory FortuneUser.fromJson(Map<String, dynamic> json) => FortuneUser.withInfo(
        userNo: json["userNo"],
        userName: json["userName"],
        userManifests: List<UserManifest>.from(json["userManifests"].map((x) => UserManifest.fromJson(x))),
        userEmail: json["userEmail"],
        userType: userTypeEnumFromString(json["userType"] as String),
        userAiFortunes: List<UserAiFortune>.from(json["userAiFortunes"].map((x) => UserAiFortune.fromJson(x))),
        userNextAiFortuneDate: json["userNextAiFortuneDate"] as Timestamp,
        userMessageToken: json["userMessageToken"],
        userSettings: UserSettings.fromJson(json["userSettings"]),
      );

  Map<String, dynamic> toJson() => {
        "userNo": userNo,
        "userName": userName,
        "userManifests": List<dynamic>.from(userManifests.map((x) => x.toJson())),
        "userEmail": userEmail,
        "userType": userType.name.toString(),
        "userAiFortunes": List<dynamic>.from(userAiFortunes.map((x) => x.toJson())),
        "userNextAiFortuneDate": userNextAiFortuneDate,
        "userMessageToken": userMessageToken,
        "userSettings": userSettings.toJson(),
      };
}







