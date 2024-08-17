import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/constants/image_constants.dart';
import 'package:community_islamic_app/views/about_us/about_us.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../views/project/project_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo at the Top
          20.heightBox,
          Container(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Image.asset(
                  masjidIcon, // Path to your logo image
                  width: 100,
                  height: 100,
                ),
              )),
          const SizedBox(height: 20),
          // List Tile for Project
          ListTile(
            leading: Icon(Icons.work, color: primaryColor),
            title: const Text('Projects', style: TextStyle(fontSize: 18)),
            onTap: () {
              Get.to(() => const ProjectScreen());
            },
          ),
          // List Tile for About Us
          ListTile(
            leading: Icon(Icons.info, color: primaryColor),
            title: const Text('About Us', style: TextStyle(fontSize: 18)),
            onTap: () {
              Get.to(() => AboutUsScreen());
              Get.snackbar('Info', 'Welcome to about us screen.');
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
    );
  }
}
