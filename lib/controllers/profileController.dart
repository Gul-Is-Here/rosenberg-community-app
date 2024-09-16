import 'dart:convert';
import 'package:community_islamic_app/views/quran_screen.dart/quran_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/globals.dart';
import 'login_controller.dart';
import '../model/userModel.dart';

class ProfileController extends GetxController {
  final loginController = Get.put(LoginController());
  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchUserData();
  // }

  final String apiUrl = "";
  final String profileUpdateApiUrl =
      "https://rosenbergcommunitycenter.org/api/ProfileUpdateApi?token=${loginConrtroller.authToken.value}&userid=${globals.userId.value}";
  Future<Map<String, dynamic>> fetchUserData() async {
    final response = await http.get(Uri.parse(
        'https://rosenbergcommunitycenter.org/api/user?token=${loginConrtroller.authToken.value}'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      print("Response Data: $jsonData");
      globals.userId.value = jsonData['user']['id']
          .toString(); // Print response data for debugging
      return jsonData;
    } else {
      print("Failed to load user data. Status code: ${response.statusCode}");
      print(
          "Response Body: ${response.body}"); // Print response body for debugging
      throw Exception('error');
    }
  }

  Future<void> postUserProfileData({
    required String firstName,
    required String lastName,
    required String gender,
    required String contactNumber,
    required String dob,
    required String emailAddress,
    required String profession,
    required String community,
    required String residentialAddress,
    required String state,
    required String city,
    required String zipCode,
  }) async {
    final headers = {
      "Authorization": "Bearer ${loginController.authToken.value}",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    final body = {
      "userid": globals.userId.value, // Pass the user ID in the body
      "first_name": firstName,
      "last_name": lastName,
      "gender": gender,
      "contact_number": contactNumber,
      "dob": dob,
      "email_address": emailAddress,
      "profession": profession,
      "community": community,
      "residential_address": residentialAddress,
      "state": state,
      "city": city,
      "zip_code": zipCode,
    };

    try {
      final response = await http.post(
        Uri.parse(profileUpdateApiUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print("Profile updated successfully.");
      } else {
        print("Failed to update profile. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred while updating profile: $e");
    }
  }
}
