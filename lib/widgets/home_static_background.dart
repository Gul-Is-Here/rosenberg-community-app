import 'dart:math';
import 'package:community_islamic_app/views/about_us/about_us.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:get/get.dart';
import 'package:community_islamic_app/controllers/home_controller.dart';
import 'package:community_islamic_app/controllers/qibla_controller.dart';
import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/constants/image_constants.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeStaticBackground extends StatelessWidget {
  HomeStaticBackground({super.key, required this.screenHeight});

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final homeController = Get.find<HomeController>();
    final qiblahController = Get.put(QiblahController());

    return Container(
      height: screenHeight * 0.24,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(homeBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildDateAndCompassExpanded(homeController)),
              Expanded(
                  child: _buildQiblahIndicator(
                      context, screenWidth, qiblahController)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDateAndCompassExpanded(HomeController homeController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  if (homeController.prayerTime.value.data != null) {
                    final gregorian =
                        homeController.prayerTime.value.data!.date.gregorian;
                    final hijri =
                        homeController.prayerTime.value.data!.date.hijri;

                    return Text(
                      '${gregorian.month.en} ${gregorian.day}, ${gregorian.year}\n'
                      '${hijri.weekday.en} ${hijri.day} ${hijri.month.en} ${hijri.year}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 9,
                        color: Colors.white,
                        fontFamily: popinsRegulr,
                      ),
                    );
                  } else {
                    return const Text('');
                  }
                }),
                Text(
                  'Next Prayer Time',
                  style: TextStyle(color: asColor, fontFamily: popinsSemiBold),
                ),
                Text(
                  '(${homeController.getCurrentPrayer()})',
                  style: TextStyle(color: asColor, fontFamily: popinsSemiBold),
                ),
                10.heightBox,
                Row(
                  children: [
                    const Icon(
                      Icons.timelapse,
                      color: Colors.white,
                    ),
                    5.widthBox,
                    Text(
                      homeController.formatPrayerTime(
                        homeController.getPrayerTimes().toString(),
                      ),
                      style: const TextStyle(
                          color: Colors.white, fontFamily: popinsBold),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQiblahIndicator(
      BuildContext context, double screenWidth, QiblahController controller) {
    return Expanded(
      child: StreamBuilder<QiblahDirection>(
        stream: FlutterQiblah.qiblahStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF006367)),
            );
          }

          if (snapshot.hasData) {
            final qiblahDirection = snapshot.data!;
            controller.animation = Tween(
              begin: controller.begin,
              end: (qiblahDirection.qiblah * (pi / 180) * -1),
            ).animate(controller.animationController);
            controller.begin = (qiblahDirection.qiblah * (pi / 180) * -1);
            controller.animationController.forward(from: 0);

            return Center(
              child: AnimatedBuilder(
                animation: controller.animation,
                builder: (context, child) => Transform.rotate(
                  angle: controller.animation.value,
                  child: Image.asset(
                    compass,
                    height: screenHeight * 0.2,
                    width: screenWidth * 0.5,
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: const Text(
                "Unable to get Qiblah direction,\n       Please restart the app",
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
