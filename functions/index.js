const functions = require("firebase-functions");
const admin = require("firebase-admin");


const express = require('express');
const cors = require('cors')({ origin: true });
const app = express();
app.use(cors);
admin.initializeApp(functions.config().firestore);
const db = admin.firestore();


const acountCreate = require('./auth/AccountCreate');
const sendManifest = require('./actions/SendManifest');
const getAiFortune = require('./actions/GetAiFortune');



app.put("/SendManifest", sendManifest, async (req, res) => {
    // Request Description: This functions get user usage stats
});
app.put("/GetAiFortune", getAiFortune, async (req, res) => {
    // Request Description: This functions get user usage stats
});

exports.createNewUser = functions.auth.user().onCreate(async (user) => {

    console.log("New user created with email: ");
    await acountCreate(user.email, user.uid);


});

exports.appRequest = functions.https.onRequest(app);