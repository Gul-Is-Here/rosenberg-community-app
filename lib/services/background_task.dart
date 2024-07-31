import 'dart:async';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:audioplayers/audioplayers.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Your background task code
    // Play Azan and show notification
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    InitializationSettings initializationSettings = const InitializationSettings(
      android: androidInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Setup audio player
    final AudioPlayer audioPlayer = AudioPlayer();
    audioPlayer.setReleaseMode(ReleaseMode.loop);

    // Define your notification details
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('adhan_channel', 'Adhan Channel',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            fullScreenIntent: true);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    // Play Azan and show notification
    await flutterLocalNotificationsPlugin.show(
      0,
      'Azan',
      'It\'s time for prayer',
      notificationDetails,
      payload: 'azan',
    );

    await audioPlayer.play(AssetSource('azan1.wav'));

    return Future.value(true);
  });
}
