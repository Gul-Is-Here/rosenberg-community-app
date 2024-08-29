import 'dart:io';

import 'package:community_islamic_app/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/login_controller.dart';
import '../../widgets/custome_drawer.dart';
import 'update_password_screen.dart';
import 'personal_info_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();

    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Stack(
              children: [
                Obx(() => CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          loginController.profileImage.value != null
                              ? FileImage(loginController.profileImage.value!)
                              : const AssetImage(masjidIcon) as ImageProvider,
                    )),
                Positioned(
                  bottom: 0,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      _pickImage(context);
                    },
                    iconSize: 24,
                    color: Colors.blue, // Adjust color as needed
                    padding: EdgeInsets.all(6.0),
                    constraints: BoxConstraints(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Obx(() => Text(
                  '${loginController.userFname.value} ${loginController.userLname.value}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            const SizedBox(height: 4),
            Obx(() => Text(
                  '${loginController.userEmail.value}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 10,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => UpdatePasswordScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.white, // Button background color
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Update Password',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Card(
                  shadowColor: Colors.grey,
                  elevation: 10,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Family Member button press
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shadowColor: Colors.white, // Button background color
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Family Member',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                'Personnel Information',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Get.to(() => PersonalInfoScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final LoginController loginController = Get.find<LoginController>();
      loginController.profileImage.value = File(pickedFile.path);
      // Here you should also upload the image to the server and update the user profile if needed.
    }
  }
}
