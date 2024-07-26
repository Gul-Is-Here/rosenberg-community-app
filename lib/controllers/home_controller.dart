import 'dart:convert';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:http/http.dart' as http;
// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:community_islamic_app/model/prayer_model.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  var prayerTimes = Prayer().obs; // Observable for prayer times
  late NotchBottomBarController notchBottomBarController;

  @override
  void onInit() {
    super.onInit();
    notchBottomBarController =
        NotchBottomBarController(index: selectedIndex.value);
    fetchPrayerTimes(); // Replace with actual city and country
  }

  Future<void> fetchPrayerTimes() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.aladhan.com/v1/timingsByCity?city=Sugar+Land&country=USA&adjustment='));

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
