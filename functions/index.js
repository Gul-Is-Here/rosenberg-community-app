const functions = require('firebase-functions/v2');
const admin = require('firebase-admin');
const fetch = require('node-fetch');

admin.initializeApp();

exports.scheduleAzanNotifications = functions.https.onRequest(
    { timeoutSeconds: 1200, region: ["us-west1", "us-east1"] },
    async (req, res) => {
        try {
            // Fetch the prayer times from the API
            const timings = await fetchTimings();

            // Schedule notifications for each prayer time
            scheduleAzanNotifications(timings);

            res.status(200).send("Azan notifications scheduled successfully.");
        } catch (error) {
            console.error("Error scheduling notifications:", error);
            res.status(500).send("Error scheduling Azan notifications.");
        }
    }
);

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

function scheduleAzanNotifications(timings) {
    const prayerTimes = [
        { name: 'Fajr', time: timings.Fajr },
        { name: 'Dhuhr', time: timings.Dhuhr },
        { name: 'Asr', time: timings.Asr },
        { name: 'Maghrib', time: timings.Maghrib },
        { name: 'Isha', time: timings.Isha }
    ];

    prayerTimes.forEach(prayer => {
        const [hour, minute] = prayer.time.split(':');
        const hourInt = parseInt(hour, 10);
        const minuteInt = parseInt(minute, 10);

        // Schedule a PubSub function to run at the prayer time
        functions.pubsub.schedule(`${minuteInt} ${hourInt} * * *`)
            .timeZone('America/Chicago')
            .onRun(async (context) => {
                await sendAzanNotification(prayer.name);
            });
    });
}

async function sendAzanNotification(prayerName) {
    try {
        // Fetch device tokens from Firestore
        const tokensSnapshot = await admin.firestore().collection("devices").get();
        const tokens = tokensSnapshot.docs.map(doc => doc.data().token);

        if (tokens.length > 0) {
            for (const token of tokens) {
                if (token) {
                    const message = createMessage(token, prayerName);
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
        console.error("Error sending Azan notification:", error);
    }
}

function createMessage(token, prayerName) {
    return {
        token: token,
        notification: {
            title: "Azan",
            body: `It's time for ${prayerName} prayer!`,
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
            nextPrayer: prayerName,
            navigateTo: "AzanoverlayScreen"
        },
    };
}
