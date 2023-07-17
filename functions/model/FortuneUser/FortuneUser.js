const { UserSettings } = require('./components/UserSettings');
const { UserManifest } = require('./components/UserManifest');
const { UserAiFortune } = require('./components/UserAiFortune');
class FortuneUser {
    constructor({ userNo, userName, userManifests, userEmail, userType, userAiFortunes, userNextAiFortuneDate, userMessageToken, userSettings }) {
        this.userNo = userNo;
        this.userName = userName;
        this.userManifests = userManifests;
        this.userEmail = userEmail;
        this.userType = userType;
        this.userAiFortunes = userAiFortunes;
        this.userNextAiFortuneDate = userNextAiFortuneDate;
        this.userMessageToken = userMessageToken;
        this.userSettings = userSettings;
    }

    static fromJson(json) {
        return new FortuneUser({
            userNo: json["userNo"],
            userName: json["userName"],
            userManifests: json["userManifests"], // map each element in the list
            userEmail: json["userEmail"],
            userType: json["userType"],
            userAiFortunes: json["userAiFortunes"], // map each element in the list
            userNextAiFortuneDate: json["userNextAiFortuneDate"],
            userMessageToken: json["userMessageToken"],
            userSettings: UserSettings.fromJson(json["userSettings"]),
        });
    }

    toJson() {
        return {
            userNo: this.userNo,
            userName: this.userName,
            userManifests: this.userManifests.map(manifest => manifest.toJson()), // map each element in the list
            userEmail: this.userEmail,
            userType: this.userType,
            userAiFortunes: this.userAiFortunes.map(fortune => fortune.toJson()), // map each element in the list
            userNextAiFortuneDate: this.userNextAiFortuneDate,
            userMessageToken: this.userMessageToken,
            userSettings: this.userSettings.toJson(),
        }
    };
}
module.exports = { FortuneUser };
