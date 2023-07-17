const admin = require("firebase-admin");
const db = admin.firestore();
const auth = admin.auth();


const { FortuneUser } = require('../model/FortuneUser/FortuneUser');
const { NotificationSettings } = require('../model/FortuneUser/components/NotificationSettings');
const { UserSettings } = require('../model/FortuneUser/components/UserSettings');

const { UserManifest } = require('../model/FortuneUser/components/UserManifest');
const { UserAiFortune } = require('../model/FortuneUser/components/UserAiFortune');



//Function Description: This function is used to create a new user in the database.
const accountCreate = async (reqUserEmail, reqUserNo) => {


    var userNo = reqUserNo;

    try {

        var userEmail = reqUserEmail;

        var userAccountCreatedDate = admin.firestore.Timestamp.now();



        const notificationSettings = new NotificationSettings({

            surpriseNotification: true,
            fortuneReadyNotification: true,
            dailyNews: true
        });

        const userSettings = new UserSettings({
            notificationSettings: notificationSettings,
            themeType: "night",
        });

        const userManifest = new UserManifest({
            manifestText: "Welcome to Fortune! You can send your first manifest by clicking the button below.",
            manifestDate: userAccountCreatedDate,
            manifestNo: "welcome"
        });

        const userAiFortune = new UserAiFortune({
            fortuneText: "Welcome to Fortune! You can send your first manifest by clicking the button below.",
            fortuneDate: userAccountCreatedDate,
            fortuneNo: "welcome"
        });

        const fortuneUser = new FortuneUser({
            userNo: userNo,
            userName: "",
            userManifests: [userManifest],
            userEmail: "nomail",
            userType: "anon",
            userAiFortunes: [userAiFortune],
            userNextAiFortuneDate: userAccountCreatedDate,
            userMessageToken: "",
            userSettings: userSettings,

        });




        await db.collection('users').doc(userNo).set(fortuneUser.toJson());
        console.log('Successfully created new user:', userNo);





    } catch (error) {
        console.log('Error deleting user:', error);
        await auth
            .deleteUser(userNo)
            .then(() => {

                console.log('Successfully deleted user');
            })
            .catch((error) => {

                console.log('Error deleting user:', error);
            });

    }

};

module.exports = accountCreate;



