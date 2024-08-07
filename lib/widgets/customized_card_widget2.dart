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

    return screenHeight > 700
        ? GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical:
                    screenWidth * 0.02, // Adjust padding based on screen width
              ),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(width: 2, color: Color(0xFF006367)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    screenWidth * 0.04, // Adjust padding based on screen width
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        imageIcon,
                        fit: BoxFit.cover,
                        width: screenWidth *
                            0.15, // Adjust width based on screen width
                        height: screenHeight *
                            0.08, // Adjust height based on screen height
                      ),
                      5.heightBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth *
                                0.02, // Adjust font size based on screen width
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.005,
                vertical:
                    screenWidth * 0.005, // Adjust padding based on screen width
              ),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(width: 2, color: Color(0xFF006367)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    screenWidth * 0.04, // Adjust padding based on screen width
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: screenHeight *
                              0.006), // Adjust height based on screen height
                      Image.asset(
                        imageIcon,
                        width: screenWidth *
                            0.10, // Adjust width based on screen width
                        height: screenHeight *
                            0.03, // Adjust height based on screen height
                      ),
                      5.heightBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth *
                                0.01, // Adjust font size based on screen width
                            fontWeight: FontWeight.w500,
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
