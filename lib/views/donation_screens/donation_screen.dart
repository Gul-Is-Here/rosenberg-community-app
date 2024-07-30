import 'package:community_islamic_app/controllers/donation_controller.dart';
import 'package:community_islamic_app/views/home_screens/azanoverlay_screen.dart';
import 'package:community_islamic_app/widgets/customized_card_widget2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../app_classes/app_class.dart';
import '../../constants/image_constants.dart';
import '../../model/donation_model.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var donationController = Get.put(DonationController());
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder<Donation>(
        future: donationController.fetchDonationData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Color(0xFF006367),
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else if (snapshot.hasData) {
            final donations = snapshot.data!.data.donate;
            return Column(
              children: [
                Container(
                  height: screenHeight * .25,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    image: DecorationImage(
                      image: AssetImage(qiblaTopBg),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: CircleAvatar(
                              maxRadius: 35,
                              minRadius: 10,
                              backgroundColor: Colors.white,
                              child: Icon(
                                size: 50,
                                Icons.person,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                          10.widthBox,
                          const Text(
                            'Assalamualaikum \nGul Faraz',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      10.heightBox,
                      const Text(
                        'DONATION',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                10.heightBox,

                // Dynamically create donation categories
                Expanded(
                  child: ListView.builder(
                    itemCount: donations.length,
                    itemBuilder: (context, index) {
                      final donate = donations[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: double.infinity,
                            color: Color(0xFF006367),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                donate.donationcategoryName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          10.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: donate.hasdonation.map((hasDonation) {
                              return CusTomizedCardWidget2(
                                title: hasDonation.donationName,
                                imageIcon: hasDonation.donationImage.toString(),
                                onTap: () async {
                                  try {
                                    await AppClass()
                                        .launchURL(hasDonation.donationLink);
                                  } catch (e) {
                                    print(
                                        'Could not launch ${hasDonation.donationLink}');
                                  }
                                },
                              );
                            }).toList(),
                          ),
                          10.heightBox,
                         
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("No data found"));
          }
        },
      ),
    );
  }
}
