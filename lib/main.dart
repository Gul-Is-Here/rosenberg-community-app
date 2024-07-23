import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'constants/image_constants.dart';
import 'controllers/home_controller.dart';
import 'views/donation_screens/donation_screen.dart';
import 'views/home_screens/home_screen_content.dart';
import 'views/qibla_screen.dart';
import 'views/quran_screen.dart/quran_screen.dart';
import 'widgets/customized_bottom_bar.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    final List<Widget> _pages = [
      HomeScreenContent(),
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
            height: 70,
            width: 70,
            child: FloatingActionButton(
              isExtended: true,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              onPressed: () {},
              child: Image.asset(
                masjidIcon,
                height: 100,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
