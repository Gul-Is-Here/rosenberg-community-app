const functions = require('firebase-functions');
const admin = require('firebase-admin');
const fetch = require('node-fetch');

admin.initializeApp();

// Function to send notifications every 24 hours
exports.sendAzanNotification = functions.pubsub.schedule('0 8 * * *') // Runs daily at 8 AM UTC
    .timeZone('America/Chicago') // Set your desired time zone
    .onRun(async (context) => {
        try {
            const response = await fetch("https://api.aladhan.com/v1/timingsByCity?city=Sugar+Land&country=USA");
            const data = await response.json();
            const timings = data.data.timings;

            const tokensSnapshot = await admin.database().ref("devices").once("value");
            const tokens = tokensSnapshot.val();

            console.log("Tokens retrieved:", JSON.stringify(tokens, null, 2));

            if (tokens) {
                Object.keys(tokens).forEach((deviceId) => {
                    const token = tokens[deviceId].token;
                    if (token) {
                        const message = createMessage(token, timings);
                        admin.messaging().send(message)
                            .then((response) => {
                                console.log("Successfully sent message:", response);
                            })
                            .catch((error) => {
                                console.error("Error sending message:", error);
                            });
                    } else {
                        console.log(`No token found for deviceId: ${deviceId}`);
                    }
                });
            } else {
                console.log("No tokens found.");
            }
        } catch (error) {
            console.error("Error fetching prayer times:", error);
        }
    });

// Testing Cloud Function to send notifications every 30 seconds
exports.testAzanNotification = functions.pubsub.schedule('every 30 seconds')
    .onRun(async (context) => {
        try {
            const response = await fetch("https://api.aladhan.com/v1/timingsByCity?city=Sugar+Land&country=USA");
            const data = await response.json();
            const timings = data.data.timings;

            const tokensSnapshot = await admin.database().ref("devices").once("value");
            const tokens = tokensSnapshot.val();

            console.log("Tokens retrieved:", JSON.stringify(tokens, null, 2));

            if (tokens) {
                Object.keys(tokens).forEach((deviceId) => {
                    const token = tokens[deviceId].token;
                    if (token) {
                        const message = createTestMessage(token, timings);
                        admin.messaging().send(message)
                            .then((response) => {
                                console.log("Successfully sent test message:", response);
                            })
                            .catch((error) => {
                                console.error("Error sending test message:", error);
                            });
                    } else {
                        console.log(`No token found for deviceId: ${deviceId}`);
                    }
                });
            } else {
                console.log("No tokens found.");
            }
        } catch (error) {
            console.error("Error fetching prayer times for test:", error);
        }
    });

function createTestMessage(token, timings) {
    return {
        token: token,
        notification: {
            title: "Azan Test",
            body: `It's time for ${getNextPrayer(timings)} prayer! (Test)`,
        },
        android: {
            priority: "high",
        },
        apns: {
            payload: {
                aps: {
                    sound: "azan.mp3", // Custom sound to play Azan
                },
            },
        },
        data: {
            playAzan: "true", // Custom data to trigger Azan playback
            nextPrayer: getNextPrayer(timings),
            navigateTo: "AzanOverlayScreen" // Custom data to trigger screen navigation
        },
    };
}

function getNextPrayer(timings) {
    const now = new Date();
    const fajr = new Date(now.toDateString() + " " + timings.Fajr);
    const dhuhr = new Date(now.toDateString() + " " + timings.Dhuhr);
    const asr = new Date(now.toDateString() + " " + timings.Asr);
    const maghrib = new Date(now.toDateString() + " " + timings.Maghrib);
    const isha = new Date(now.toDateString() + " " + timings.Isha);

    const prayerTimes = [fajr, dhuhr, asr, maghrib, isha].filter((time) => time > now);

    if (prayerTimes.length > 0) {
        const nextPrayerTime = prayerTimes[0];
        return Object.keys(timings).find((key) => timings[key] === nextPrayerTime.toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" }));
    } else {
        return "Fajr";  // Default to next day's Fajr if after Isha
    }
}
