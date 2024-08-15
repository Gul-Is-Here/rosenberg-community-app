const functions = require('firebase-functions');
const admin = require('firebase-admin');
const fetch = require('node-fetch');

admin.initializeApp();

exports.sendAzanNotification = functions.pubsub.schedule('0 8 * * *')
    .timeZone('America/Chicago')
    .onRun(async (context) => {
        await sendAzanNotifications();
    });

async function sendAzanNotifications() {
    try {
        // Fetch timings
        const timings = await fetchTimings();

        // Fetch device tokens from Firestore
        const tokensSnapshot = await admin.firestore().collection("devices").get();
        const tokens = tokensSnapshot.docs.map(doc => doc.data().token);

        console.log("Tokens retrieved:", tokens);

        if (tokens.length > 0) {
            for (const token of tokens) {
                if (token) {
                    const message = createMessage(token, timings);
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

function createMessage(token, timings) {
    const nextPrayer = getNextPrayer(timings);
    return {
        token: token,
        notification: {
            title: "Azan",
            body: `It's time for ${nextPrayer} prayer!`,
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
