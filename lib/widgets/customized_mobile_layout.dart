import 'package:community_islamic_app/controllers/login_controller.dart';
import 'package:community_islamic_app/views/Gallery_Events/ask_imam_screen.dart';
import 'package:community_islamic_app/views/Gallery_Events/galler_screen.dart';
import 'package:community_islamic_app/views/about_us/about_us.dart';
import 'package:community_islamic_app/views/contact_us/contact_us_screen.dart';
import 'package:community_islamic_app/views/project/project_screen.dart';
import 'package:community_islamic_app/widgets/customized_asr_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/color.dart';
import '../constants/image_constants.dart';
import '../controllers/home_controller.dart';
import '../services/notification_service.dart';
import '../model/prayer_times_static_model.dart';
import '../views/qibla_screen/qibla_screen.dart';
import 'customized_card_widget.dart';
import 'customized_prayertext_widget.dart';
import 'customized_prayertime_widget.dart';
import 'home_static_background.dart';

// ignore: must_be_immutable
class CustomizedMobileLayout extends StatelessWidget {
  final double screenHeight;
  CustomizedMobileLayout({super.key, required this.screenHeight});

  final HomeController homeController = Get.put(HomeController());
  final NotificationServices notificationServices = NotificationServices();

  String? currentIqamaTime;

  // @override
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    final screenHeight1 = MediaQuery.of(context).size.height;
    print(screenHeight1);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            HomeStaticBackground(
              screenHeight: screenHeight,
              // dateTime: homeController.prayerTimes.value.data!.date.readable,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .25),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  color: Colors.white,
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
                      HomeCardRow1(),
                      HomeCardRow(),
                      10.heightBox,
                      Obx(() {
                        if (homeController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        var prayerTimes =
                            homeController.prayerTime.value.data?.timings;
                        if (prayerTimes == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final currentDate =
                            homeController.prayerTime.value.data?.date;
                        print('Current Date : $currentDate');
                        final jummaTime =
                            homeController.jummaTimes.value.data?.jumah;
                        homeController.adjustment =
                            homeController.jummaTimes.value.data?.adjustment;
                        homeController.adjustment =
                            homeController.adjustment.apiAdjustAdjustment;

                        var currentPrayer = getCurrentPrayer();
                        final azanName = getAllAzanNamesForCurrentDate();
                        // var currentIqamaTime = getAllIqamaTimes();
                        final iqamaTime = getAllIqamaTimes();
                        homeController.currentPrayerTime = getCurrentPrayer();
                        // currentIqamaTime = getAllIqamaTimes();
                        // Update the widget every minute to ensure time is current
                        print('Current Prayer Time : $currentPrayer');
                        print('Adjusment : ${homeController.adjustment}');
                        print('Current Iqama Time : $currentIqamaTime');

                        return Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.30,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 10.heightBox,
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20)),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                    namazQiblaBg,
                                                  ),
                                                  fit: BoxFit.cover)),
                                          child: Column(
                                            children: [
                                              10.heightBox,
                                              // NAMAZ AND IQAMA TIME WIDGETS
                                              //  Text(
                                              //   'NAMAZ & IQAMA',
                                              //   style: TextStyle(
                                              //       color: Colors.white,
                                              //       fontSize: 16),
                                              // ),

                                              // CustomizedPrayerTextWidget(
                                              //     iconColor: Colors.white,
                                              //     color: Colors.white,
                                              //     title: 'PRAYER: ',
                                              //     prayerName: currentPrayer),

                                              // Current Adhan
                                              // Padding(
                                              //   padding:
                                              //       const EdgeInsets.symmetric(
                                              //           horizontal: 8.0),
                                              //   child: Row(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment
                                              //             .spaceBetween,
                                              //     children: [
                                              //       CustomizedPrayerTextWidget(
                                              //         iconColor: Colors.white,
                                              //         color: Colors.white,
                                              //         icon: Icons.timelapse,
                                              //         title: "NAMAZ",
                                              //         prayerName:
                                              //             ': ${formatPrayerTime(getPrayerTimes().toString())}',
                                              //       ),
                                              //       CustomizedPrayerTextWidget(
                                              //         iconColor: Colors.white,
                                              //         color: Colors.white,
                                              //         icon: Icons.timelapse,
                                              //         title: "IQAMA",
                                              //         prayerName:
                                              //             ': $currentIqamaTime',
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),

                                              // Text(
                                              //   "${currentDate?.readable} ${currentDate?.hijri.year} ${currentDate?.hijri.weekday.ar} ${currentDate?.hijri.day} ${currentDate?.hijri.month.ar} ",
                                              //   style:  TextStyle(
                                              //       color: Colors.white,
                                              //       fontSize: 9),
                                              // ),
                                              // End here
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomizedPrayerTimeWidget(
                                                        azazName:
                                                            azanName['Fajr']!,
                                                        text:
                                                            iqamaTime['Fajr']!,
                                                        time: formatPrayerTime(
                                                            prayerTimes.fajr),
                                                        image: sunriseIcon,
                                                        color: currentPrayer ==
                                                                'Fajr'
                                                            ? Colors.yellow
                                                            : Colors.white),
                                                    5.widthBox,
                                                    CustomizedPrayerTimeWidget(
                                                        azazName:
                                                            azanName['Dhuhr']!,
                                                        text:
                                                            iqamaTime['Dhuhr']!,
                                                        time: formatPrayerTime(
                                                            prayerTimes.dhuhr),
                                                        image: sunriseIcon,
                                                        color: currentPrayer ==
                                                                'Dhuhr'
                                                            ? Colors.yellow
                                                            : Colors.white),
                                                    5.widthBox,
                                                    CustomizedPrayerTimeWidget(
                                                        azazName:
                                                            azanName['Asr']!,
                                                        text: iqamaTime['Asr']!,
                                                        time: formatPrayerTime(
                                                            prayerTimes.asr),
                                                        image: sunsetIcon,
                                                        color: currentPrayer ==
                                                                'Maghrib'
                                                            ? Colors.yellow
                                                            : Colors.white),
                                                    5.widthBox,
                                                    CustomizedPrayerTimeWidget(
                                                        azazName: azanName[
                                                            'Maghrib']!,
                                                        text:
                                                            addMinutesToPrayerTime(
                                                                prayerTimes
                                                                    .maghrib,
                                                                5),
                                                        time: formatPrayerTime(
                                                            prayerTimes
                                                                .maghrib),
                                                        image: sunsetIcon,
                                                        color: currentPrayer ==
                                                                'Maghrib'
                                                            ? Colors.yellow
                                                            : Colors.white),
                                                    5.widthBox,
                                                    CustomizedPrayerTimeWidget(
                                                        azazName:
                                                            azanName['Isha']!,
                                                        text:
                                                            iqamaTime['Isha']!,
                                                        time: formatPrayerTime(
                                                            prayerTimes.isha),
                                                        image: sunsetIcon,
                                                        color: currentPrayer ==
                                                                'Isha'
                                                            ? Colors.yellow
                                                            : Colors.white),
                                                  ],
                                                ),
                                              ),
                                              5.heightBox,
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                              width: 2,
                                                              color: Colors
                                                                  .white)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12,
                                                                vertical: 10),
                                                        child: Column(
                                                          children: [
                                                            const Text(
                                                              "JUMUAH KHUTBA",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 10,
                                                                  fontFamily:
                                                                      popinsRegulr),
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
                                                                  fontSize: 11,
                                                                  fontFamily:
                                                                      popinsRegulr),
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
                                                              color:
                                                                  Colors.white,
                                                              width: 2)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12,
                                                                vertical: 10),
                                                        child: Column(
                                                          children: [
                                                            const Text(
                                                              "JUMUAH IQAMAH",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 10,
                                                                  fontFamily:
                                                                      popinsRegulr),
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
                                                                  fontSize: 11,
                                                                  fontFamily:
                                                                      popinsRegulr),
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
        )
      ],
    );
  }

  String getCurrentPrayer() {
    final now = DateTime.now();
    final timeNow =
        DateFormat("HH:mm").format(now); // Formatting the current time
    var newTime = DateFormat("HH:mm").parse(timeNow);

    // Check if prayer times data is available
    if (homeController.prayerTime.value.data?.timings != null) {
      final timings = homeController.prayerTime.value.data!.timings;

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
  Map<String, String> getAllIqamaTimes() {
    DateTime now = DateTime.now();
    String currentDateStr = DateFormat('d/M').format(now);
    DateTime currentDate = parseDate(currentDateStr);

    for (var timing in iqamahTiming) {
      DateTime startDate = parseDate(timing.startDate);
      DateTime endDate = parseDate(timing.endDate);

      // Ensure the date range includes the current date
      if (currentDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
          currentDate.isBefore(endDate.add(const Duration(days: 1)))) {
        return {
          'Fajr': timing.fjar,
          'Dhuhr': timing.zuhr,
          'Asr': timing.asr,
          'Maghrib':
              DateFormat("h:mm a").format(now.add(const Duration(minutes: 5))),
          'Isha': timing.isha,
        };
      }
    }

    // Return default values if no timing is found
    return {
      'Fajr': 'Not available',
      'Dhuhr': 'Not available',
      'Asr': 'Not available',
      'Maghrib': 'Not available',
      'Isha': 'Not available',
    };
  }

// Function to find and return Azan names for all prayers based on the date range
  Map<String, String> getAllAzanNamesForCurrentDate() {
    DateTime now = DateTime.now();
    String currentDateStr = DateFormat('d/M').format(now);
    DateTime currentDate = parseDate(currentDateStr);

    for (var timing in iqamahTiming) {
      DateTime startDate = parseDate(timing.startDate);
      DateTime endDate = parseDate(timing.endDate);

      // Ensure the date range includes the current date
      if (currentDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
          currentDate.isBefore(endDate.add(const Duration(days: 1)))) {
        return {
          'Fajr': 'Fajr',
          'Dhuhr': 'Dhuhr',
          'Asr': 'Asr',
          'Maghrib': 'Maghrib',
          'Isha': 'Isha',
        };
      }
    }

    // Return default values if no date range is found
    return {
      'Fajr': 'Fajr',
      'Dhuhr': 'Dhuhr',
      'Asr': 'Asr',
      'Maghrib': 'Maghrib',
      'Isha': 'Isha',
    };
  }

// Function to parse a date string in "d/M" format to DateTime
  DateTime parseDate(String dateStr) {
    return DateFormat('d/M').parse(dateStr);
  }

  Object? getPrayerTimes() {
    if (homeController.currentPrayerTime == 'Fajr') {
      return homeController.prayerTime.value.data?.timings.fajr;
    } else if (homeController.currentPrayerTime == 'Dhuhr') {
      return homeController.prayerTime.value.data?.timings.dhuhr;
    } else if (homeController.currentPrayerTime == 'Asr') {
      return homeController.prayerTime.value.data?.timings.asr;
    } else if (homeController.currentPrayerTime == 'Maghrib') {
      return homeController.prayerTime.value.data?.timings.maghrib;
    } else {
      return homeController.prayerTime.value.data?.timings.isha;
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

String addMinutesToPrayerTime(String prayerTime, int minutesToAdd) {
  try {
    final dateTime = DateFormat("HH:mm").parse(prayerTime);
    DateTime updatedTime = dateTime.add(Duration(minutes: minutesToAdd));
    return DateFormat('h:mm a').format(updatedTime);
  } catch (e) {
    print('Error parsing time: $e');
    return 'Invalid time';
  }
}

class HomeCardRow1 extends StatelessWidget {
  HomeCardRow1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CusTomizedCardWidget(
            title: 'About Us',
            imageIcon: aboutUsIcon,
            onTap: () {
              Get.to(() => AboutUsScreen());
            }),
        CusTomizedCardWidget(
            title: 'Qibla Direction',
            imageIcon: qiblaIcon2,
            onTap: () {
              Get.to(() => QiblahScreen());
            }),
        CusTomizedCardWidget(
            title: 'Ask Imam',
            imageIcon: askImamIcon,
            onTap: () {
              Get.to(() => AskImamScreen());
            })
      ],
    );
  }
}

class HomeCardRow extends StatelessWidget {
  HomeCardRow({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CusTomizedCardWidget(
            title: 'Donate',
            imageIcon: donationIcon,
            onTap: () {
              Get.to(() => ProjectScreen());
            }),
        CusTomizedCardWidget(
            title: 'Contact Us',
            imageIcon: contactUsIcon,
            onTap: () {
              Get.to(() => ContactUsScreen());
            }),
        CusTomizedCardWidget(
            title: 'Gallery',
            imageIcon: galleryIcon,
            onTap: () {
              Get.to(() => GalleyScreen());
            })
      ],
    );
  }
}
