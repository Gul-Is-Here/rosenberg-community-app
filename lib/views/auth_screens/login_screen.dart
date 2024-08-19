import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/constants/image_constants.dart';
import 'package:community_islamic_app/views/auth_screens/registration_screen.dart';
import 'package:community_islamic_app/views/home_screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:community_islamic_app/controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final LoginController loginController = Get.put(LoginController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: screenHeight * .35,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(splash), fit: BoxFit.cover)),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Image.asset(
                        splash3,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 250, left: 0, right: 0, bottom: 0),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(splash4), fit: BoxFit.cover)),
                      height: screenHeight * .65,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            50.heightBox,
                            const Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            30.heightBox,
                            TextFormField(
                              onChanged: (value) =>
                                  loginController.email.value = value,
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: primaryColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(255, 220, 217, 217),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(255, 220, 217, 217),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 220, 217, 217),
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true),
                            ),
                            20.heightBox,
                            TextFormField(
                              onChanged: (value) =>
                                  loginController.password.value = value,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: primaryColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(255, 220, 217, 217),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(255, 220, 217, 217),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 220, 217, 217),
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true),
                            ),
                            20.heightBox,
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forget Password?',
                                style: TextStyle(
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            20.heightBox,
                            Center(
                              child: Obx(
                                () => loginController.isLoading.value
                                    ? CircularProgressIndicator()
                                    : Container(
                                        height: 50,
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 5,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .only(
                                                              bottomLeft: Radius
                                                                  .circular(5),
                                                              topLeft: Radius
                                                                  .circular(30),
                                                              topRight: Radius
                                                                  .circular(5),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          30))),
                                              backgroundColor: primaryColor,
                                            ),
                                            onPressed: () async {
                                              await loginController.loginUser();
                                              final prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setBool('isLoggedIn', true);
//                                               final prefs = await SharedPreferences.getInstance();
// prefs.setBool('isLoggedIn', false);
                                            },
                                            child: const Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                              ),
                            ),
                            10.heightBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Create an account?'),
                                GestureDetector(
                                    onTap: () {
                                      Get.to(() => RegistrationScreen());
                                    },
                                    child: Text(
                                      ' Sign Up',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
