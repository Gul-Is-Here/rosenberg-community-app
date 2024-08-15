import 'package:community_islamic_app/firebase_options.dart';
import 'package:community_islamic_app/views/home_screens/masjid_map/order_traking_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:workmanager/workmanager.dart';
import 'constants/image_constants.dart';
import 'controllers/home_controller.dart';
import 'services/background_task.dart';
import 'services/notification_service.dart';
import 'views/donation_screens/donation_screen.dart';
import 'views/home_screens/home_screen.dart';
import 'views/qibla_screen/qibla_screen.dart';
import 'views/quran_screen.dart/quran_screen.dart';
import 'widgets/customized_bottom_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Notification Services
  final notificationServices = NotificationServices();
  await notificationServices.initializeNotification();
  notificationServices.storeDeviceToken();
  notificationServices.checkDeviceTokens();
  // Set up Firebase Messaging background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize timezone data
  tz.initializeTimeZones();

  // Initialize Workmanager
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );

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
    final HomeController controller = Get.put(HomeController());

    final List<Widget> _pages = [
      const HomeScreen(),
      QiblahScreen(),
      const QuranScreen(),
      const DonationScreen()
    ];

    return GetMaterialApp(
      home: Scaffold(
        body: Obx(() => Stack(
              children: [
                _pages[controller.selectedIndex.value],
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomBottomNavigationBar(controller: controller),
                ),
              ],
            )),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .1,
            width: MediaQuery.of(context).size.width * .2,
            child: FloatingActionButton(
              isExtended: true,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              onPressed: () {
                Get.to(() => const OrderTrackingPage());
              },
              child: Image.asset(
                masjidIcon,
                height: 120,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
