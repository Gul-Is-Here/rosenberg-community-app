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
            child: SizedBox(
              height: 300, // Limit the height for the scrollable area
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                      heroTag: 'email', // Unique heroTag
                      onPressed: () {
                        // Action for email/contact
                      },
                      backgroundColor: Colors.white,
                      mini: true,
                      child: Icon(
                        Icons.email,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton(
                      heroTag: 'call', // Unique heroTag
                      onPressed: () {
                        // Action for email/contact
                      },
                      backgroundColor: Colors.white,
                      mini: true,
                      child: const Icon(Icons.call, color: Colors.greenAccent),
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton(
                      heroTag: 'whatsapp', // Unique heroTag
                      onPressed: () {
                        // Action for email/contact
                      },
                      backgroundColor: Colors.white,
                      mini: true,
                      child: Image.asset(
                        icWhatsapp,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton(
                      heroTag: 'facebook', // Unique heroTag
                      onPressed: () {
                        // Action for Facebook
                      },
                      backgroundColor: Colors.white,
                      mini: true,
                      child: const Icon(
                        Icons.facebook,
                        color: Colors.blueAccent,
                      ), // Make the button smaller for compact layout
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
                      heroTag: 'instagram', // Unique heroTag
                      onPressed: () {
                        // Action for Instagram
                      },
                      backgroundColor: Colors.white,
                      mini: true,
                      child: Image.asset(icInstagram),
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
                    const SizedBox(height: 10),
                    FloatingActionButton(
                      heroTag: 'RccChat', // Unique heroTag
                      onPressed: () {
                        // Action for email/contact
                      },
                      backgroundColor: Colors.white,
                      mini: true,
                      child: const Icon(Icons.chat),
                    ),
                  ],
                ),
              ),
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
