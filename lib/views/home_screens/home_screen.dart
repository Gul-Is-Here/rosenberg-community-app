// import 'package:community_islamic_app/views/donation_screens/donation_screen.dart';
// import 'package:community_islamic_app/views/home_screens/home_screen_content.dart';
// import 'package:community_islamic_app/views/qibla_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../constants/image_constants.dart';
// import '../../controllers/home_controller.dart';
// import '../quran_screen.dart/quran_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final HomeController controller = Get.put(HomeController());

//     final List<Widget> _pages = [
//       HomeScreenContent(),
//       QiblahScreen(),
//       const QuranScreen(),
//       const DonationScreen()
//     ];

//     return Scaffold(
//       body: Obx(() => Stack(
//             children: [
//               _pages[controller.selectedIndex.value],
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: CustomBottomNavigationBar(controller: controller),
//               ),
//             ],
//           )),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(bottom: 40),
//         child: SizedBox(
//           height: 70,
//           width: 70,
//           child: FloatingActionButton(
//             isExtended: true,
//             backgroundColor: Colors.transparent,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//             onPressed: () {},
//             child: Image.asset(
//               masjidIcon,
//               height: 100,
//             ),
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }

// class CustomBottomNavigationBar extends StatelessWidget {
//   final HomeController controller;
//   const CustomBottomNavigationBar({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       // notchMargin: 6.0,
//       height: 60,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               _buildNavItem(controller, 0, homeIcon),
//               const SizedBox(width: 40),
//               _buildNavItem(controller, 1, qiblaIconBg),
//             ],
//           ),
//           Row(
//             children: [
//               _buildNavItem(controller, 2, quranIcon),
//               const SizedBox(width: 40),
//               _buildNavItem(controller, 3, donationIcon2),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(HomeController controller, int index, String iconPath) {
//     return GestureDetector(
//       onTap: () {
//         controller.changePage(index);
//       },
//       child: Obx(() {
//         final isSelected = controller.selectedIndex.value == index;
//         return Image.asset(
//           iconPath,
//           height: 60,
//           width: 60,
//           color: isSelected ? const Color(0xFF0F6467) : Colors.grey,
//         );
//       }),
//     );
//   }
// }
