class UserManifest {
    constructor({ manifestText, manifestDate, manifestNo }) {

        this.manifestText = manifestText,
            this.manifestDate = manifestDate,
            this.manifestNo = manifestNo
    }

    static fromJson(json) {
        return new UserManifest({
            manifestText: json["manifestText"],
            manifestDate: json["manifestDate"],
            manifestNo: json["manifestNo"],


        });
    }

    toJson() {
        return {
            "manifestText": this.manifestText,
            "manifestDate": this.manifestDate,
            "manifestNo": this.manifestNo,
        };
    }
}
module.exports = { UserManifest };


