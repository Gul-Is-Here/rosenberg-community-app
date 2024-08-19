import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/constants/image_constants.dart';
import 'package:community_islamic_app/main.dart';
import 'package:community_islamic_app/views/auth_screens/login_screen.dart';
import 'package:community_islamic_app/views/home_screens/masjid_map/order_traking_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MapSplashScreen extends StatefulWidget {
  @override
  _MapSplashScreenState createState() => _MapSplashScreenState();
}

class _MapSplashScreenState extends State<MapSplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMainApp();
  }

  _navigateToMainApp() async {
    // Simulate a delay (e.g., loading resources, initialization, etc.)
    await Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => const OrderTrackingPage()); // Navigate to the main app
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(color: primaryColor),
      child: Stack(
        children: [
          Image.asset(splash1),
          Image.asset(splash2),
          Positioned(
            top: screenHeight * .3, //227
            left: screenWidth * .13,
            width: screenWidth * .75,
            height: 265, //50
            child: Image.asset(
              splash3,
            ),
          )
        ],
      ),
    );
  }
}
