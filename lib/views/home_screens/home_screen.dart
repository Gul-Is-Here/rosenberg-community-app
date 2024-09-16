import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/controllers/home_controller.dart';
import 'package:community_islamic_app/widgets/custome_drawer.dart';
import 'package:flutter/material.dart';
import 'package:community_islamic_app/widgets/customized_mobile_layout.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the drawer icon color to white
        ),
        title: Obx(() {
          if (homeController.prayerTime.value.data != null) {
            final gregorian =
                homeController.prayerTime.value.data!.date.gregorian;
            final hijri = homeController.prayerTime.value.data!.date.hijri;

            // Display Gregorian and Hijri dates in the AppBar
            return Text(
              '${gregorian.month.en} ${gregorian.day}, ${gregorian.year} - ' // Gregorian
              '${hijri.weekday.en} ${hijri.day} ${hijri.month.en} ${hijri.year}H', // Hijri
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily:
                      popinsRegulr), // Adjust font size to fit in AppBar
            );
          } else {
            return const Text(
                ''); // Show a loader if the data isn't available yet
          }
        }),
      ),
      body: Column(
        children: [
          CustomizedMobileLayout(
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }
}
