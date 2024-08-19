import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/constants/image_constants.dart';
import 'package:community_islamic_app/views/Gallery_Events/gallery_images_screen.dart.dart';
import 'package:community_islamic_app/views/Gallery_Events/gallery_videos_screen.dart';
import 'package:community_islamic_app/views/about_us/about_us.dart';
import 'package:community_islamic_app/views/project/project_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  void _showGalleryEventsDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              primaryColor,
              Color.fromARGB(255, 157, 210, 212),
            ]),
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            border: Border.all(color: Colors.black, width: 1),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: const Center(
            child: Text(
              'Gallery Events',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        content: const Text(
          'Choose an option:',
          style: TextStyle(
            fontSize: 18,
            color: CupertinoColors.black,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Get.back(); // Close the dialog
              Get.to(() =>
                  const GalleryImagesScreen()); // Navigate to Images screen
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Images',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Get.back(); // Close the dialog
              Get.to(() => GalleryVideosScreen()); // Navigate to Videos screen
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                'Videos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
            ),
          ),
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
              Get.snackbar('Info', 'Welcome to the About Us screen.');
            },
          ),
          // List Tile for Gallery Events
          ListTile(
            leading: Icon(Icons.photo_album, color: primaryColor),
            title: const Text('Gallery Events', style: TextStyle(fontSize: 18)),
            onTap: () {
              Get.back(); // Close the drawer
              _showGalleryEventsDialog(context); // Show the dialog
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
