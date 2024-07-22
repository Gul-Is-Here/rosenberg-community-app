import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  // --------------------> METHOD FOR GET USER LOCATION  <------------------------------

  RxString location = 'Waiting for location...'.obs;
  RxBool isLoading = false.obs;
  late final loc;
  late final currentPosition;
  double? latitude, logitude;
  

  void getLocation() async {
    try {
      isLoading.value = true;

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showSnackBar('Please enable your Location');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          _showSnackBar('Please enable your Location.');
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        String city = placemarks[0].locality ?? '';
        // String country = placemarks[0].country ?? '';

        location.value = city;
      } else {
        location.value = 'Location not found.';
      }
    } catch (e) {
      _showSnackBar('Error: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void _showSnackBar(String message) {
    Get.snackbar(
      'Location',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
  // Pervent to go Qible Screen untile location is not on

  // ------------------> GET PRAYER TIMES ACCORDING TO USER LOCATION  <------------------------
  getLoc() async {
      bool serviceEnable;
      PermissionStatus permissionGranted;
      serviceEnable = await loc.serviceEnabled();
      if (!serviceEnable) {
        serviceEnable = await loc.requestService();
        if (!serviceEnable) {
          return;
        }
      }
      permissionGranted = await loc.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await loc.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      currentPosition = await loc.getLocation();
      latitude = currentPosition!.latitude;
      logitude = currentPosition!.longitude;
    }

}