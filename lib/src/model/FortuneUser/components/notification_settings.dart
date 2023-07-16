
class NotificationSettings {
  bool surpriseNotification;
  bool fortuneReadyNotification;
  bool dailyNews;

  NotificationSettings({
    required this.surpriseNotification,
    required this.fortuneReadyNotification,
    required this.dailyNews,
  });

  factory NotificationSettings.fromJson(Map<String, dynamic> json) => NotificationSettings(
        surpriseNotification: json["surpriseNotification"],
        fortuneReadyNotification: json["fortuneReadyNotification"],
        dailyNews: json["dailyNews"],
      );

  Map<String, dynamic> toJson() => {
        "surpriseNotification": surpriseNotification,
        "fortuneReadyNotification": fortuneReadyNotification,
        "dailyNews": dailyNews,
      };
}