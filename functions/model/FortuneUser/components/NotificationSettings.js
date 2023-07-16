class NotificationSettings {
    constructor({ surpriseNotification, fortuneReadyNotification, dailyNews }) {
        this.surpriseNotification = surpriseNotification;
        this.fortuneReadyNotification = fortuneReadyNotification;
        this.dailyNews = dailyNews;


    }

    static fromJson(json) {
        return new NotificationSettings({
            surpriseNotification: json["surpriseNotification"],
            fortuneReadyNotification: json["fortuneReadyNotification"],
            dailyNews: json["dailyNews"],
        });
    }

    toJson() {
        return {
            "surpriseNotification": this.surpriseNotification,
            "fortuneReadyNotification": this.fortuneReadyNotification,
            "dailyNews": this.dailyNews,
        };
    }
}
module.exports = { NotificationSettings };


