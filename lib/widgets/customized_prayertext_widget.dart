import 'package:flutter/material.dart';

class CustomizedPrayerTextWidget extends StatelessWidget {
  final String prayerName;
  final String title;
  final IconData? icon; // Changed to IconData type

  const CustomizedPrayerTextWidget({
    super.key,
    required this.prayerName,
    required this.title,
    this.icon, // Optional parameter
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: screenHeight * 0.015, // Adjust font size
            fontWeight: FontWeight.bold,
          ),
        ),
        if (icon != null)
          Icon(icon, size: screenHeight * 0.02), // Adjust icon size
        Text(
          prayerName,
          style: TextStyle(
            color: Colors.black,
            fontSize: screenHeight * 0.015, // Adjust font size
          ),
        ),
      ],
    );
  }
}
