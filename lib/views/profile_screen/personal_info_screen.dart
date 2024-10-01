import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/constants/image_constants.dart';
import 'package:community_islamic_app/views/profile_screen/update_profile_details.dart';
// Import ProfileController
import 'package:community_islamic_app/widgets/custome_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profileController.dart';
import '../../model/userModel.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      endDrawer: Container(color: Colors.white, child: const CustomDrawer()),
      appBar: AppBar(
          backgroundColor: primaryColor,
          leading: IconButton(
              color: Colors.white,
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios))),
      body: FutureBuilder<Map<String, dynamic>>(
        future: profileController
            .fetchUserData(), // Adjust this to return Map<String, dynamic>
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No data available."));
          } else {
            final userData = snapshot
                .data!['user']; // Access the 'user' field from the response

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: Image.network((userData['profile_image'])),
                          // Replace with your image path or use userData['profile_image']
                        ),
                        const SizedBox(height: 10),
                        Text(
                          userData['name'] ?? 'N/A', // User's name
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userData['profession'] ?? 'N/A', // User's profession
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
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
                      title: 'City', value: userData['id'].toString() ?? 'N/A'),
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
                        Get.to(() => const UpdateProfileDetails());
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
                              topRight: Radius.circular(5)),
                        ),
                        shadowColor: Colors.white,
                        elevation: 10,
                      ),
                      child: const Text(
                        'Edit',
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
}

class PersonnelInfoRow extends StatelessWidget {
  final String title;
  final String value;

  const PersonnelInfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(textAlign: TextAlign.start, value)),
        ],
      ),
    );
  }
}

// class _PasswordTextField extends StatelessWidget {
//   final String label;

//   const _PasswordTextField({required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 60,
//       child: Card(
//         elevation: 8,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(5),
//         ),
//         color: Colors.white,
//         shadowColor: Colors.grey.shade300,
//         child: TextFormField(
//           obscureText: true,
//           decoration: InputDecoration(
//             labelText: label,
//             labelStyle: TextStyle(
//               color: Colors.grey.shade700,
//               fontWeight: FontWeight.w500,
//             ),
//             border: InputBorder.none,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//           ),
//         ),
//       ),
//     );
//   }
// }
