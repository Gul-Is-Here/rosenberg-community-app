import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../views/home_screens/home.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

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

        // Debug print statements
        print('JSON Response: $jsonResponse');

        // Assuming that a successful login returns some user data

        Get.snackbar("Success", "Login successful.");
        Get.offAll(() => Home()); // Redirect to the Home screen
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
