import 'package:flutter/material.dart';

class CusTomizedCardWidget extends StatelessWidget {
  final String title;
  final String imageIcon;
  final void Function() onTap;

  const CusTomizedCardWidget({
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
                screenWidth * 0.05), // Adjust padding based on screen width
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: screenHeight *
                        0.008), // Adjust height based on screen height
                Image.asset(
                  imageIcon,
                  width:
                      screenWidth * 0.12, // Adjust width based on screen width
                  height: screenHeight *
                      0.04, // Adjust height based on screen height
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
