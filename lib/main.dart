import 'package:alarm/alarm.dart';
import 'package:community_islamic_app/controllers/home_controller.dart';
import 'package:community_islamic_app/firebase_options.dart';
import 'package:community_islamic_app/views/auth_screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Alarm.init();

  // Initialize Notification Services
  final notificationServices = NotificationServices();
  await notificationServices.initializeNotification();
  notificationServices.storeDeviceToken();
  notificationServices.checkDeviceTokens();

  // Set up Firebase Messaging background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize timezone data
  tz.initializeTimeZones();

  // Schedule and play Azan notification immediately on app start
  HomeController().scheduleAzanNotification();
  await Alarm.setNotificationOnAppKillContent(
      'Azan Alarm', 'Your scheduled Azan is active');

  runApp(const MyApp());
}

// Background message handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
    final notificationServices = NotificationServices();
    await notificationServices.initializeNotification();
    await notificationServices.showNotification('Prayer', 'It\'s Prayer Time');
  } catch (e) {
    print("Error in background message handler: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: SplashScreen());
  }
}
