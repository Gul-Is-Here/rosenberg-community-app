import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

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
          vertical: screenWidth * 0.0,
        ), // Adjust padding based on screen width
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(width: 5, color: Color(0xFF006367))),
          child: Padding(
            padding: EdgeInsets.all(
                screenWidth * 0.02), // Adjust padding based on screen width
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Adjust height based on screen height
                Image.network(
                  imageIcon, fit: BoxFit.cover,
                  width:
                      screenWidth * 0.15, // Adjust width based on screen width
                  height: screenHeight *
                      0.08, // Adjust height based on screen height
                ),
                5.heightBox,
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: RichText(
                    text: TextSpan(
                      text: title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth *
                            0.025, // Adjust font size based on screen width
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
