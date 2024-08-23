import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/constants/image_constants.dart';
import 'package:community_islamic_app/views/auth_screens/login_screen.dart';
import 'package:community_islamic_app/views/home_screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToAppropriateScreen();
  }

  Future<void> _navigateToAppropriateScreen() async {
    // Simulate a delay (e.g., loading resources, initialization, etc.)
    await Future.delayed(Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // Navigate to Home screen if user is logged in
      Get.offAll(() => Home());
    } else {
      // Navigate to Login screen if user is not logged in
      Get.offAll(() => const Home());
    }
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
            top: screenHeight * .3,
            left: screenWidth * .13,
            width: screenWidth * .75,
            height: 265,
            child: Image.asset(
              splash3,
            ),
          )
        ],
      ),
    );
  }
}
