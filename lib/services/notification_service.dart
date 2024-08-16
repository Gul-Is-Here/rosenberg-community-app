import 'package:app_settings/app_settings.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:community_islamic_app/model/prayer_model.dart';
import 'package:community_islamic_app/views/home_screens/azanoverlay_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  final AudioPlayer player = AudioPlayer(); // Using audioplayers package
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Firestore instance

  NotificationServices() {
    initializeNotification();
    requestNotificationPermission();
    firebaseInit();
    subscribeToAzanTopic(); // Subscribe to 'azan' topic
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

    await _flutterLocalNotificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification click
        Get.to(() => AzanoverlayScreen(audioPlayer: player));
      },
    );
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
      _navigateToAzanOverlayScreen();
    });

    FirebaseMessaging.onBackgroundMessage(
      firebaseBackgroundMessageHandler,
    );
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
    try {
      print("Starting audio playback...");

      // Load and play the audio file
      await player.play(AssetSource("azan1.wav"));
      print("Audio playback started.");

      player.onPlayerStateChanged.listen((PlayerState state) {
        print('Player state changed to: $state');
        if (state == PlayerState.playing) {
          print("AudioPlayer is playing.");
        } else if (state == PlayerState.paused) {
          print("AudioPlayer is paused.");
        } else if (state == PlayerState.stopped) {
          print("AudioPlayer is stopped.");
        } else if (state == PlayerState.completed) {
          print("AudioPlayer playback completed.");
        } else {
          print("AudioPlayer state: $state");
        }
      });

      // Optionally check if player is currently playing
      if (player.state == PlayerState.playing) {
        print("AudioPlayer is indeed playing.");
      } else {
        print("AudioPlayer is not playing, current state: ${player.state}");
      }

      // Navigate to AzanoverlayScreen
      Get.to(() => AzanoverlayScreen(audioPlayer: player));
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  static Future<void> firebaseBackgroundMessageHandler(
    RemoteMessage message,
  ) async {
    try {
      await Firebase.initializeApp();
      await NotificationServices().showNotification(
        message.notification?.title,
        message.notification?.body,
      );

      if (message.data['playAzan'] == 'true') {
        await NotificationServices().playAzanSound();
        NotificationServices()._navigateToAzanOverlayScreen();
      }
    } catch (e) {
      print("Error in background message handler: $e");
    }
  }

  void _navigateToAzanOverlayScreen() {
    Get.to(() => AzanoverlayScreen(audioPlayer: player));
  }

  Future<void> storeDeviceToken() async {
    try {
      String deviceId = await _getDeviceId();
      String? token = await FirebaseMessaging.instance.getToken();
      print('Device Token: $token');

      if (token != null) {
        await _firestore.collection('devices').doc(deviceId).set({
          'token': token,
        });
        print('Device token stored/updated successfully');
      } else {
        print('Failed to get FCM token.');
      }

      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
        print('FCM Token refreshed: $newToken');
        await _firestore.collection('devices').doc(deviceId).update({
          'token': newToken,
        });
        print('Device token updated successfully');
      });
    } catch (e) {
      print('Error storing device token: ${e.toString()}');
    }
  }

  Future<void> checkDeviceTokens() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('devices').get();
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.forEach((doc) {
          Map<String, dynamic> deviceData = doc.data() as Map<String, dynamic>;
          if (deviceData.containsKey('token')) {
            print('Device ID: ${doc.id}, Token: ${deviceData['token']}');
          } else {
            print('No token found for Device ID: ${doc.id}');
          }
        });
      } else {
        print('No device tokens found.');
      }
    } catch (e) {
      print('Error fetching device tokens: ${e.toString()}');
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

  void subscribeToAzanTopic() {
    messaging.subscribeToTopic('azan').then((_) {
      print('Subscribed to azan topic');
    }).catchError((e) {
      print('Error subscribing to azan topic: $e');
    });
  }
}
