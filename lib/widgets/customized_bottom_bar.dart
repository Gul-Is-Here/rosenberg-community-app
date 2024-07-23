import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/image_constants.dart';
import '../controllers/home_controller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final HomeController controller;
  const CustomBottomNavigationBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildNavItem(controller, 0, homeIcon),
              const SizedBox(width: 40),
              _buildNavItem(controller, 1, qiblaIconBg),
            ],
          ),
          Row(
            children: [
              _buildNavItem(controller, 2, quranIcon),
              const SizedBox(width: 40),
              _buildNavItem(controller, 3, donationIcon2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(HomeController controller, int index, String iconPath) {
    return GestureDetector(
      onTap: () {
        controller.changePage(index);
      },
      child: Obx(() {
        final isSelected = controller.selectedIndex.value == index;
        return Image.asset(
          iconPath,
          height: 60,
          width: 60,
          color: isSelected ? const Color(0xFF0F6467) : Colors.grey,
        );
      }),
    );
  }}