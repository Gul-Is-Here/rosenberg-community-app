import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/color.dart';
import '../../constants/image_constants.dart';
import '../../controllers/profileController.dart';
import '../../widgets/custome_drawer.dart';

class UpdateProfileDetails extends StatefulWidget {
  const UpdateProfileDetails({super.key});

  @override
  _UpdateProfileDetailsState createState() => _UpdateProfileDetailsState();
}

class _UpdateProfileDetailsState extends State<UpdateProfileDetails> {
  final ProfileController profileController = Get.put(ProfileController());

  // TextEditingControllers for user input
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  // File to store the picked image
  File? _profileImage;

  // Method to pick image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
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

            // Set initial values to the TextEditingControllers
            firstNameController.text = userData['first_name'] ?? '';
            lastNameController.text = userData['last_name'] ?? '';
            emailController.text = userData['email'] ?? '';
            phoneNumberController.text = userData['number'] ?? '';
            dobController.text = userData['dob'] ?? '';
            addressController.text = userData['residential_address'] ?? '';
            cityController.text = userData['city'] ?? '';
            stateController.text = userData['state'] ?? '';
            professionController.text = userData['profession'] ?? '';
            zipCodeController.text = userData['zip_code'] ?? '';

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : AssetImage('') as ImageProvider,
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
                                icon: Icon(Icons.edit),
                                iconSize: 20,
                                color: Colors.white,
                                onPressed: () {
                                  _showImageSourceDialog();
                                },
                              ),
                            )),
                      ],
                    ),
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
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    color: containerConlor,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'PERSONAL INFORMATION',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  _buildEditableField("First Name", firstNameController),
                  _buildEditableField("Last Name", lastNameController),
                  _buildEditableField("Email Address", emailController),
                  _buildEditableField("Phone No", phoneNumberController),
                  _buildEditableField("DOB", dobController),
                  _buildEditableField("Residential Address", addressController),
                  _buildEditableField("City", cityController),
                  _buildEditableField("State", stateController),
                  _buildEditableField("Profession", professionController),
                  _buildEditableField("Zip Code", zipCodeController),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Collect updated data and call the update method
                        profileController.postUserProfileData(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          gender: userData['gender'] ??
                              'N/A', // Assuming gender is fixed
                          contactNumber: phoneNumberController.text,
                          dob: dobController.text,
                          emailAddress: emailController.text,
                          profession: professionController.text,
                          community: userData['community'] ??
                              '', // Assuming community is fixed
                          residentialAddress: addressController.text,
                          state: stateController.text,
                          city: cityController.text,
                          zipCode: zipCodeController.text,
                        );
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
                        shadowColor: Colors.white,
                        elevation: 10,
                      ),
                      child: const Text(
                        'UPDATE',
                        style: TextStyle(fontSize: 16, color: Colors.white),
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

  // Helper method to build editable text fields
  Widget _buildEditableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Show a dialog to pick the image source
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }
}
