// import 'package:alarm/alarm.dart';
import 'package:community_islamic_app/firebase_options.dart';
import 'package:community_islamic_app/views/auth_screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await Alarm.init();

  tz.initializeTimeZones();

  await NotificationServices().initializeNotification();

  // await NotificationServices().test();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  DateTime today = DateTime.now();

  if (sharedPreferences.containsKey("prayerTimesMonth")) {
    if (today.month != sharedPreferences.getInt("prayerTimesMonth")) {
      if (sharedPreferences.containsKey("prayerTimes")) {
        sharedPreferences.remove("prayerTimes");
      }
    }
  }

  if (!sharedPreferences.containsKey("fajr")) {
    sharedPreferences.setBool("fajr", true);
  }

  if (!sharedPreferences.containsKey("dhuhr")) {
    sharedPreferences.setBool("dhuhr", true);
  }

  if (!sharedPreferences.containsKey("asr")) {
    sharedPreferences.setBool("asr", true);
  }

  if (!sharedPreferences.containsKey("maghrib")) {
    sharedPreferences.setBool("maghrib", true);
  }

  if (!sharedPreferences.containsKey("isha")) {
    sharedPreferences.setBool("isha", true);
  }

  if (!sharedPreferences.containsKey("selectedSound")) {
    sharedPreferences.setString("selectedSound", "Adhan - Makkah");
  }

  // Initialize Notification Services
  // final notificationServices = NotificationServices();
  // await notificationServices.initializeNotification();
  // notificationServices.storeDeviceToken();
  // notificationServices.checkDeviceTokens();

  // Set up Firebase Messaging background handler
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Schedule and play Azan notification immediately on app start
  // HomeController().scheduleAzanNotification();

  // await Alarm.setNotificationOnAppKillContent(
  //   'Azan Alarm',
  //   'Your scheduled Azan is active',
  // );

  runApp(const MyApp());
}

// Background message handler
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   try {
//     await Firebase.initializeApp();
//     final notificationServices = NotificationServices();
//     await notificationServices.initializeNotification();
//     await notificationServices.showNotification('Prayer', 'It\'s Prayer Time');
//   } catch (e) {
//     print("Error in background message handler: $e");
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: SplashScreen());
  }
}
