import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';
import 'package:timezone/data/latest.dart' as tz;
import '../views/home_screens/azanoverlay_screen.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  late AudioPlayer audioPlayer;
  PlayerState? _playerState;
  StreamSubscription<PlayerState>? _playerStateChangeSubscription;

  NotificationServices() {
    // Initialize the audio player
    audioPlayer = AudioPlayer();
    audioPlayer.setReleaseMode(ReleaseMode.stop);

    // Listen to player state changes
    _playerStateChangeSubscription =
        audioPlayer.onPlayerStateChanged.listen((state) {
      _playerState = state;
      print('PlayerState: $state');
    });
  }

  void initializeNotifications() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestFullScreenIntentPermission();
    InitializationSettings initializationSettings =
        InitializationSettings(android: _androidInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
        if (payload == 'azan') {
          Get.to(() => AzanoverlayScreen(
                audioPlayer: audioPlayer,
              ));
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
        const AndroidNotificationDetails('adhan_channel', 'Adhan Channel',
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
        const AndroidNotificationDetails('adhan_channel', 'Adhan Channel',
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
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        // ignore: deprecated_member_use
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'azan');
  }

  void playAzan() async {
    print('Playing Azan...');
    sendNotification('Azan', 'It\'s time for prayer');
    await audioPlayer.play(AssetSource('azan1.wav'));
    Get.to(() => AzanoverlayScreen(
          audioPlayer: audioPlayer,
        ));
  }

  Future<void> stopAzan() async {
    try {
      print('Stopping Azan...');
      await audioPlayer.stop();
      print('PlayerState: ${audioPlayer.state}');
      print('Azan stopped successfully.');
    } catch (e) {
      print('Failed to stop Azan: $e');
    }
  }

  void showAzanOverlay() {
    Get.to(() => AzanoverlayScreen(
          audioPlayer: audioPlayer,
        ));
  }

  void scheduleBackgroundTask(DateTime scheduledTime) {
    print('Scheduling background task...');
    final durationUntilTask = scheduledTime.difference(DateTime.now());
    if (durationUntilTask.isNegative) return;

    Workmanager().registerOneOffTask(
      'id_unique_${scheduledTime.millisecondsSinceEpoch}',
      'playAzanTask',
      initialDelay: durationUntilTask,
      inputData: <String, dynamic>{'task': 'playAzan'},
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
        requiresCharging: false,
        requiresStorageNotLow: true,
      ),
    );
    print('Background task scheduled for: $scheduledTime');
  }

  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) {
      if (inputData!['task'] == 'playAzan') {
        // Perform the task here (e.g., play Azan sound)
        final notificationServices = NotificationServices();
        notificationServices.playAzan();
      }
      return Future.value(true);
    });
  }

  void dispose() {
    _playerStateChangeSubscription?.cancel();
    audioPlayer.dispose();
  }
}
