import 'package:community_islamic_app/views/home_screens/home_screen.dart';
import 'package:community_islamic_app/views/home_screens/masjid_map/map_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/image_constants.dart';
import '../../controllers/home_controller.dart';
import '../../widgets/customized_bottom_bar.dart';
import '../donation_screens/donation_screen.dart';
import '../qibla_screen/qibla_screen.dart';
import '../quran_screen.dart/quran_screen.dart';
import 'masjid_map/order_traking_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    final List<Widget> _pages = [
      const HomeScreen(),
      QiblahScreen(),
      const QuranScreen(),
      DonationScreen()
    ];

    return Scaffold(
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            onPressed: () {
              Get.to(() => MapSplashScreen());
            },
            child: Image.asset(
              masjidIcon,
              height: 120,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
