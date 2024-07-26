import 'package:community_islamic_app/views/qibla_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/image_constants.dart';
import '../controllers/home_controller.dart';
import 'customized_card_widget.dart';
import 'customized_prayertext_widget.dart';
import 'customized_prayertime_widget.dart';

class CustomizedMobileLayout extends StatelessWidget {
  final double screenHeight;
  const CustomizedMobileLayout({super.key, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Obx(() {
      final prayerTimes = homeController.prayerTimes.value.data?.timings;
      final currentDate = homeController.prayerTimes.value.data?.date;

      // Function to get the current prayer time
      String getCurrentPrayer() {
        final now = DateTime.now();
        if (now.isBefore(DateFormat("HH:mm").parse(prayerTimes!.fajr))) {
          return 'Fajr';
        } else if (now.isBefore(DateFormat("HH:mm").parse(prayerTimes.dhuhr))) {
          return 'Dhuhr';
        } else if (now.isBefore(DateFormat("HH:mm").parse(prayerTimes.asr))) {
          return 'Asr';
        } else if (now
            .isBefore(DateFormat("HH:mm").parse(prayerTimes.maghrib))) {
          return 'Maghrib';
        } else if (now.isBefore(DateFormat("HH:mm").parse(prayerTimes.isha))) {
          return 'Isha';
        } else {
          return 'Isha'; // Default to Isha if current time is after all prayer times
        }
      }

      final currentPrayer = getCurrentPrayer();
      // Function to get the border color based on the current prayer

      // CURRECNT PRAYER TIME BODER COLOR CHNAGING METHOD
      Color getBorderColor(String prayer) {
        return prayer == currentPrayer ? Colors.yellow : Colors.white;
      }

      return Stack(
        children: [
          Container(
            height: screenHeight * 0.35,
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: CircleAvatar(
                        maxRadius: 35,
                        minRadius: 10,
                        backgroundColor: Colors.white,
                        child: Icon(
                          size: 50,
                          Icons.person,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                    10.widthBox,
                    const Text(
                      'Assalamualaikum \nGul Faraz',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                VxSwiper.builder(
                  autoPlayCurve: Curves.easeInCirc,
                  autoPlay: true,
                  viewportFraction: .8,
                  height: 145,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Text(
                        "Index $index",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ).box.rounded.color(Vx.amber500).make().p16();
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: screenHeight * 0.70,
              width: double.infinity,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                elevation: 10,
                color: Colors.white,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CusTomizedCardWidget(
                              title: 'About Us',
                              imageIcon: aboutUsIcon,
                              onTap: () {}),
                          CusTomizedCardWidget(
                              title: 'Qibla Direction',
                              imageIcon: qiblaIconBg,
                              onTap: () {
                                Get.to(() => QiblahScreen());
                              }),
                          CusTomizedCardWidget(
                              title: 'Ask Imam',
                              imageIcon: askImamIcon,
                              onTap: () {})
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CusTomizedCardWidget(
                              title: 'Donate',
                              imageIcon: donationIcon,
                              onTap: () {}),
                          CusTomizedCardWidget(
                              title: 'Contact Us',
                              imageIcon: contactUsIcon,
                              onTap: () {}),
                          CusTomizedCardWidget(
                              title: 'Gallery',
                              imageIcon: galleryIcon,
                              onTap: () {})
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Card(
                            elevation: 5,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ),
                            margin: EdgeInsets.zero,
                            child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                        namazQiblaBg,
                                      ),
                                      fit: BoxFit.cover)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  5.heightBox,
                                  const Text(
                                    'NAMAZ & IQAMA',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  CustomizedPrayerTextWidget(
                                      iconColor: Colors.white,
                                      color: Colors.white,
                                      title: 'PRAYER: ',
                                      prayerName: homeController
                                          .formatTime(prayerTimes!.asr)),
                                  CustomizedPrayerTextWidget(
                                      iconColor: Colors.white,
                                      color: Colors.white,
                                      icon: Icons.timelapse,
                                      title: "NAMAZ",
                                      prayerName:
                                          ': ${homeController.formatTime(prayerTimes.asr)}'),
                                  CustomizedPrayerTextWidget(
                                      iconColor: Colors.white,
                                      color: Colors.white,
                                      icon: Icons.timelapse,
                                      title: "IQAMA",
                                      prayerName:
                                          ': ${homeController.formatTime(prayerTimes.asr)}'),
                                  10.heightBox,
                                  Text(
                                    "${currentDate!.readable} ${currentDate.hijri.year} ${currentDate.hijri.weekday.ar} ${currentDate.hijri.day} ${currentDate.hijri.month.ar} ",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 9),
                                  ),
                                  10.heightBox,
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomizedPrayerTimeWidget(
                                            text: 'Fajr',
                                            time: homeController
                                                .formatTime(prayerTimes.fajr),
                                            image: sunriseIcon,
                                            color: getBorderColor('Fajr')),
                                        15.widthBox,
                                        CustomizedPrayerTimeWidget(
                                            text: 'Dhuhr',
                                            time: homeController
                                                .formatTime(prayerTimes.dhuhr),
                                            image: sunriseIcon,
                                            color: getBorderColor('Dhuhr')),
                                        15.widthBox,
                                        CustomizedPrayerTimeWidget(
                                            text: 'Asr',
                                            time: homeController
                                                .formatTime(prayerTimes.asr),
                                            image: sunriseIcon,
                                            color: getBorderColor('Asr')),
                                        15.widthBox,
                                        CustomizedPrayerTimeWidget(
                                            text: 'Maghrib',
                                            time: homeController.formatTime(
                                                prayerTimes.maghrib),
                                            image: sunriseIcon,
                                            color: getBorderColor('Maghrib')),
                                        15.widthBox,
                                        CustomizedPrayerTimeWidget(
                                            text: 'Isha',
                                            time: homeController
                                                .formatTime(prayerTimes.isha),
                                            image: sunriseIcon,
                                            color: getBorderColor('Isha')),
                                      ],
                                    ),
                                  ),
                                  10.heightBox,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.white)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 14, vertical: 4),
                                            child: Column(
                                              children: [
                                                const Text(
                                                  "JUMUAH KHUTBA",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11),
                                                ),
                                                Text(
                                                  homeController.formatTime(
                                                      DateFormat("HH:mm")
                                                          .format(DateFormat(
                                                                  "HH:mm")
                                                              .parse(prayerTimes
                                                                  .dhuhr)
                                                              .add(
                                                                  const Duration(
                                                                      minutes:
                                                                          1)))),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            child: Column(
                                              children: [
                                                const Text(
                                                  "JUMUAH IQAMAH",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11),
                                                ),
                                                Text(
                                                  homeController.formatTime(
                                                      DateFormat("HH:mm")
                                                          .format(DateFormat(
                                                                  "HH:mm")
                                                              .parse(prayerTimes
                                                                  .dhuhr)
                                                              .add(const Duration(
                                                                  minutes:
                                                                      31)))),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
