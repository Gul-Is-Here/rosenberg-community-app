import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/globals.dart';
import 'login_controller.dart';

class ProfileController extends GetxController {
  final _userDataController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get userDataStream => _userDataController.stream;

  final LoginController loginController = Get.put(LoginController());
  var userData = {}.obs;

  // URL for profile update API
  final String profileUpdateApiUrl =
      "https://rosenbergcommunitycenter.org/api/ProfileUpdateApi?token=${globals.accessToken.value}&userid=${globals.userId.value}";

  @override
  void onInit() {
    super.onInit();
    fetchUserData(); // Fetch user data on initialization
  }

  /// Fetch user data from the API
  Future<void> fetchUserData() async {
    final url = Uri.parse('https://rosenbergcommunitycenter.org/api/user');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${globals.accessToken.value}',
        },
      );

      if (response.statusCode == 200) {
        print("Stream triggered, checking for data...");

        final jsonData = json.decode(response.body);
        globals.userId.value = jsonData['user']['id'].toString();
        print("User data fetched: $jsonData"); // Log the fetched data
        _userDataController.add(jsonData); // Emit the data
      } else {
        print("Failed to load user data. Status code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        _userDataController.addError('Failed to load user data');
      }
    } catch (e) {
      print("Error fetching user data: $e");
      _userDataController.addError('Error fetching user data');
    }
  }

  @override
  void onClose() {
    _userDataController
        .close(); // Close the stream when the controller is disposed
    super.onClose();
  }

  /// Update user profile data
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
      "Authorization": "Bearer ${globals.accessToken.value}",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    final body = {
      "userid": globals.userId.value,
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
