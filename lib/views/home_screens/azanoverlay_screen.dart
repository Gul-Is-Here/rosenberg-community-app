import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/notification_service.dart'; // or any state management solution you use

class AzanOverlay extends StatelessWidget {
  final NotificationServices _notificationServices = Get.find<NotificationServices>();

  AzanOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Center(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Azan Time',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _notificationServices.stopAzan();
                  Navigator.pop(context); // Dismiss the overlay
                },
                child: Text('Stop Azan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
