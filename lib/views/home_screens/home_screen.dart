import 'package:community_islamic_app/views/donation_screens/donation_screen.dart';
import 'package:community_islamic_app/views/project/project_screen.dart';
import 'package:community_islamic_app/widgets/custome_drawer.dart';
import 'package:flutter/material.dart';
import 'package:community_islamic_app/widgets/customized_mobile_layout.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        toolbarHeight: 35,
      ),
      body: Column(
        children: [
          CustomizedMobileLayout(
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }
}
