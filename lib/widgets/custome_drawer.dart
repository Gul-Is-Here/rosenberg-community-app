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

  @override
  Widget build(BuildContext context) {
    var loginController = Get.put(LoginController());
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '${loginController.userFname.value} ${loginController.userLname.value}', // This should be dynamic if user is logged in
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'View Profile',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ).onTap(() {
              if (loginController.userEmail.value.isEmpty ||
                  loginController.userFname.value.isEmpty) {
                // If the user is not logged in, navigate to the login screen
                Get.to(() => const LoginScreen());
              } else {
                // If the user is logged in, navigate to the profile screen
                Get.to(() => const ProfileScreen());
              }
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
