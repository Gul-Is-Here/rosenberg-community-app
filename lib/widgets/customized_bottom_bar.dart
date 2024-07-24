import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../constants/image_constants.dart';
import '../controllers/home_controller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final HomeController controller;
  const CustomBottomNavigationBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: SizedBox(
        height: 75,
        child: AnimatedNotchBottomBar(
          // showBottomRadius: true,
          elevation: 0,
          removeMargins: true,
          circleMargin: 0,
          bottomBarWidth: 0,
          showTopRadius: true,

          color: Colors.white,

          // topMargin: 0,
          // showBottomRadius: true,
          bottomBarItems: [
            BottomBarItem(
              activeItem: Image.asset(
                homeIcon2,
                height: 36, // Adjusted icon size
                width: 36, // Adjusted icon size
                color: const Color(0xFF0F6467),
              ),
              inActiveItem: Image.asset(
                homeIcon2,
                height: 36, // Adjusted icon size
                width: 36, // Adjusted icon size
                color: Colors.grey,
              ),
            ),
            BottomBarItem(
              activeItem: Image.asset(qiblaIconBg,
                  height: 50, // Adjusted icon size
                  width: 50, // Adjusted icon size
                  color: const Color(0xFF0F6467)),
              inActiveItem: Image.asset(
                qiblaIconBg,
                height: 50, // Adjusted icon size
                width: 50, // Adjusted icon size
                color: Colors.grey,
              ),
            ),
            BottomBarItem(
              activeItem: Image.asset(quranIcon,
                  height: 36, // Adjusted icon size
                  width: 36, // Adjusted icon size
                  color: const Color(0xFF0F6467)),
              inActiveItem: Image.asset(
                quranIcon,
                height: 36, // Adjusted icon size
                width: 36, // Adjusted icon size
                color: Colors.grey,
              ),
            ),
            BottomBarItem(
              activeItem: Image.asset(donationIcon2,
                  height: 36, // Adjusted icon size
                  width: 36, // Adjusted icon size
                  color: const Color(0xFF0F6467)),
              inActiveItem: Image.asset(
                donationIcon2,
                height: 36, // Adjusted icon size
                width: 36, // Adjusted icon size
                color: Colors.grey,
              ),
            ),
          ],
          onTap: (index) {
            controller.changePage(index);
          },
          kIconSize: 25,
          kBottomRadius: 35,
          notchBottomBarController: controller.notchBottomBarController,
        ),
      ),
    );
  }
}
