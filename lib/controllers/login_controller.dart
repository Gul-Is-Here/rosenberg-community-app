import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../views/auth_screens/login_screen.dart';
import '../views/home_screens/home.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var userId = ''.obs;
  var authToken = ''.obs;
  var profileImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadAuthToken();
  }

  Future<void> loginUser() async {
    // Validate email and password
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar("Error", "Please enter both email and password.");
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('https://rosenbergcommunitycenter.org/api/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': email.value,
          'password': password.value,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        final userDetails = jsonResponse["user_details"];
        if (userDetails != null) {
          userId.value = userDetails["id"]?.toString() ?? '';
          authToken.value = jsonResponse["access_token"] ?? '';

          // Store login status and access token in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('accessToken', authToken.value);

          Get.snackbar("Success", "Login successful.");
          Get.offAll(() => const Home()); // Navigate to Home screen
        } else {
          Get.snackbar("Error", "Invalid login credentials.");
        }
      } else {
        Get.snackbar(
            "Error", "Failed to login. Please check your email and password.");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logoutUser() async {
    // Clear login status and access token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('accessToken');
    userId.value = '';
    authToken.value = '';

    Get.snackbar("Success", "Logged out successfully.");
    Get.offAll(() => LoginScreen()); // Navigate back to login screen
  }

  Future<bool> isLoggedIn() async {
    // Check login status from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> _loadAuthToken() async {
    // Retrieve the access token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('accessToken');
    if (storedToken != null) {
      authToken.value = storedToken;
    }
  }
}
