import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/constants/image_constants.dart';
import 'package:community_islamic_app/views/profile_screen/update_info_screen.dart';
import 'package:community_islamic_app/widgets/custome_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      endDrawer: const CustomDrawer(),
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Image and Name
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage(masjidIcon), // Replace with your image path
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Atta Ul Mutahir',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Software Engineer', // Replace with user's profession
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Personnel Information Section
            Container(
              color: containerConlor,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'PERSONNEL INFORMATION',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const PersonnelInfoRow(title: 'First Name', value: 'Atta Ul'),
            Divider(),
            const PersonnelInfoRow(title: 'Last Name', value: 'Mutahir'),
            Divider(),
            const PersonnelInfoRow(
                title: 'Email Address', value: 'clouddatadev2@gmail.com'),
            Divider(),
            const PersonnelInfoRow(title: 'Phone No', value: '033-326-51859'),
            Divider(),
            const PersonnelInfoRow(title: 'DOB', value: 'January 16, 2002'),
            Divider(),
            const PersonnelInfoRow(
                title: 'Residential Address', value: 'Cloud Data PVT LTD'),
            Divider(),
            const PersonnelInfoRow(title: 'City', value: 'Richmond'),
            Divider(),
            const PersonnelInfoRow(title: 'State', value: 'Texas'), Divider(),
            const PersonnelInfoRow(
                title: 'Profession', value: 'Software Engineer'),
            Divider(),
            const SizedBox(height: 20),
            // Edit Info Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          insetPadding: EdgeInsets.zero,
                          contentPadding: EdgeInsets.zero,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          content: Container(
                              width: MediaQuery.of(context).size.width *
                                  0.9, // Adjust the width as needed
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Edit Personnel Info Header
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'EDIT PERSONNEL INFO',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        // First Name
                                        _PasswordTextField(label: 'First Name'),
                                        SizedBox(height: 10),
                                        // Last Name
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Last Name',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        // Contact No
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Contact No',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        // DOB
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'DOB',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        // Email Address
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Email Address',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        // Profession
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Profession',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        // Community Dropdown
                                        DropdownButtonFormField<String>(
                                          value: 'Walnut Creek',
                                          items: [
                                            'Walnut Creek',
                                            'Community 2',
                                            'Community 3'
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {},
                                          decoration: InputDecoration(
                                            labelText: 'Community',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        // Residential Address
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Residential Address',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        // State
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'State',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        // Zip Code
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Zip Code',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        // Update Button
                                        ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // Perform update action
                                            }
                                          },
                                          child: Text(
                                            'UPDATE',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 80, vertical: 10),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.elliptical(30, 30),
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  bottomRight:
                                                      Radius.elliptical(30, 30),
                                                  topRight: Radius.circular(5)),
                                            ),
                                            shadowColor: Colors.white,
                                            elevation: 10,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )));
                    },
                  );
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
                        topRight: Radius.circular(5)),
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

class _PasswordTextField extends StatelessWidget {
  final String label;

  const _PasswordTextField({required this.label});

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
