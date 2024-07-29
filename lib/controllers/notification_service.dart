import 'package:community_islamic_app/views/home_screens/azanoverlay_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:audioplayers/audioplayers.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  final _audioPlayer = AudioPlayer();

  void initializeNotifications() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    InitializationSettings initializationSettings =
        InitializationSettings(android: _androidInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
        if (payload == 'azan') {
          // Handle notification tap
          showAzanOverlay();
        }
      },
    );
  }

  @pragma('vm:entry-point')
  void notifiacationTapBackground(NotificationResponse notificationResponse) {
    debugPrint('Notification action tapped:');
    if (notificationResponse.payload == 'azan') {
      showAzanOverlay();
    }
  }

  void sendNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('adhan_channel', '0',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            fullScreenIntent: true);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: 'azan');
  }

  void scheduleNotification(
      String title, String body, DateTime scheduledTime) async {
    if (scheduledTime.isBefore(DateTime.now())) {
      // If the scheduled time is in the past, you can log an error or adjust the time
      print("Scheduled time must be in the future.");
      return;
    }

    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('adhan_channel', '0',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            fullScreenIntent: true);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    // Ensure timezone is initialized
    tz.initializeTimeZones();
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(scheduledTime, tz.local);
    print('Scheduled time: $scheduledTime');
    print('Converted TZDateTime: $scheduledDate');

    await _flutterLocalNotificationsPlugin.zonedSchedule(
        0, title, body, scheduledDate, notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'azan'); // Add payload to identify the notification
  }

  void playAzan() async {
    // await _audioPlayer.lo
    await _audioPlayer.setSource(AssetSource('assets/audio/azan1.mp3'));
    await _audioPlayer.resume();
  }

  void stopAzan() async {
    await _audioPlayer.stop();
  }

  void showAzanOverlay() {
    Get.to(() => AzanOverlay());
  }
}
