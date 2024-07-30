import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/notification_service.dart';

class AzanoverlayScreen extends StatelessWidget {
  final NotificationServices notificationServices = NotificationServices();

  AzanoverlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Azan App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await notificationServices.stopAzan();
                Get.back();
              },
              child: const Text('Pray Now'),
            ),
            ElevatedButton(
              onPressed: () async {
                notificationServices.playAzan();
             
              },
              child: const Text('Pray Now'),
            ),
          ],
        ),
      ),
    );
  }
}
