class UserAiFortune {
    constructor({ fortuneText, fortuneDate, fortuneNo }) {
        this.fortuneText = fortuneText,
            this.fortuneDate = fortuneDate,
            this.fortuneNo = fortuneNo
    }

    static fromJson(json) {
        return new UserAiFortune({
            fortuneText: json["fortuneText"],
            fortuneDate: json["fortuneDate"],
            fortuneNo: json["fortuneNo"]
        });
    }

    toJson() {
        return {
            "fortuneText": this.fortuneText,
            "fortuneDate": this.fortuneDate,
            "fortuneNo": this.fortuneNo
        };
    }
}
module.exports = { UserAiFortune };


