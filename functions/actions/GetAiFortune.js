const admin = require("firebase-admin");
const { v4: uuidv4 } = require('uuid');
const db = admin.firestore();
const auth = admin.auth();
const { Configuration, OpenAIApi } = require("openai");
const configuration = new Configuration({
    apiKey: "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",
});
const openai = new OpenAIApi(configuration);


const { UserAiFortune } = require('../model/FortuneUser/components/UserAiFortune');


const getAiFortune = async (req, res, next) => {

    var userNo = req.body.user_no;
    var fortuneNo = uuidv4();


    var messages = [];


    const userRef = db.collection('users').doc(userNo);
    const userGet = await userRef.get();
    const userData = userGet.data();
    var userAiFortunes = userData.userAiFortunes;
    var userManifests = userData.userManifests;

    var listFortune = ["Don’t hold onto things that require a tight grip.", "I didn’t come this far to only come this far.", "Vulnerability sounds like faith and looks like courage.", "And into the forest I go, to lose my mind and find my soul.", "Be the person you needed when you were younger.", "Do it scared.", "Look how far you've come.", "Sitting in silence with you is all the noise I need."];


    for (const key in listFortune) {
        if (Object.hasOwnProperty.call(listFortune, key)) {
            const element = listFortune[key];

            messages.push({ "role": "user", "content": "Fortune Sample: " + element });

        }
    }


    for (const key in userAiFortunes) {
        if (Object.hasOwnProperty.call(userAiFortunes, key)) {
            const element = userAiFortunes[key];
            messages.push({ "role": "user", "content": "User's past fortune: " + element.fortuneText });

        }
    }



    for (const key in userManifests) {
        if (Object.hasOwnProperty.call(userManifests, key)) {
            const element = userManifests[key];
            messages.push({ "role": "user", "content": "User's wish: " + element.manifestText });

        }
    }


    messages.push({ "role": "user", "content": " Generate a personalized fortune related to this wish.But don't write to start 'Personalized Fortune:' because we will show this message directly to user " });



    const response = await openai.createChatCompletion({
        model: "gpt-3.5-turbo",
        messages: messages,
        temperature: 0.7,
        max_tokens: 100,
    });



    console.log(response.data.choices[0].message.content);



    try {

        await db.runTransaction(async (t) => {

            const userGet = await t.get(userRef);
            const userData = userGet.data();

            var userAiFortunes = userData.userAiFortunes;
            await userAiFortunes.push({
                fortuneText: response.data.choices[0].message.content,
                fortuneDate: admin.firestore.Timestamp.now(),
                fortuneNo: fortuneNo
            });


            t.update(userRef, { userAiFortunes: userAiFortunes });
        });
        res.status(200).send("Fortune sent successfully");
    }
    catch (error) {
        console.log('Transaction failure:', error);
        res.status(404).send("Fortune could not be sent");


    }





};

module.exports = getAiFortune;



