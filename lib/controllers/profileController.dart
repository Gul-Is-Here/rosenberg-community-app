import 'dart:convert';
import 'dart:io';
import 'package:community_islamic_app/views/quran_screen.dart/quran_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/globals.dart';
import 'login_controller.dart';
import '../model/userModel.dart';
import 'package:http_parser/http_parser.dart'; // Add this import for MediaType

class ProfileController extends GetxController {
  final LoginController loginController = Get.put(LoginController());

  // URL for profile update API
  final String profileUpdateApiUrl =
      "https://rosenbergcommunitycenter.org/api/ProfileUpdateApi?token=${globals.accessToken.value}&userid=${globals.userId.value}";

  /// Fetch user data from the API
  Future<Map<String, dynamic>> fetchUserData() async {
    final response = await http.get(Uri.parse(
        'https://rosenbergcommunitycenter.org/api/user?token=${globals.accessToken.value}'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      print("Response Data: $jsonData");
      globals.userId.value = jsonData['user']['id'].toString(); // Store user ID
      return jsonData;
    } else {
      print("Failed to load user data. Status code: ${response.statusCode}");
      print(
          "Response Body: ${response.body}"); // Print response body for debugging
      throw Exception('error');
    }
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

  /// Upload image to the server
  Future<void> uploadImage(File image, String relationAvatar) async {
    final String uploadUrl =
        'https://rosenbergcommunitycenter.org/api/ImageUploadApi';

    var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

    request.headers.addAll({
      'Authorization': 'Bearer ${globals.accessToken.value}',
      'Accept': 'application/json',
    });

    // Add user ID to the request
    request.fields['id'] = globals.userId.value;

    try {
      // Ensure the file exists
      if (!await image.exists()) {
        print('File does not exist: ${image.path}');
        return; // Early return if the file doesn't exist
      }

      // Add image file
      var mimeType = lookupMimeType(image.path);
      var fileStream = http.ByteStream(image.openRead().cast());
      var length = await image.length();
      var multipartFile = http.MultipartFile(
        'image',
        fileStream,
        length,
        filename: basename(image.path),
        contentType: MediaType.parse(
            mimeType ?? 'image/jpeg'), // Default to JPEG if mimeType is null
      );

      request.files.add(multipartFile);

      // Add relation_avatar field
      request.fields['relation_avatar'] = relationAvatar;

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        print('Image uploaded: ${responseData.body}');
      } else {
        print('Upload failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  /// Pick an image from the gallery and upload it
  Future<void> pickImageAndUpload(String relationAvatar) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await uploadImage(imageFile, relationAvatar);
    } else {
      print('No image selected');
    }
  }

  // Update Password  Method
  
}
