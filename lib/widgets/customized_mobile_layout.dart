import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/image_constants.dart';
import '../controllers/home_controller.dart';
import '../services/notification_service.dart';
import '../model/prayer_times_static_model.dart';
import '../views/qibla_screen.dart';
import 'customized_card_widget.dart';
import 'customized_prayertext_widget.dart';
import 'customized_prayertime_widget.dart';

// ignore: must_be_immutable
class CustomizedMobileLayout extends StatelessWidget {
  final double screenHeight;
  CustomizedMobileLayout({super.key, required this.screenHeight});

  final HomeController homeController = Get.put(HomeController());
  final NotificationServices notificationServices = NotificationServices();

  String? currentPrayerTime;

  String? currentIqamaTime;

  // @override
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            HomeStaticBackground(screenHeight: screenHeight),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .28),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  margin: const EdgeInsets.all(0),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  elevation: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      10.heightBox,
                      const HomeCardRow1(),
                      const HomeCardRow(),
                      10.heightBox,
                      Obx(() {
                        if (homeController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        var prayerTimes =
                            homeController.prayerTimes.value.data?.timings;
                        if (prayerTimes == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final currentDate =
                            homeController.prayerTimes.value.data?.date;
                        print('Current Date : $currentDate');
                        final jummaTime =
                            homeController.jummaTimes.value.data?.jumah;
                        homeController.adjustment =
                            homeController.jummaTimes.value.data?.adjustment;
                        homeController.adjustment =
                            homeController.adjustment.apiAdjustAdjustment;

                        var currentPrayer = getCurrentPrayer();
                        var currentIqamaTime = getCurrentIqamaTime();
                        currentPrayerTime = getCurrentPrayer();
                        currentIqamaTime = getCurrentIqamaTime();
                        // Update the widget every minute to ensure time is current
                        print('Current Prayer Time : $currentPrayer');
                        print('Adjusment : ${homeController.adjustment}');
                        print('Current Iqama Time : $currentIqamaTime');

                        return Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.38,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 10.heightBox,
                                    Expanded(
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
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.center,
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.center,

                                          children: [
                                            10.heightBox,
                                            // NAMAZ AND IQAMA TIME WIDGETS
                                            const Text(
                                              'NAMAZ & IQAMA',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),

                                            CustomizedPrayerTextWidget(
                                                iconColor: Colors.white,
                                                color: Colors.white,
                                                title: 'PRAYER: ',
                                                prayerName: currentPrayer),

                                            // Current Adhan
                                            CustomizedPrayerTextWidget(
                                              iconColor: Colors.white,
                                              color: Colors.white,
                                              icon: Icons.timelapse,
                                              title: "NAMAZ",
                                              prayerName:
                                                  ': ${formatPrayerTime(getPrayerTimes().toString())}',
                                            ),

                                            CustomizedPrayerTextWidget(
                                              iconColor: Colors.white,
                                              color: Colors.white,
                                              icon: Icons.timelapse,
                                              title: "IQAMA",
                                              prayerName: ': $currentIqamaTime',
                                            ),
                                            10.heightBox,
                                            Text(
                                              "${currentDate?.readable} ${currentDate?.hijri.year} ${currentDate?.hijri.weekday.ar} ${currentDate?.hijri.day} ${currentDate?.hijri.month.ar} ",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9),
                                            ),
                                            // End here
                                            10.heightBox,
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomizedPrayerTimeWidget(
                                                      text: 'Fajr',
                                                      time: formatPrayerTime(
                                                          prayerTimes.fajr),
                                                      image: sunriseIcon,
                                                      color: currentPrayer ==
                                                              'Fajr'
                                                          ? Colors.yellow
                                                          : Colors.white),
                                                  5.widthBox,
                                                  CustomizedPrayerTimeWidget(
                                                      text: 'Dhuhr',
                                                      time: formatPrayerTime(
                                                          prayerTimes.dhuhr),
                                                      image: sunriseIcon,
                                                      color: currentPrayer ==
                                                              'Dhuhr'
                                                          ? Colors.yellow
                                                          : Colors.white),
                                                  5.widthBox,
                                                  CustomizedPrayerTimeWidget(
                                                      text: 'Asr',
                                                      time: formatPrayerTime(
                                                          prayerTimes.asr),
                                                      image: sunriseIcon,
                                                      color:
                                                          currentPrayer == 'Asr'
                                                              ? Colors.yellow
                                                              : Colors.white),
                                                  5.widthBox,
                                                  CustomizedPrayerTimeWidget(
                                                      text: 'Maghrib',
                                                      time: formatPrayerTime(
                                                          prayerTimes.maghrib),
                                                      image: sunriseIcon,
                                                      color: currentPrayer ==
                                                              'Maghrib'
                                                          ? Colors.yellow
                                                          : Colors.white),
                                                  5.widthBox,
                                                  CustomizedPrayerTimeWidget(
                                                      text: 'Isha',
                                                      time: formatPrayerTime(
                                                          prayerTimes.isha),
                                                      image: sunriseIcon,
                                                      color: currentPrayer ==
                                                              'Isha'
                                                          ? Colors.yellow
                                                          : Colors.white),
                                                ],
                                              ),
                                            ),
                                            10.heightBox,
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            width: 2,
                                                            color:
                                                                Colors.white)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            "JUMUAH KHUTBA",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 11),
                                                          ),
                                                          Text(
                                                            homeController
                                                                .formatTime(
                                                              DateFormat(
                                                                      "HH:mm")
                                                                  .format(
                                                                DateFormat(
                                                                        "HH:mm")
                                                                    .parse(jummaTime!
                                                                        .prayerTiming),
                                                              ),
                                                            ),
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 11),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            width: 2)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            "JUMUAH IQAMAH",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 11),
                                                          ),
                                                          Text(
                                                            homeController
                                                                .formatTime(
                                                              DateFormat(
                                                                      "HH:mm")
                                                                  .format(
                                                                DateFormat(
                                                                        "HH:mm")
                                                                    .parse(jummaTime
                                                                        .iqamahTiming),
                                                              ),
                                                            ),
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
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
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String getCurrentPrayer() {
    final now = DateTime.now();
    final timeNow =
        DateFormat("HH:mm").format(now); // Formatting the current time
    var newTime = DateFormat("HH:mm").parse(timeNow);

    // Check if prayer times data is available
    if (homeController.prayerTimes.value.data?.timings != null) {
      final timings = homeController.prayerTimes.value.data!.timings;

      // Parse prayer times from the API data
      final fajrTime = DateFormat("HH:mm").parse(timings.fajr);
      final dhuhrTime = DateFormat("HH:mm").parse(timings.dhuhr);
      final asrTime = DateFormat("HH:mm").parse(timings.asr);
      final maghribTime = DateFormat("HH:mm").parse(timings.maghrib);
      final ishaTime = DateFormat("HH:mm").parse(timings.isha);

      // Compare the current time with prayer times
      if (newTime.isBefore(fajrTime)) {
        return 'Fajr';
      } else if (newTime.isBefore(dhuhrTime)) {
        return 'Dhuhr';
      } else if (newTime.isBefore(asrTime)) {
        return 'Asr';
      } else if (newTime.isBefore(maghribTime)) {
        return 'Maghrib';
      } else if (newTime.isBefore(ishaTime)) {
        return 'Isha';
      } else {
        // If current time is after all prayer times, default to Fajr of the next day
        return 'Fajr';
      }
    }

    // Return a default prayer time if prayer times are not available
    return 'Isha';
  }

  // Function to find the current Iqama timings based on the current prayer time
  String getCurrentIqamaTime() {
    DateTime now = DateTime.now();
    String currentDateStr = DateFormat('d/M').format(now);

    DateTime currentDate = parseDate(currentDateStr);

    print('Current date: ${currentDate.toLocal()}'); // Debugging line

    for (var timing in iqamahTiming) {
      DateTime startDate = parseDate(timing.startDate);
      DateTime endDate = parseDate(timing.endDate);

      print(
          'Checking date range: ${startDate.toLocal()} to ${endDate.toLocal()}'); // Debugging line

      // Ensure the date range includes the current date
      if (currentDate.isAfter(startDate.subtract(Duration(days: 1))) &&
          currentDate.isBefore(endDate.add(Duration(days: 1)))) {
        switch (currentPrayerTime) {
          case 'Fajr':
            return timing.fjar;
          case 'Dhuhr':
            return timing.zuhr;
          case 'Asr':
            return timing.asr;
          case 'Maghrib':
            final maghribTime = now.add(const Duration(minutes: 5));
            return DateFormat("h:mm a").format(maghribTime);
          case 'Isha':
            return timing.isha;
          default:
            return "Invalid prayer time";
        }
      }
    }

    return "Iqama time not found";
  }

// Function to parse a date string in "d/M" format to DateTime
  DateTime parseDate(String dateStr) {
    return DateFormat('d/M').parse(dateStr);
  }

  Object? getPrayerTimes() {
    if (currentPrayerTime == 'Fajr') {
      return homeController.prayerTimes.value.data?.timings.fajr;
    } else if (currentPrayerTime == 'Dhuhr') {
      return homeController.prayerTimes.value.data?.timings.dhuhr;
    } else if (currentPrayerTime == 'Asr') {
      return homeController.prayerTimes.value.data?.timings.asr;
    } else if (currentPrayerTime == 'Maghrib') {
      return homeController.prayerTimes.value.data?.timings.maghrib;
    } else {
      return homeController.prayerTimes.value.data?.timings.isha;
    }
  }

  // Function to format prayer time
  String formatPrayerTime(String time) {
    try {
      final dateTime = DateFormat("HH:mm").parse(time);
      return DateFormat("h:mm a").format(dateTime);
    } catch (e) {
      return time;
    }
  }
}

class HomeCardRow1 extends StatelessWidget {
  const HomeCardRow1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CusTomizedCardWidget(
            title: 'About Us', imageIcon: aboutUsIcon, onTap: () {}),
        CusTomizedCardWidget(
            title: 'Qibla Direction',
            imageIcon: qiblaIconBg,
            onTap: () {
              Get.to(() => QiblahScreen());
            }),
        CusTomizedCardWidget(
            title: 'Ask Imam', imageIcon: askImamIcon, onTap: () {})
      ],
    );
  }
}

class HomeCardRow extends StatelessWidget {
  const HomeCardRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CusTomizedCardWidget(
            title: 'Donate', imageIcon: donationIcon, onTap: () {}),
        CusTomizedCardWidget(
            title: 'Contact Us', imageIcon: contactUsIcon, onTap: () {}),
        CusTomizedCardWidget(
            title: 'Gallery', imageIcon: galleryIcon, onTap: () {})
      ],
    );
  }
}

class HomeStaticBackground extends StatelessWidget {
  const HomeStaticBackground({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.3,
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
    );
  }
}
