import 'dart:math';
import 'package:community_islamic_app/widgets/customized_prayertext_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../constants/image_constants.dart';
import '../controllers/home_controller.dart';
// import '../controllers/qiblah_controller.dart';

class QiblahScreen extends StatelessWidget {
  QiblahScreen({super.key});

  final QiblahController controller = Get.put(QiblahController());

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

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
                      color: Color.fromARGB(255, 68, 3, 72),
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
                      SizedBox(
                          height: screenHeight * 0.25 +
                              20), // Space for background card and 20-pixel gap
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomizedPrayerTextWidget(
                                    title: 'PRAYER: ', prayerName: 'ASR'),
                                CustomizedPrayerTextWidget(
                                    icon: Icons.timelapse,
                                    title: "NAMAZ",
                                    prayerName: ': 3 hours 45 mins'),
                                CustomizedPrayerTextWidget(
                                    icon: Icons.timelapse,
                                    title: "IQAMA",
                                    prayerName: ': 3 hours 45 mins')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                        .color(const Color.fromARGB(
                                            255, 43, 4, 94))
                                        .size(20)
                                        .make(),
                                    5.widthBox,
                                    const Icon(
                                      Icons.location_on,
                                      color: Color.fromARGB(255, 43, 4, 94),
                                    ),
                                  ],
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
                              height: screenHeight * 0.38,
                              width: screenWidth * 0.6,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        color: Colors.red, // Red container
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
                                child: Image.asset(
                                  imageOptions[index],
                                  height: screenHeight * 0.1,
                                  width: screenWidth * 0.2,
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
                  bottom: screenHeight * 0.1,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text("Unable to get Qiblah direction"),
                  ),
                );
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: Colors.amber,
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          // Handle navigation logic here
          // For example, navigate to different screens based on the index
        },
      ),
    );
  }
}
