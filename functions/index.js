const functions = require('firebase-functions/v2');
const admin = require('firebase-admin');
const fetch = require('node-fetch');

admin.initializeApp();

// HTTP endpoint to schedule Azan notifications
exports.scheduleAzanNotifications = functions.https.onRequest(
    { timeoutSeconds: 1200, region: ["us-west1", "us-east1"] },
    async (req, res) => {
        try {
            // Fetch prayer times
            const timings = await fetchTimings();

            // Schedule notifications for each prayer
            await scheduleAzanNotifications(timings);

            res.status(200).send("Azan notifications scheduled successfully.");
        } catch (error) {
            console.error("Error scheduling notifications:", error);
            res.status(500).send("Error scheduling Azan notifications.");
        }
    }
);

// Fetch prayer timings from the API
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

// Schedule Azan Notifications
async function scheduleAzanNotifications(timings) {
    const prayerTimes = [
        { name: 'Fajr', time: timings.Fajr },
        { name: 'Dhuhr', time: timings.Dhuhr },
        { name: 'Asr', time: timings.Asr },
        { name: 'Maghrib', time: timings.Maghrib },
        { name: 'Isha', time: timings.Isha }
    ];

    // Schedule notifications for each prayer time
    for (const prayer of prayerTimes) {
        const notificationTime = new Date(prayer.time); // Convert prayer time to Date object if necessary

        // Implement your notification scheduling logic here
        // Example: sending notification at prayer time
        await sendAzanNotification(prayer.name);
    }
}

// Send Azan Notification to all devices
async function sendAzanNotification(prayerName) {
    try {
        // Get device tokens from Firestore
        const tokensSnapshot = await admin.firestore().collection("devices").get();
        const tokens = tokensSnapshot.docs.map(doc => doc.data().token);

        if (tokens.length > 0) {
            const notifications = tokens.map(token => {
                const message = createMessage(token, prayerName);
                return admin.messaging().send(message)
                    .then(response => {
                        console.log(`Successfully sent message to ${token}:`, response);
                    })
                    .catch(error => {
                        console.error(`Error sending message to ${token}:`, error);
                    });
            });

            // Wait for all notifications to be sent
            await Promise.all(notifications);
        } else {
            console.log("No tokens found.");
        }
    } catch (error) {
        console.error("Error sending Azan notification:", error);
    }
}

// Create notification message for each token
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
        },
    };
}
