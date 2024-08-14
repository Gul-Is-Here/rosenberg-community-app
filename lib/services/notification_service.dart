import 'package:app_settings/app_settings.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:community_islamic_app/views/home_screens/azanoverlay_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart' as audioplayers;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  final player = audioplayers.AudioPlayer();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  NotificationServices() {
    initializeNotification();
    requestNotificationPermission();
    firebaseInit();
  }

  Future<void> initializeNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);

    await _flutterLocalNotificationPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Handle notification click here
      print("Notification Clicked: ${response.payload}");
      // Navigate to specific screen or perform an action
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User Permission Granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      AppSettings.openAppSettings();
    }
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      // Foreground notification
      print("Received a foreground message: ${message.messageId}");
      showNotification(message.notification?.title, message.notification?.body);

      // Check for playAzan flag and trigger Azan sound
      if (message.data['playAzan'] == 'true') {
        playAzanSound();
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // Handle notification when the app is opened from a terminated or background state
      print("Notification Clicked: ${message.messageId}");
    });

    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessageHandler);
  }

  Future<void> showNotification(String? title, String? body) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('adhan_channel', 'Adhan Channel',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true);

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationPlugin.show(
      0,
      title ?? 'Prayer Time',
      body ?? 'It\'s time for prayer.',
      notificationDetails,
      payload: 'azan',
    );
  }

  Future<void> playAzanSound() async {
    final player = audioplayers.AudioPlayer(); // Use audioplayers package
    final assetPath = 'assets/azan.mp3'; // Path to your audio file in assets

    // Load the audio source
    await player.setSource(audioplayers.AssetSource(assetPath));

    // Play the audio
    await player.play(AssetSource(assetPath)); // Play with default settings
  }

  static Future<void> firebaseBackgroundMessageHandler(
      RemoteMessage message) async {
    // Handle background message
    await NotificationServices().showNotification(
        message.notification?.title, message.notification?.body);

    if (message.data['playAzan'] == 'true') {
      await NotificationServices().playAzanSound();
    }
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    try {
      await Firebase.initializeApp();
      final data = message.data;

      if (data['playAzan'] == 'true') {
        await NotificationServices().initializeNotification();
        await NotificationServices().showNotification(
          'Prayer Time',
          'It\'s time for ${data['nextPrayer']} prayer!',
        );
        // Logic to navigate to AzanOverlayScreen
        if (data['navigateTo'] == 'AzanOverlayScreen') {
          // Code to show AzanOverlayScreen or handle the navigation
          Get.to(() => AzanoverlayScreen(
                audioPlayer: player,
              ));
        }
      }
    } catch (e) {
      print("Error in background message handler: $e");
    }
  }

  Future<String> _getDeviceId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('device_id');

    if (deviceId == null) {
      // Generate a new unique ID
      deviceId = Uuid().v4(); // Generating a UUID v4
      await prefs.setString('device_id', deviceId);
      print('New device ID generated: $deviceId');
    } else {
      print('Existing device ID retrieved: $deviceId');
    }

    return deviceId;
  }

// Get and store device token in Firebase Realtime Database
  Future<void> storeDeviceToken() async {
    try {
      // Get the device's unique ID
      String deviceId = await _getDeviceId();

      // Get the FCM token
      String? token = await FirebaseMessaging.instance.getToken();
      print('Device Token: $token');

      if (token != null) {
        // Store or update the token under the unique device ID in Realtime Database
        await FirebaseDatabase.instance.ref().child('devices/$deviceId').set({
          'token': token,
          'last_updated': DateTime.now().toIso8601String(),
        });
        print('Device token stored/updated successfully');
      } else {
        print('Failed to get FCM token.');
      }

      // Listen for token refresh and update the token
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
        print('FCM Token refreshed: $newToken');
        await FirebaseDatabase.instance
            .ref()
            .child('devices/$deviceId')
            .update({
          'token': newToken,
          'last_updated': DateTime.now().toIso8601String(),
        });
        print('Device token updated successfully');
      });
    } catch (e) {
      print('Error storing device token: ${e.toString()}');
    }
  }
}
