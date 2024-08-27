import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../views/home_screens/home.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var userId = ''.obs;
  var userFname = ''.obs;
  var userLname = ''.obs;
  var userEmail = ''.obs;
  var authToken = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData(); // Load user data from SharedPreferences
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userFname.value = prefs.getString('userFName') ?? '';
    userLname.value = prefs.getString('userLName') ?? '';
    userEmail.value = prefs.getString('userEmail') ?? '';
    userId.value = prefs.getString('userId') ?? '';
    authToken.value = prefs.getString('authToken') ?? '';
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userFName', userFname.value);
    await prefs.setString('userLName', userLname.value);
    await prefs.setString('userEmail', userEmail.value);
    await prefs.setString('userId', userId.value);
    await prefs.setString('authToken', authToken.value);
  }

  Future<void> loginUser() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar("Error", "Email and Password are required.");
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

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Ensure user_details is not null before accessing its fields
        final userDetails = jsonResponse["user_details"];
        if (userDetails != null) {
          userFname.value = userDetails["first_name"] ?? '';
          userLname.value = userDetails["last_name"] ?? '';
          userEmail.value = userDetails["email"] ?? '';
          userId.value = userDetails["id"]?.toString() ?? '';
        } else {
          // Handle the case where user_details is null
          userFname.value = '';
          userLname.value = '';
          userEmail.value = '';
          userId.value = '';
        }

        authToken.value = jsonResponse["access_token"] ?? '';

        // Store user data in SharedPreferences
        await _saveUserData();

        print('Stored FName: ${userFname.value}');
        print('Stored LName: ${userLname.value}');
        print('Stored Email: ${userEmail.value}');
        print('Stored UserId: ${userId.value}');
        print('Stored AuthToken: ${authToken.value}');

        Get.snackbar("Success", "Login successful.");
        Get.offAll(() => const Home()); // Redirect to the Home screen
      } else {
        Get.snackbar("Error",
            "Failed to login. Server responded with status code ${response.statusCode}");
      }
    } catch (e) {
      print('Error: $e'); // Print the error details to the console
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
