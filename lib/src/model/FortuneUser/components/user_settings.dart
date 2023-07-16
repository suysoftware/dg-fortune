import 'package:dg_fortune/src/enums/theme_type_enum.dart';

import 'notification_settings.dart';

class UserSettings {
  NotificationSettings notificationSettings;
  ThemeType themeType;

  UserSettings({
    required this.notificationSettings,
    required this.themeType,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
        notificationSettings: NotificationSettings.fromJson(json["notificationSettings"]),
        themeType: themeTypeEnumFromString(json["themeType"] as String),
      );

  Map<String, dynamic> toJson() => {
        "notificationSettings": notificationSettings.toJson(),
        "themeType": themeType.name.toString(),
      };
}