import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/constants/image_constants.dart';
import 'package:community_islamic_app/views/namaz_timmings/namaztimmings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialMediaFloatingButton extends StatelessWidget {
  const SocialMediaFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main FloatingActionButton
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            heroTag: 'toggle', // Unique heroTag for the main button
            focusColor: primaryColor,
            splashColor: primaryColor,
            backgroundColor: primaryColor,
            mini: true,
            onPressed: () =>
                _showSocialMediaDialog(context), // Show dialog on press
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // Method to show the social media icons dialog
  void _showSocialMediaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Connect with RCC',
            style: TextStyle(
              fontFamily: popinsSemiBold,
              fontSize: 18,
              color: primaryColor,
            ),
          ),
          content: SingleChildScrollView(
            // Wrap in SingleChildScrollView
            child: SizedBox(
              width: double.maxFinite,
              child: GridView.count(
                shrinkWrap: true, // Prevent overflow
                physics:
                    const NeverScrollableScrollPhysics(), // Disable GridView scrolling
                crossAxisCount: 3, // Number of icons per row
                crossAxisSpacing: 15.0, // Spacing between columns
                mainAxisSpacing: 15.0, // Spacing between rows
                children: [
                  _buildSocialMediaButton(
                    icon: Image.asset(askImamIcon),
                    label: 'Ask Imam',
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog after action
                    },
                  ),
                  _buildSocialMediaButton(
                    icon: Icon(Icons.email, color: primaryColor),
                    label: 'Email Us',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  _buildSocialMediaButton(
                    icon: const Icon(Icons.call, color: Colors.greenAccent),
                    label: 'Call Us',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  _buildSocialMediaButton(
                    icon: Image.asset(icWhatsapp),
                    label: 'WhatsApp',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  _buildSocialMediaButton(
                    icon: const Icon(Icons.facebook, color: Colors.blueAccent),
                    label: 'Facebook',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  _buildSocialMediaButton(
                    icon: Image.asset(
                      fit: BoxFit.cover,
                      icyoutube,
                    ),
                    label: 'YouTube',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  _buildSocialMediaButton(
                    icon: Image.asset(icInstagram),
                    label: 'Instagram',
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog first
                      Get.to(() =>
                          const NamazTimingsScreen()); // Navigate after closing
                    },
                  ),
                  _buildSocialMediaButton(
                    icon: Icon(
                      Icons.connect_without_contact,
                      color: primaryColor,
                    ),
                    label: 'Contact',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  _buildSocialMediaButton(
                    icon: Icon(
                      Icons.chat,
                      color: primaryColor,
                    ),
                    label: 'RCC Chat',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Helper method to build each social media button with equal icon size
  Widget _buildSocialMediaButton({
    required Widget icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: SizedBox(
              width: 30, // Set a fixed width
              height: 30, // Set a fixed height
              child: FittedBox(
                fit: BoxFit.cover,
                child: icon, // The icon will fit inside this box
              ),
            ),
          ),
          const SizedBox(height: 8), // Space between icon and label
          Text(
            label,
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
