import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../constants/image_constants.dart';

class QiblahController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var locationCountry = "".obs;
  var locationCity = "".obs;
  late Animation<double> animation;
  late AnimationController animationController;
  double begin = 0.0;

  // Reactive variable to track the selected image
  Rx<String> selectedImage = (imageOptions[0]).obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween(begin: 0.0, end: 0.0).animate(animationController);
    _getLocation();
  }

  Future<void> _getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Show a message to the user if permission is denied
      Get.snackbar('Location Permission', 'Please grant location permission.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      locationCountry.value = placemarks[0].country ?? "";
      locationCity.value = placemarks[0].locality ?? "";
    }
  }
}
