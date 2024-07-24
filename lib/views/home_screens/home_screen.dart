import 'package:community_islamic_app/widgets/customized_desktop_layout.dart';
import 'package:community_islamic_app/widgets/customized_mobile_layout.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    DateTime date = DateTime.now();
    String formattedTime = "${date.hour}:${date.minute}";

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 800) {
            return CustomizedMobileLayout(
                screenHeight: screenHeight, formattedTime: formattedTime);
          } else {
            return CustomizedDesktopLayout(
                screenHeight: screenHeight, formattedTime: formattedTime);
          }
        },
      ),
    );
  }
}
