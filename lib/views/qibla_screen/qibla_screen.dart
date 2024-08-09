import 'dart:math';
import 'package:community_islamic_app/controllers/home_controller.dart';
import 'package:community_islamic_app/widgets/customized_prayertext_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants/image_constants.dart';
import '../../controllers/qibla_controller.dart';

// ignore: must_be_immutable
class QiblahScreen extends StatelessWidget {
  QiblahScreen({super.key});

  final QiblahController controller = Get.put(QiblahController());
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    String? currentIqamaTime = homeController.getCurrentIqamaTime();

    print('Qibla Screen $currentIqamaTime');

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Card(
              elevation: 10,
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Container(
                height: screenHeight * 0.25,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: AssetImage(qiblaTopBg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.01,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    maxRadius: 35,
                    minRadius: 10,
                    backgroundColor: Colors.white,
                    child: Icon(
                      size: 60,
                      Icons.person,
                      color: Colors.amber,
                    ),
                  ),
                  20.widthBox,
                  const Text(
                    'Assalamualaikum \nGul Faraz',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.13,
            left: screenWidth * 0.3,
            child: Text(
              'Qiblah Direction',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          StreamBuilder(
            stream: FlutterQiblah.qiblahStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Positioned(
                  bottom: screenHeight * 0.2,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: Color(0xFF006367),
                    ),
                  ),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomizedPrayerTextWidget(
                                    iconColor: Colors.white,
                                    color: Colors.black,
                                    title: 'PRAYER: ',
                                    prayerName:
                                        homeController.currentPrayerTime!),
                                CustomizedPrayerTextWidget(
                                    iconColor: Colors.white,
                                    color: Colors.black,
                                    icon: Icons.timelapse,
                                    title: "NAMAZ",
                                    prayerName: homeController.formatPrayerTime(
                                        homeController
                                            .getPrayerTimes()
                                            .toString())),
                                CustomizedPrayerTextWidget(
                                    iconColor: Colors.white,
                                    color: Colors.black,
                                    icon: Icons.timelapse,
                                    title: "IQAMA",
                                    prayerName: currentIqamaTime)
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(
                                        () => Text(
                                          '${controller.locationCountry}, ${controller.locationCity}',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: screenHeight * 0.015,
                                          ),
                                        ),
                                      ),
                                      5.widthBox,
                                      "|"
                                          .text
                                          .color(Color(0xFF006367))
                                          .size(20)
                                          .make(),
                                      5.widthBox,
                                      const Icon(
                                        Icons.location_on,
                                        color: Color(0xFF006367),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: AnimatedBuilder(
                          animation: controller.animation,
                          builder: (context, child) => Transform.rotate(
                            angle: controller.animation.value,
                            child: Image.asset(
                              controller.selectedImage.value,
                              height: screenHeight * 0.3,
                              width: screenWidth * 0.5,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Color(0xFF006367),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            'Theme',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            imageOptions.length,
                            (index) => GestureDetector(
                              onTap: () {
                                controller.selectedImage.value =
                                    imageOptions[index];
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        width: 5, color: Color(0xFF006367)),
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.asset(
                                      imageOptions[index],
                                      height: screenHeight * 0.08,
                                      width: screenWidth * 0.16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Positioned(
                  bottom: screenHeight * 0.5,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Unable to get Qiblah direction,\n       Please restart the app",
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
