const functions = require('firebase-functions');
const admin = require('firebase-admin');
const fetch = require('node-fetch');

admin.initializeApp();

exports.sendAzanNotification = functions.pubsub.schedule('0 8 * * *')
    .timeZone('America/Chicago')
    .onRun(async (context) => {
        await sendAzanNotifications();
    });

exports.testAzanNotification = functions.pubsub.schedule('every 1 minutes')
    .onRun(async (context) => {
        await sendAzanNotifications(true);
    });

async function sendAzanNotifications(isTest = false) {
    try {
        // Fetch timings
        const timings = isTest ? getDummyTimings() : await fetchTimings();

        // Fetch device tokens from Firestore
        const tokensSnapshot = await admin.firestore().collection("devices").get();
        const tokens = tokensSnapshot.docs.map(doc => doc.data().token);

        console.log("Tokens retrieved:", tokens);

        if (tokens.length > 0) {
            for (const token of tokens) {
                if (token) {
                    const message = createMessage(token, timings, isTest);
                    try {
                        const response = await admin.messaging().send(message);
                        console.log("Successfully sent message:", response);
                    } catch (error) {
                        console.error("Error sending message to token:", token, error);
                    }
                } else {
                    console.log("Invalid token found");
                }
            }
        } else {
            console.log("No tokens found.");
        }
    } catch (error) {
        console.error("Error fetching prayer times or sending notifications:", error);
    }
}

async function fetchTimings() {
    try {
        const response = await fetch("https://api.aladhan.com/v1/timingsByCity?city=Sugar+Land&country=USA");
        const data = await response.json();
        return data.data.timings;
    } catch (error) {
        console.error("Error fetching prayer timings:", error);
        throw new Error("Failed to fetch prayer timings");
    }
}

function getDummyTimings() {
    const now = new Date();
    now.setSeconds(0); // Ensure the seconds are set to 0

    const timings = {
        Fajr: new Date(now.getTime() + 1 * 60000).toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" }), // 1 minute from now
        Dhuhr: new Date(now.getTime() + 2 * 60000).toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" }), // 2 minutes from now
        Asr: new Date(now.getTime() + 3 * 60000).toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" }), // 3 minutes from now
        Maghrib: new Date(now.getTime() + 4 * 60000).toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" }), // 4 minutes from now
        Isha: new Date(now.getTime() + 5 * 60000).toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" }) // 5 minutes from now
    };
    return timings;
}

function createMessage(token, timings, isTest) {
    const nextPrayer = getNextPrayer(timings);
    return {
        token: token,
        notification: {
            title: isTest ? "Azan Test" : "Azan",
            body: `It's time for ${nextPrayer} prayer! ${isTest ? "(Test)" : ""}`,
        },
        android: {
            priority: "high",
        },
        apns: {
            payload: {
                aps: {
                    sound: "default",
                },
            },
        },
        data: {
            playAzan: "true",
            nextPrayer: nextPrayer,
            navigateTo: "AzanoverlayScreen"
        },
    };
}

function getNextPrayer(timings) {
    const now = new Date();
    const prayerTimes = [
        { name: 'Fajr', time: new Date(now.toDateString() + " " + timings.Fajr) },
        { name: 'Dhuhr', time: new Date(now.toDateString() + " " + timings.Dhuhr) },
        { name: 'Asr', time: new Date(now.toDateString() + " " + timings.Asr) },
        { name: 'Maghrib', time: new Date(now.toDateString() + " " + timings.Maghrib) },
        { name: 'Isha', time: new Date(now.toDateString() + " " + timings.Isha) }
    ].filter(prayer => prayer.time > now);

    if (prayerTimes.length > 0) {
        return prayerTimes[0].name;
    } else {
        return "Fajr"; // Default to Fajr if all prayers have passed
    }
}

// Simple test function to send a notification
exports.simpleTestNotification = functions.https.onRequest(async (req, res) => {
    const token = req.query.token; // Pass the device token as a query parameter
    const message = {
        token: token,
        notification: {
            title: 'Test Notification',
            body: 'This is a test notification',
        },
    };

    try {
        const response = await admin.messaging().send(message);
        console.log('Successfully sent message:', response);
        res.status(200).send('Notification sent successfully');
    } catch (error) {
        console.error('Error sending message:', error);
        res.status(500).send('Error sending notification');
    }
});
