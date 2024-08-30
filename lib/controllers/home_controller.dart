import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../model/prayer_model.dart';
import '../model/jumma_model.dart';
import '../model/prayer_times_static_model.dart';

import '../services/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  var prayerTimes = Prayer().obs;
  var timePrayer = ''.obs;
  var jummaTimes = Jumma().obs;
  var isLoading = true.obs;
  String? currentPrayerTime;
  // ignore: prefer_typing_uninitialized_variables
  var currentIqamaTime;
  late NotchBottomBarController notchBottomBarController;

  // ignore: prefer_typing_uninitialized_variables
  var adjustment;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    notchBottomBarController =
        NotchBottomBarController(index: selectedIndex.value);
    fetchJummaTimes();
    fetchPrayerTimes();
    // scheduleAzanPlayback();
    tz.initializeTimeZones();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> fetchPrayerTimes() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.aladhan.com/v1/timingsByCity?city=Sugar+Land&country=USA&adjustment=$adjustment'));

      if (response.statusCode == 200) {
        prayerTimes.value = Prayer.fromJson(json.decode(response.body));
      } else {
        throw HttpException(
            'Failed to load prayer times with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching prayer times: $e');
      Get.snackbar('Error',
          'Failed to load prayer times. Please check your internet connection.');
    }
  }

  Future<void> fetchJummaTimes() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(
          'https://rosenbergcommunitycenter.org/api/prayerconfig?access=7b150e45-e0c1-43bc-9290-3c0bf6473a51332'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        jummaTimes.value = Jumma.fromJson(data);
      } else {
        Get.snackbar('Error', 'Failed to load prayer times');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load prayer times');
    } finally {
      isLoading(false);
    }
  }

  // void schedulePrayerNotifications() {
  //   final timings = prayerTimes.value.data?.timings;
  //   if (timings != null) {
  //     _notificationServices.scheduleNotification(
  //         'Fajr',
  //         'It\'s time for Fajr prayer ${parseTime(timings.fajr)}',
  //         parseTime(timings.fajr));
  //     _notificationServices.scheduleNotification(
  //         'Dhuhr',
  //         'It\'s time for Dhuhr prayer ${parseTime(timings.dhuhr)}',
  //         parseTime(timings.dhuhr));
  //     _notificationServices.scheduleNotification(
  //         'Asr',
  //         'It\'s time for Asr prayer ${parseTime(timings.asr)}',
  //         parseTime(timings.asr));
  //     _notificationServices.scheduleNotification(
  //         'Maghrib',
  //         'It\'s time for Maghrib prayer ${parseTime(timings.maghrib)}',
  //         parseTime(timings.maghrib));
  //     _notificationServices.scheduleNotification(
  //         'Isha',
  //         'It\'s time for Isha prayer ${parseTime(timings.isha)}',
  //         parseTime(timings.isha));
  //   }
  // }
  //  void sendPrayerNotifications() {
  //   final timings = prayerTimes.value.data?.timings;
  //   if (timings != null) {
  //     _notificationServices.sendNotification(
  //         'Fajr', 'It\'s time for Fajr prayer',);
  //     _notificationServices.scheduleNotification(
  //         'Dhuhr', 'It\'s time for Dhuhr prayer', parseTime(timings.dhuhr));
  //     _notificationServices.scheduleNotification(
  //         'Asr', 'It\'s time for Asr prayer', parseTime(timings.asr));
  //     _notificationServices.scheduleNotification('Maghrib',
  //         'It\'s time for Maghrib prayer', parseTime(timings.maghrib));
  //     _notificationServices.scheduleNotification(
  //         'Isha', 'It\'s time for Isha prayer', parseTime(timings.isha));
  //   }
  // }

//   void scheduleAzanPlayback() {
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       var now = DateTime.now();
//       final timings = prayerTimes.value.data?.timings;
// // Check for testing condition: play Azan every minute
//       // if (now.second == 0) {
//       //   _notificationServices.playAzan();
//       //   _notificationServices
//       //       .scheduleBackgroundTask(DateTime.now().add(Duration(seconds: 10)));
//       // }
//       if (timings != null) {
//         if (isTimeForPrayer(now, parseTime(timings.fajr))) {
//           _notificationServices.playAzan();
//           _notificationServices.scheduleBackgroundTask(parseTime(timings.fajr));
//         } else if (isTimeForPrayer(now, parseTime(timings.dhuhr))) {
//           _notificationServices.playAzan();
//           _notificationServices
//               .scheduleBackgroundTask(parseTime(timings.dhuhr));
//         } else if (isTimeForPrayer(now, parseTime(timings.asr))) {
//           _notificationServices.playAzan();
//           _notificationServices.scheduleBackgroundTask(parseTime(timings.asr));
//         } else if (isTimeForPrayer(now, parseTime(timings.maghrib))) {
//           _notificationServices.playAzan();
//           _notificationServices
//               .scheduleBackgroundTask(parseTime(timings.maghrib));
//         } else if (isTimeForPrayer(now, parseTime(timings.isha))) {
//           _notificationServices.playAzan();
//           _notificationServices.scheduleBackgroundTask(parseTime(timings.isha));
//         }
//       }
//     });
//   }

  bool isTimeForPrayer(DateTime now, DateTime prayerTime) {
    return now.hour == prayerTime.hour &&
        now.minute == prayerTime.minute &&
        now.second == 0;
  }

  void changePage(int index) {
    selectedIndex.value = index;
    notchBottomBarController.jumpTo(index);
  }

  String formatTime(String time) {
    final dateFormat = DateFormat("HH:mm");
    final timeFormat = DateFormat("h:mm a");
    return timeFormat.format(dateFormat.parse(time));
  }

  DateTime parseTime(String time) {
    return DateFormat("HH:mm").parse(time).toLocal();
  }

  // void stopAzan() {
  //   _notificationServices.stopAzan();
  // }

  String getCurrentPrayer() {
    final now = DateTime.now();
    final timeNow = DateFormat("HH:mm").format(now);
    var newTime = DateFormat("HH:mm").parse(timeNow);
    print('New Time $newTime');

    if (prayerTimes.value.data?.timings != null) {
      final timings = prayerTimes.value.data!.timings;

      final fajrTime = DateFormat("HH:mm").parse(timings.fajr);
      final dhuhrTime = DateFormat("HH:mm").parse(timings.dhuhr);
      final asrTime = DateFormat("HH:mm").parse(timings.asr);
      final maghribTime = DateFormat("HH:mm").parse(timings.maghrib);
      final ishaTime = DateFormat("HH:mm").parse(timings.isha);

      if (newTime.isBefore(fajrTime)) {
        return newTime.isAfter(ishaTime) ? 'Isha' : 'Fajr';
      } else if (newTime.isBefore(dhuhrTime)) {
        return 'Dhuhr';
      } else if (newTime.isBefore(asrTime)) {
        return 'Asr';
      } else if (newTime.isBefore(maghribTime)) {
        return 'Maghrib';
      } else if (newTime.isBefore(ishaTime)) {
        return 'Isha';
      } else {
        return 'Fajr';
      }
    }
    return 'Isha';
  }

  // Function to find the current Iqama timings based on the current prayer time
  String getCurrentIqamaTime() {
    DateTime now = DateTime.now();
    String currentDateStr = DateFormat('d/M').format(now);
    DateTime currentDate = parseDate(currentDateStr);

    for (var timing in iqamahTiming) {
      DateTime startDate = parseDate(timing.startDate);
      DateTime endDate = parseDate(timing.endDate);

      if (currentDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
          currentDate.isBefore(endDate.add(const Duration(days: 1)))) {
        String currentPrayer = getCurrentPrayer();

        switch (currentPrayer) {
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

  // Function to get prayer times
  Object? getPrayerTimes() {
    String currentPrayer = getCurrentPrayer();
    if (currentPrayer == 'Fajr') {
      return prayerTimes.value.data?.timings.fajr;
    } else if (currentPrayer == 'Dhuhr') {
      return prayerTimes.value.data?.timings.dhuhr;
    } else if (currentPrayer == 'Asr') {
      return prayerTimes.value.data?.timings.asr;
    } else if (currentPrayer == 'Maghrib') {
      return prayerTimes.value.data?.timings.maghrib;
    } else {
      return prayerTimes.value.data?.timings.isha;
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
