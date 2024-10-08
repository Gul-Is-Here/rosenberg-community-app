import 'package:community_islamic_app/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import '../../constants/color.dart';
import '../../controllers/profileController.dart';
import '../../widgets/custome_drawer.dart';

class UpdateProfileDetails extends StatefulWidget {
  final Map<String, dynamic> userData;

  const UpdateProfileDetails({Key? key, required this.userData})
      : super(key: key);

  @override
  _UpdateProfileDetailsState createState() => _UpdateProfileDetailsState();
}

class _UpdateProfileDetailsState extends State<UpdateProfileDetails> {
  final ProfileController profileController = Get.put(ProfileController());

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController dobController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController zipCodeController;
  late TextEditingController professionController;

  // Dropdown fields
  String? _selectedCommunity;
  String? _selectedGender;
  String? _selectedState;

  final List<String> communities = [
    "Walnut Creek",
    "Sunset Crossing",
    "Summer Lakes",
    "Bonbrook Plantation",
    "Stone Creek",
    "Oaks of Rosenberg",
    "Rose Ranch",
    "Lakes of William Ranch",
    "Bryan Crossing",
    "River Mists",
    "Other"
  ];

  final List<String> genders = ["Male", "Female"];
  final List<String> states = ["Texas"];

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with the passed userData
    firstNameController =
        TextEditingController(text: widget.userData['first_name']);
    lastNameController =
        TextEditingController(text: widget.userData['last_name']);
    emailController = TextEditingController(text: widget.userData['email']);
    phoneNumberController =
        TextEditingController(text: widget.userData['number']);
    dobController = TextEditingController(text: widget.userData['dob']);
    addressController =
        TextEditingController(text: widget.userData['residential_address']);
    cityController = TextEditingController(text: widget.userData['city']);
    zipCodeController =
        TextEditingController(text: widget.userData['zip_code']);
    professionController =
        TextEditingController(text: widget.userData['profession']);

    // Initialize dropdown selections
    _selectedCommunity = widget.userData['community'];
    _selectedGender = widget.userData['gender'] ?? 'Male';
    _selectedState = widget.userData['state'] ?? 'Texas';
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    dobController.dispose();
    addressController.dispose();
    cityController.dispose();
    zipCodeController.dispose();
    professionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayLoaderWithAppIcon(
      isLoading: _isLoading,
      overlayBackgroundColor: Colors.black,
      circularProgressColor: primaryColor,
      appIcon: Image.asset(masjidIcon), // Update with your app icon
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                const SizedBox(height: 20),
                BuildTextFormField(
                  label: "First Name",
                  controller: firstNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'First name is required';
                    }
                    return null;
                  },
                ),
                BuildTextFormField(
                  label: "Last Name",
                  controller: lastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Last name is required';
                    }
                    return null;
                  },
                ),
                BuildTextFormField(
                  label: "Email Address",
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
                BuildTextFormField(
                  label: "Phone No",
                  controller: phoneNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    return null;
                  },
                ),
                BuildTextFormField(
                  label: "DOB",
                  controller: dobController,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      dobController.text =
                          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Date of birth is required';
                    }
                    return null;
                  },
                ),
                BuildTextFormField(
                  label: "Residential Address",
                  controller: addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Residential address is required';
                    }
                    return null;
                  },
                ),
                BuildTextFormField(
                  label: "City",
                  controller: cityController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'City is required';
                    }
                    return null;
                  },
                ),
                _buildDropdownField(
                  "Community",
                  _selectedCommunity,
                  communities,
                  (String? newValue) {
                    setState(() {
                      _selectedCommunity = newValue!;
                    });
                  },
                ),
                _buildDropdownField(
                  "Gender",
                  _selectedGender,
                  genders,
                  (String? newValue) {
                    setState(() {
                      _selectedGender = newValue!;
                    });
                  },
                ),
                _buildDropdownField(
                  "State",
                  _selectedState,
                  states,
                  (String? newValue) {
                    setState(() {
                      _selectedState = newValue!;
                    });
                  },
                ),
                BuildTextFormField(
                  label: "Zip Code",
                  controller: zipCodeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Zip code is required';
                    }
                    return null;
                  },
                ),
                BuildTextFormField(
                  label: "Profession",
                  controller: professionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Profession is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });

                      // Perform the API call
                      await profileController.postUserProfileData(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        gender: _selectedGender ?? 'Male',
                        contactNumber: phoneNumberController.text,
                        dob: dobController.text,
                        emailAddress: emailController.text,
                        profession: professionController.text,
                        community: _selectedCommunity ?? '',
                        residentialAddress: addressController.text,
                        state: _selectedState ?? 'Texas',
                        city: cityController.text,
                        zipCode: zipCodeController.text,
                      );

                      setState(() {
                        _isLoading = false;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Profile updated successfully!",
                            style: TextStyle(fontFamily: popinsMedium),
                          ),
                          backgroundColor: primaryColor,
                        ),
                      );
                    }
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
                  ),
                  child: const Text(
                    'UPDATE',
                    style: TextStyle(
                        color: Colors.white, fontFamily: popinsSemiBold),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, String? selectedValue,
      List<String> options, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontFamily: popinsBold)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              value: selectedValue,
              isExpanded: true,
              onChanged: onChanged,
              items: options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom TextFormField widget for cleaner UI
class BuildTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function()? onTap;

  const BuildTextFormField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        style: TextStyle(fontFamily: popinsRegulr),
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontFamily: popinsSemiBold,
          ),
        ),
        validator: validator,
        onTap: onTap,
      ),
    );
  }
}
