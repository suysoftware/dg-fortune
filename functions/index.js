const functions = require("firebase-functions");
const admin = require("firebase-admin");


const express = require('express');
const cors = require('cors')({ origin: true });
const app = express();
app.use(cors);
admin.initializeApp(functions.config().firestore);
const db = admin.firestore();


const acountCreate = require('./auth/AccountCreate');



exports.createNewUser = functions.auth.user().onCreate(async (user) => {

    console.log("New user created with email: ");
       await acountCreate(user.email, user.uid);


});