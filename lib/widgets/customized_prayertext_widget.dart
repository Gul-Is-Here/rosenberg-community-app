import 'package:flutter/material.dart';

class CustomizedPrayerTextWidget extends StatelessWidget {
  final String prayerName;
  final String title;
  final Color color;
  final Color iconColor;
  final IconData? icon; // Changed to IconData type

  const CustomizedPrayerTextWidget({
    super.key,
    required this.color,
    required this.iconColor,
    required this.prayerName,
    required this.title,
    this.icon, // Optional parameter
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: screenHeight * 0.014, // Adjust font size
            fontWeight: FontWeight.bold,
          ),
        ),
        if (icon != null)
          Icon(
            icon,
            size: screenHeight * 0.02,
            color: iconColor,
          ), // Adjust icon size
        Text(
          prayerName,
          style: TextStyle(
            color: color,
            fontSize: screenHeight * 0.015, // Adjust font size
          ),
        ),
      ],
    );
  }
}
