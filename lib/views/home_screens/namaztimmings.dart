import 'package:community_islamic_app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/home_controller.dart';
import '../../model/prayer_model.dart';
import '../../model/prayer_times_static_model.dart';

class NamazTimingsScreen extends StatelessWidget {
  const NamazTimingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Text(
          'Namaz Timings',
          style: TextStyle(color: Colors.white, fontFamily: popinsSemiBold),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Obx(() {
        if (homeController.prayerTime.value.data == null) {
          return Center(child: CircularProgressIndicator());
        }

        final timings = homeController.prayerTime.value.data!.timings;
        var iqamatimes = getAllIqamaTimes();
        final currentPrayer = getCurrentPrayer(homeController);

        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildPrayerTile(
                'Fajr', timings.fajr, iqamatimes['Fajr']!, currentPrayer),
            _buildPrayerTile(
                'Dhuhr', timings.dhuhr, iqamatimes['Dhuhr']!, currentPrayer),
            _buildPrayerTile(
                'Asr', timings.asr, iqamatimes['Asr']!, currentPrayer),
            _buildPrayerTile('Maghrib', timings.maghrib, iqamatimes['Maghrib']!,
                currentPrayer),
            _buildPrayerTile(
                'Isha', timings.isha, iqamatimes['Isha']!, currentPrayer),
          ],
        );
      }),
    );
  }

  Widget _buildPrayerTile(
      String title, String prayerTime, String iqamaTime, String currentPrayer) {
    bool isCurrent = title == currentPrayer;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: isCurrent
          ? Colors.teal.shade100
          : Colors.white, // Highlight current prayer
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: popinsSemiBold,
                    fontWeight: FontWeight.bold,
                    color: isCurrent ? Colors.teal : primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Prayer Time: ${formatPrayerTime(prayerTime)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontFamily: popinsRegulr,
                  ),
                ),
                Text(
                  'Iqama Time: $iqamaTime',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontFamily: popinsRegulr,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.access_time,
              color: Colors.teal,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  String formatPrayerTime(String prayerTime) {
    return DateFormat('h:mm a').format(DateFormat('HH:mm').parse(prayerTime));
  }

  Map<String, String> getAllIqamaTimes() {
    DateTime now = DateTime.now();
    String currentDateStr = DateFormat('d/M').format(now);
    DateTime currentDate = parseDate(currentDateStr);

    for (var timing in iqamahTiming) {
      DateTime startDate = parseDate(timing.startDate);
      DateTime endDate = parseDate(timing.endDate);

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

    return {
      'Fajr': 'Not available',
      'Dhuhr': 'Not available',
      'Asr': 'Not available',
      'Maghrib': 'Not available',
      'Isha': 'Not available',
    };
  }

  DateTime parseDate(String dateStr) {
    return DateFormat('d/M').parse(dateStr);
  }

  String getCurrentPrayer(HomeController homeController) {
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
}
