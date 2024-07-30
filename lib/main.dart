import 'package:community_islamic_app/views/home_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'constants/image_constants.dart';
import 'controllers/home_controller.dart';
import 'controllers/notification_service.dart';
import 'views/donation_screens/donation_screen.dart';
import 'views/qibla_screen.dart';
import 'views/quran_screen.dart/quran_screen.dart';
import 'widgets/customized_bottom_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final notificationServices = NotificationServices();
  notificationServices.initializeNotifications();
  tz.initializeTimeZones();
  runApp(const MyApp());
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
                  borderRadius: BorderRadius.circular(40)),
              onPressed: () {},
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
