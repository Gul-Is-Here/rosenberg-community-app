import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/constants/image_constants.dart';
import 'package:community_islamic_app/controllers/login_controller.dart';
import 'package:community_islamic_app/views/auth_screens/login_screen.dart';
import 'package:community_islamic_app/views/azan_settings/azan_settings_screen.dart';
import 'package:community_islamic_app/views/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  Future<void> _handleProfileNavigation() async {
    final loginController = Get.find<LoginController>();
    final isLoggedIn = await loginController.isLoggedIn();

    if (isLoggedIn) {
      Get.to(() => ProfileScreen());
    } else {
      Get.to(() => LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ensure you are using the same instance of LoginController that was used for the check
    final loginController = Get.find<LoginController>();

    return Drawer(
      width: 250,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo at the Top
            20.heightBox,
            Container(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  masjidIcon, // Path to your logo image
                  width: 80,
                  height: 80,
                ),
              ),
            ),

            // Optionally display user info if logged in
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Obx(() {
                return Text(
                  loginController.email.value.isNotEmpty
                      ? 'Hello, ${loginController.email.value}'
                      : 'Guest',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                );
              }),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'View Profile',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ).onTap(() async {
              await _handleProfileNavigation();
            }),

            const Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: Icon(Icons.timelapse, color: primaryColor),
              title: const Text('Prayer Notification',
                  style: TextStyle(fontSize: 14)),
              onTap: () {
                Get.to(() => const AzanSettingsScreen());
              },
            ),

            const Spacer(), // Pushes items to the top
            const Divider(), // Divider line
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '© 2024 Your Company',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
