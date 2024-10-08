import 'dart:io';
import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/constants/image_constants.dart';
import 'package:community_islamic_app/views/profile_screen/update_profile_details.dart';
import 'package:community_islamic_app/widgets/custome_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/globals.dart';
import '../../controllers/profileController.dart';
import 'package:http/http.dart' as http;

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  File? _profileImage;
  String? _selectedAvatar;
  final ProfileController profileController = Get.put(ProfileController());

  // Your avatar list
  List<String> avatar = [
    'assets/images/men.png',
    'assets/images/women.png',
    'assets/images/boy.png',
    'assets/images/girl.png'
  ];

  Future<void> _pickImage(String userId) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
        _selectedAvatar = null; // Clear avatar when image is selected
      });
      // Automatically upload after picking the image
      await _uploadProfileImage(userId);
    }
  }

  void _selectAvatar(String avatarPath, String userId) {
    setState(() {
      _selectedAvatar = avatarPath;
      _profileImage = null; // Clear image when avatar is selected
    });
    // Automatically upload after selecting an avatar
    _uploadProfileImage(userId);
  }

  Future<void> _uploadProfileImage(String userId) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://rosenbergcommunitycenter.org/api/ImageUploadApi'),
    );
    request.headers['Authorization'] = 'Bearer ${globals.accessToken.value}';
    request.fields['id'] = globals.userId.value;

    if (_profileImage != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', _profileImage!.path));
    }

    if (_selectedAvatar != null) {
      request.fields['relation_avatar'] = _selectedAvatar!;
    }

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Image/Avatar uploaded successfully!');
      } else {
        print('Failed to upload image/avatar: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error uploading image/avatar: $e');
    }
  }

  Future<void> _showAvatarSelectionDialog(String userId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Select an Avatar',
            style: TextStyle(fontFamily: popinsRegulr),
          ),
          content: SizedBox(
            // Use SizedBox instead of Expanded
            height: 200, // Set a fixed height
            width: double.maxFinite, // Allow it to take full width
            child: GridView.builder(
              shrinkWrap: true, // Prevents infinite height issues
              itemCount: avatar.length,
              itemBuilder: (context, index) {
                String avatarPath = avatar[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    _selectAvatar(avatarPath, userId);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Image.asset(avatarPath, width: 100, height: 100),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.0,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showImageSourceDialog(String userId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Choose Image Source',
            style: TextStyle(fontFamily: popinsBold),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Gallery',
                style: TextStyle(fontFamily: popinsRegulr),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(userId); // Pass userId to image picker
              },
            ),
            TextButton(
              child: const Text(
                'Avatars',
                style: TextStyle(fontFamily: popinsRegulr),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _showAvatarSelectionDialog(
                    userId); // Pass userId to avatar selection
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, Map<String, dynamic> userData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: UpdateProfileDetails(
              userData: userData), // Pass user data to dialog
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Container(color: Colors.white, child: const CustomDrawer()),
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: profileController.fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No data available."));
          } else {
            final userData = snapshot.data!['user'];

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: _profileImage != null
                                  ? FileImage(_profileImage!)
                                  : (_selectedAvatar != null
                                          ? AssetImage(_selectedAvatar!)
                                          : NetworkImage(
                                              userData['profile_image']))
                                      as ImageProvider,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  iconSize: 20,
                                  color: Colors.white,
                                  onPressed: () async {
                                    _showImageSourceDialog(userData['id']
                                        .toString()); // Pass userId to dialog
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          userData['name'] ?? 'N/A',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userData['profession'] ?? 'N/A',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    color: containerConlor,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'PERSONAL INFORMATION',
                      style: TextStyle(
                          fontFamily: popinsBold, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  PersonnelInfoRow(
                      title: 'First Name',
                      value: userData['first_name'] ?? 'N/A'),
                  const Divider(),
                  PersonnelInfoRow(
                      title: 'Last Name',
                      value: userData['last_name'] ?? 'N/A'),
                  const Divider(),
                  PersonnelInfoRow(
                      title: 'Email Address',
                      value: userData['email'] ?? 'N/A'),
                  const Divider(),
                  PersonnelInfoRow(
                      title: 'Phone No', value: userData['number'] ?? 'N/A'),
                  const Divider(),
                  PersonnelInfoRow(
                      title: 'DOB', value: userData['dob'] ?? 'N/A'),
                  const Divider(),
                  PersonnelInfoRow(
                      title: 'Residential Address',
                      value: userData['residential_address'] ?? 'N/A'),
                  const Divider(),
                  PersonnelInfoRow(
                      title: 'City', value: userData['city'] ?? 'N/A'),
                  const Divider(),
                  PersonnelInfoRow(
                      title: 'State', value: userData['state'] ?? 'N/A'),
                  const Divider(),
                  PersonnelInfoRow(
                      title: 'Profession',
                      value: userData['profession'] ?? 'N/A'),
                  const Divider(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: ElevatedButton(
                      onPressed: () {
                        _showEditDialog(context, userData);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 10),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.elliptical(30, 30),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.elliptical(30, 30),
                            topRight: Radius.circular(5),
                          ),
                        ),
                        shadowColor: const Color.fromARGB(255, 171, 212, 234),
                        elevation: 8,
                      ),
                      child: Text(
                        'Edit',
                        style: TextStyle(
                            color: Colors.white, fontFamily: popinsSemiBold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class PersonnelInfoRow extends StatelessWidget {
  final String title;
  final String value;

  const PersonnelInfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontFamily: popinsSemiBold),
          ),
          Text(
            value,
            style: TextStyle(fontFamily: popinsRegulr),
          ),
        ],
      ),
    );
  }
}
