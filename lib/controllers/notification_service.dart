import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';

import '../views/home_screens/azanoverlay_screen.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  AudioPlayer audioPlayer = AudioPlayer();

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

    // Request notification permissions from the user
    await requestNotificationPermissions();
  }

  Future<void> requestNotificationPermissions() async {
    PermissionStatus status = await Permission.notification.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      PermissionStatus result = await Permission.notification.request();
      if (result.isGranted) {
        print("Notification permission granted");
      } else {
        print("Notification permission denied");
      }
    } else {
      print("Notification permission already granted");
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
        payload: 'azan');
  }

  void playAzan() async {
    await audioPlayer.setSource(AssetSource('azan1.wav'));
    audioPlayer.resume();
  }

  Future<void> stopAzan() async {
    try {
      print('Stopping Azan...');
      await audioPlayer.stop();
      await audioPlayer.release();
      await audioPlayer.dispose();
      audioPlayer = AudioPlayer(); // Reinitialize the player after stopping
      print('Azan stopped successfully.');
    } catch (e) {
      print('Failed to stop Azan: $e');
    }
  }

  void showAzanOverlay() {
    Get.to(() => AzanoverlayScreen());
  }
}
