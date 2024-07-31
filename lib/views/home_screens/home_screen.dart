import 'package:flutter/material.dart';
import 'package:community_islamic_app/widgets/customized_mobile_layout.dart';

import '../../services/notification_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
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
