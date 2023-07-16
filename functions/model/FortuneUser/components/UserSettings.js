const { NotificationSettings } = require('./NotificationSettings');



class UserSettings {
    constructor({ notificationSettings, themeType }) {
        this.notificationSettings = notificationSettings;
        this.themeType = themeType;


    }

    static fromJson(json) {
        return new UserSettings({
            notificationSettings: NotificationSettings.fromJson(json["notificationSettings"]),
            themeType: json["themeType"]
        });
    }

    toJson() {
        return {
            "notificationSettings": this.notificationSettings.toJson(),
            "themeType": this.themeType,
        };
    }
}
module.exports = { UserSettings };


