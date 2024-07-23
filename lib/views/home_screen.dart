import 'package:community_islamic_app/views/qibla_screen.dart';
import 'package:community_islamic_app/widgets/customized_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/image_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen height
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            // Set the height to 40% of the screen height
            height: screenHeight * 0.40,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(homeBg),
                fit: BoxFit
                    .cover, // Ensures the image covers the entire container
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        maxRadius: 35,
                        minRadius: 10,
                        backgroundColor: Colors.white,
                        child: Icon(
                          size: 60,
                          Icons.person,
                          color: Colors.amber,
                        ),
                      ),
                      10.widthBox,
                      const Text(
                        'Assalamualaikum \nGul Faraz',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                VxSwiper.builder(
                  autoPlayCurve: Curves.easeInCirc,
                  autoPlay: true,
                  viewportFraction: .8,
                  height: 160,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Text(
                        "Index $index",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ).box.rounded.color(Vx.amber500).make().p16();
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: screenHeight * 0.65,
              width: double.infinity,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                elevation: 10,
                color: Colors.white,
                margin: EdgeInsets.zero, // Ensure the card has no margin
                child: Padding(
                  padding: EdgeInsets.zero, // Ensure the card has no padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CusTomizedCardWidget(
                              title: 'About Us',
                              imageIcon: aboutUsIcon,
                              onTap: () {}),
                          CusTomizedCardWidget(
                              title: 'Qibla Direction',
                              imageIcon: qiblaIconBg,
                              onTap: () {
                                Get.to(() => QiblahScreen());
                              }),
                          CusTomizedCardWidget(
                              title: 'Ask Imam',
                              imageIcon: askImamIcon,
                              onTap: () {})
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CusTomizedCardWidget(
                              title: 'Donate',
                              imageIcon: donationIcon,
                              onTap: () {}),
                          CusTomizedCardWidget(
                              title: 'Contact Us',
                              imageIcon: contactUsIcon,
                              onTap: () {}),
                          CusTomizedCardWidget(
                              title: 'Gallery',
                              imageIcon: galleryIcon,
                              onTap: () {})
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
