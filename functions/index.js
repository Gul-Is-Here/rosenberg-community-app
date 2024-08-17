const { https } = require('firebase-functions/v2');
const admin = require('firebase-admin');
const { CloudTasksClient } = require('@google-cloud/tasks');

admin.initializeApp();
const client = new CloudTasksClient();

const project = 'rosember-comunity-app-63216';
const location = 'us-central1';
const queue = 'azan-notifications';

const URL = 'https://api.aladhan.com/v1/timingsByCity?city=Sugar+Land&country=USA';

// HTTP endpoint to schedule Azan notifications
exports.scheduleAzanNotifications = https.onRequest(
  { timeoutSeconds: 1200, region: ['us-west1', 'us-east1'] },
  async (req, res) => {
    try {
      // Fetch prayer times
      const fetch = (await import('node-fetch')).default;
      const timings = await fetchTimings(fetch);

      // Schedule notifications for each prayer
      await scheduleAzanNotifications(timings);

      res.status(200).send('Azan notifications scheduled successfully.');
    } catch (error) {
      console.error('Error scheduling notifications:', error);
      res.status(500).send('Error scheduling Azan notifications.');
    }
  }
);

// Fetch prayer timings from the API
async function fetchTimings(fetch) {
  try {
    const response = await fetch(URL);
    const data = await response.json();
    return data.data.timings;
  } catch (error) {
    console.error('Error fetching prayer timings:', error);
    throw new Error('Failed to fetch prayer timings');
  }
}

// Schedule Azan Notifications
async function scheduleAzanNotifications(timings) {
  const prayerTimes = [
    { name: 'Fajr', time: timings.Fajr },
    { name: 'Dhuhr', time: timings.Dhuhr },
    { name: 'Asr', time: timings.Asr },
    { name: 'Maghrib', time: timings.Maghrib },
    { name: 'Isha', time: timings.Isha },
  ];

  // Schedule notifications for each prayer time
  for (const prayer of prayerTimes) {
    const [hour, minute] = prayer.time.split(':').map(Number);
    const now = new Date();
    const notificationTime = new Date(now.getFullYear(), now.getMonth(), now.getDate(), hour, minute);

    // Schedule task if the notification time is in the future
    if (notificationTime > now) {
      await createTask(notificationTime, prayer.name);
    }
  }
}

// Create a task in Cloud Tasks
async function createTask(notificationTime, prayerName) {
  const url = `https://${location}-${project}.cloudfunctions.net/sendAzanNotification`;
  const payload = JSON.stringify({ prayerName });

  const task = {
    httpRequest: {
      httpMethod: 'POST',
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: Buffer.from(payload).toString('base64'),
    },
    scheduleTime: {
      seconds: Math.floor(notificationTime.getTime() / 1000),
    },
  };

  const request = {
    parent: client.queuePath(project, location, queue),
    task,
  };

  try {
    const [response] = await client.createTask(request);
    console.log(`Created task ${response.name}`);
  } catch (error) {
    console.error('Error creating task:', error);
  }
}

// Cloud Function triggered by Cloud Task to send Azan notifications
exports.sendAzanNotification = https.onRequest(async (req, res) => {
  const { prayerName } = req.body;

  try {
    await sendAzanNotificationToDevices(prayerName);
    res.status(200).send('Notification sent');
  } catch (error) {
    console.error('Error sending notification:', error);
    res.status(500).send('Error sending notification');
  }
});

// Send Azan Notification to all devices
async function sendAzanNotificationToDevices(prayerName) {
  try {
    const tokensSnapshot = await admin.firestore().collection('devices').get();
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
      console.log('No tokens found.');
    }
  } catch (error) {
    console.error('Error sending Azan notification:', error);
  }
}

// Create notification message for each token
function createMessage(token, prayerName) {
  return {
    token: token,
    notification: {
      title: 'Azan',
      body: `It's time for ${prayerName} prayer!`,
    },
    android: {
      priority: 'high',
    },
    apns: {
      payload: {
        aps: {
          sound: 'default',
        },
      },
    },
    data: {
      playAzan: 'true',
      nextPrayer: prayerName,
    },
  };
}
