import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/constants/image_constants.dart';
import 'package:flutter/material.dart';

class SocialMediaFloatingButton extends StatefulWidget {
  @override
  _SocialMediaFloatingButtonState createState() =>
      _SocialMediaFloatingButtonState();
}

class _SocialMediaFloatingButtonState extends State<SocialMediaFloatingButton> {
  bool _showIcons = false;

  void _toggleIcons() {
    setState(() {
      _showIcons = !_showIcons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Conditionally showing social media icons when the button is clicked
        if (_showIcons)
          Positioned(
            bottom: 80.0, // Adjust position based on your design
            right: 16.0,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'facebook', // Unique heroTag
                  onPressed: () {
                    // Action for Facebook
                  },
                  backgroundColor: Colors.blueAccent,
                  mini: true,
                  child: const Icon(Icons
                      .facebook), // Make the button smaller for compact layout
                ),
                const SizedBox(
                    height:
                        10), // Spacing between buttons (was width, changed to height for vertical layout)
                FloatingActionButton(
                  heroTag: 'instagram', // Unique heroTag
                  onPressed: () {
                    // Action for Instagram
                  },
                  backgroundColor: Colors.pinkAccent,
                  mini: true,
                  child: const Icon(Icons.photo_camera),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'email', // Unique heroTag
                  onPressed: () {
                    // Action for email/contact
                  },
                  backgroundColor: Colors.orangeAccent,
                  mini: true,
                  child: const Icon(Icons.email),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'askImam', // Unique heroTag
                  onPressed: () {
                    // Action for email/contact
                  },
                  backgroundColor: Colors.white,
                  mini: true,
                  child: Image.asset(askImamIcon),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'youtube', // Unique heroTag
                  onPressed: () {
                    // Action for email/contact
                  },
                  backgroundColor: Colors.white,
                  mini: true,
                  child: Image.asset(
                    icyoutube,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'connectus', // Unique heroTag
                  onPressed: () {
                    // Action for email/contact
                  },
                  backgroundColor: Colors.white,
                  mini: true,
                  child: const Icon(Icons.connect_without_contact),
                ),
              ],
            ),
          ),

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
            onPressed: _toggleIcons, // Toggle social media icons
            child: Icon(
              _showIcons ? Icons.close : Icons.add,
              color: Colors.white,
            ), // Change icon based on state
          ),
        ),
      ],
    );
  }
}
