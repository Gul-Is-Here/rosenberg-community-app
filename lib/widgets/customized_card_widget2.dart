import 'package:flutter/material.dart';

class CusTomizedCardWidget2 extends StatelessWidget {
  final String title;
  final String imageIcon;
  final void Function() onTap;

  const CusTomizedCardWidget2({
    super.key,
    required this.title,
    required this.imageIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.01,
        ), // Adjust padding based on screen width
        child: Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: EdgeInsets.all(
                screenWidth * 0.02), // Adjust padding based on screen width
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Adjust height based on screen height
                Image.asset(
                  imageIcon,
                  width:
                      screenWidth * 0.18, // Adjust width based on screen width
                  height: screenHeight *
                      0.1, // Adjust height based on screen height
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth *
                        0.025, // Adjust font size based on screen width
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
