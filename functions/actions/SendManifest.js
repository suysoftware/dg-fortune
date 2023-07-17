const admin = require("firebase-admin");
const { v4: uuidv4 } = require('uuid');
const db = admin.firestore();
const auth = admin.auth();

const { UserManifest } = require('../model/FortuneUser/components/UserManifest');




//Function Description: This function is used to create a new user in the database.
const sendManifest = async (req, res, next) => {

    console.log("girdik");
    var userNo = req.body.user_no;
    var manifestMessage = req.body.manifest_message;
    console.log("girdik2");

    var manifestNo = uuidv4();
    console.log(manifestNo);

    const userRef = db.collection('users').doc(userNo);
    var manifestItem = new UserManifest({
        manifestText: manifestMessage,
        manifestDate: admin.firestore.Timestamp.now(),
        manifestNo: manifestNo

    });


    try {

        await db.runTransaction(async (t) => {

            const userGet = await t.get(userRef);
            const userData = userGet.data();

            var userManifests = userData.userManifests;
            await userManifests.push(manifestItem.toJson());


            t.update(userRef, { userManifests: userManifests });
        });
        res.status(200).send("Manifest sent successfully");
    }
    catch (error) {
        console.log('Transaction failure:', error);
        res.status(404).send("Manifest could not be sent");


    }





};

module.exports = sendManifest;



