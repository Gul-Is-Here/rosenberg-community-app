import 'package:flutter/material.dart';
import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/constants/image_constants.dart';
import 'package:get/get.dart';
import '../../controllers/updatePasswordController.dart';

class UpdatePasswordScreen extends StatelessWidget {
  final UpdatePasswordController controller =
      Get.put(UpdatePasswordController());

  UpdatePasswordScreen({super.key});

  final TextEditingController currentPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey.shade300,
                  child: const CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage(masjidIcon),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon:
                          const Icon(Icons.edit, color: Colors.black, size: 16),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Atta Ul Mutahir',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Profession',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(color: containerConlor),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      'UPDATE PASSWORD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _PasswordTextField(
              label: 'Current Password',
              controller: currentPassController,
            ),
            const SizedBox(height: 20),
            _PasswordTextField(
              label: 'New Password',
              controller: newPassController,
            ),
            const SizedBox(height: 20),
            _PasswordTextField(
              label: 'Confirm Password',
              controller: confirmPassController,
            ),
            const SizedBox(height: 40),
            Obx(() {
              return ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        String oldPass = currentPassController.text;
                        String newPass = newPassController.text;
                        String confirmPass = confirmPassController.text;
                        if (newPass != confirmPass) {
                          Get.snackbar('Error', 'Passwords do not match');
                        } else {
                          controller.updatePassword(
                              oldPass, newPass, confirmPass);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(30, 30),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.elliptical(30, 30),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  shadowColor: Colors.tealAccent.shade200,
                  elevation: 10,
                ),
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'UPDATE PASSWORD',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const _PasswordTextField({
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: Colors.white,
        shadowColor: Colors.grey.shade300,
        child: TextFormField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ),
    );
  }
}


// import 'package:community_islamic_app/controllers/profileController.dart';
// import 'package:flutter/material.dart';
// import 'package:community_islamic_app/constants/color.dart';
// import 'package:community_islamic_app/constants/image_constants.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
// import '../../controllers/updatePasswordController.dart';

// class UpdatePasswordScreen extends StatelessWidget {
//   final ProfileController profileController = Get.find<ProfileController>();
//   final UpdatePasswordController controller =
//       Get.put(UpdatePasswordController());

//   UpdatePasswordScreen({super.key});

//   final TextEditingController currentPassController = TextEditingController();
//   final TextEditingController newPassController = TextEditingController();
//   final TextEditingController confirmPassController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ),
//       body: FutureBuilder(
//         future: profileController.fetchUserData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return SizedBox(
//               height: screenHeight * 0.8, // Height of the screen
//               child: Center(
//                 child: SpinKitFadingCircle(
//                   color: primaryColor,
//                   size: 50.0, // Loading indicator for profile data
//                 ),
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return SizedBox(
//               height: screenHeight * 0.8,
//               child: Center(
//                 child: Text(
//                   'Error: please login again',
//                   style: const TextStyle(fontFamily: popinsRegulr),
//                 ),
//               ),
//             );
//           } else if (snapshot.hasData) {
//             final userData = snapshot.data!['user'];

//             return _buildPasswordUpdateForm(
//                 screenHeight, userData); // Custom method for the form
//           } else {
//             return SizedBox(
//               height: screenHeight * 0.8,
//               child: const Center(
//                 child: Text(
//                   'Please login again',
//                   style: TextStyle(fontFamily: popinsMedium),
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildPasswordUpdateForm(double screenHeight, dynamic userData) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(height: 10),
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               CircleAvatar(
//                 radius: 60,
//                 backgroundColor: Colors.white,
//                 child: CircleAvatar(
//                   radius: 60,
//                   backgroundImage: userData['profile_image'] != null
//                       ? NetworkImage(userData['profile_image'])
//                       : const AssetImage('assets/images/male.png')
//                           as ImageProvider,
//                 ),
//               ),
//               // Positioned(
//               //   bottom: 4,
//               //   right: 4,
//               //   child: CircleAvatar(
//               //     radius: 16,
//               //     backgroundColor: Colors.white,
//               //   ),
//               // ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             '${userData['first_name']} ${userData['last_name']}',
//             style: const TextStyle(
//               fontFamily: popinsSemiBold,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             userData['profession'],
//             style: TextStyle(
//               fontFamily: popinsRegulr,
//               color: Colors.grey.shade700,
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Divider(),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Container(
//               height: 45,
//               width: double.infinity,
//               decoration: BoxDecoration(color: containerConlor),
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8),
//                 child: Center(
//                   child: Text(
//                     'UPDATE PASSWORD',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           _PasswordTextField(
//             label: 'Current Password',
//             controller: currentPassController,
//           ),
//           const SizedBox(height: 20),
//           _PasswordTextField(
//             label: 'New Password',
//             controller: newPassController,
//           ),
//           const SizedBox(height: 20),
//           _PasswordTextField(
//             label: 'Confirm Password',
//             controller: confirmPassController,
//           ),
//           const SizedBox(height: 40),
//           Obx(() {
//             return ElevatedButton(
//               onPressed: controller.isLoading.value
//                   ? null // Disable button if loading is active
//                   : () {
//                       // Fetch the password values
//                       String oldPass = currentPassController.text;
//                       String newPass = newPassController.text;
//                       String confirmPass = confirmPassController.text;

//                       // Validate password match
//                       if (newPass != confirmPass) {
//                         Get.snackbar('Error', 'Passwords do not match');
//                       } else {
//                         // Show loading indicator for button
//                         controller.isLoading.value = true;

//                         // Call password update method
//                         controller
//                             .updatePassword(oldPass, newPass, confirmPass)
//                             .then((_) {
//                           // Stop loading spinner after successful password update
//                           controller.isLoading.value = false;
//                           Get.snackbar(
//                               'Success', 'Password updated successfully');
//                         }).catchError((error) {
//                           // Stop loading spinner after failure
//                           controller.isLoading.value = false;
//                           Get.snackbar('Error', 'Failed to update password');
//                         });
//                       }
//                     },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: primaryColor,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
//                 shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.elliptical(30, 30),
//                     bottomLeft: Radius.circular(5),
//                     bottomRight: Radius.elliptical(30, 30),
//                     topRight: Radius.circular(5),
//                   ),
//                 ),
//                 shadowColor: Colors.tealAccent.shade200,
//                 elevation: 10,
//               ),
//               child: controller.isLoading.value
//                   ? const SpinKitFadingCircle(
//                       color: Colors.white,
//                       size: 24.0, // Show button loading spinner
//                     )
//                   : const Text(
//                       'UPDATE PASSWORD',
//                       style: TextStyle(
//                           fontFamily: popinsSemiBold, color: Colors.white),
//                     ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }

// class _PasswordTextField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;

//   const _PasswordTextField({
//     required this.label,
//     required this.controller,
//   });

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
//           controller: controller,
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
