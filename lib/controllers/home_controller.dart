import 'dart:convert';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:http/http.dart' as http;
// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:community_islamic_app/model/prayer_model.dart';
import 'package:intl/intl.dart';

import '../model/jumma_model.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  var prayerTimes = Prayer().obs; // Observable for prayer time

  var jummaTimes = Jumma().obs;
  var isLoading = true.obs;
  late NotchBottomBarController notchBottomBarController;
  // final jummaTime = homeController.jummaTimes.value.data?.jumah;
  // final jummaTimeAdjustMent = homeController.jummaTimes.value.data?.adjustment;
  // ignore: prefer_typing_uninitialized_variables
  var adjutment;
  @override
  void onInit() {
    super.onInit();
    notchBottomBarController =
        NotchBottomBarController(index: selectedIndex.value);
    fetchJummaTimes();
    fetchPrayerTimes(); // Replace with actual city and country
  }

  Future<void> fetchPrayerTimes() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.aladhan.com/v1/timingsByCity?city=Sugar+Land&country=USA&$adjutment='));

      if (response.statusCode == 200) {
        prayerTimes.value = Prayer.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load prayer times');
      }
    } catch (e) {
      print('Error fetching prayer times: $e');
      throw Exception('Failed to load prayer times');
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
        // Manually set the Jumma timings
      } else {
        Get.snackbar('Error', 'Failed to load prayer times');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load prayer times');
    } finally {
      isLoading(false);
    }
  }

  // BOTTOM NAVIGATION BAR INDEX CONTROLLER METHOD
  void changePage(int index) {
    selectedIndex.value = index;
    notchBottomBarController.jumpTo(index);
  }

// Time Formater METHOD
  String formatTime(String time) {
    final dateFormat = DateFormat("HH:mm");
    final timeFormat = DateFormat("h:mm a");
    return timeFormat.format(dateFormat.parse(time));
  }
}
