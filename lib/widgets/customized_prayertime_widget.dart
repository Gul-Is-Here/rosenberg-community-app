import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomizedPrayerTimeWidget extends StatelessWidget {
  final String time;
  final String image;
  final String text;
  const CustomizedPrayerTimeWidget(
      {super.key, required this.text, required this.time, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
            5.heightBox,
            Image.asset(
              image,
              height: 25,
              width: 25,
            ),
            5.heightBox,
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 11),
            )
          ],
        ),
      ),
    );
  }
}
