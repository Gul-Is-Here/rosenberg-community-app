import 'package:community_islamic_app/widgets/customized_card_widget2.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/image_constants.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: screenHeight * .25,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              image: DecorationImage(
                image: AssetImage(homeBg),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                Text(
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
          Container(
            width: double.infinity,
            height: 40, color: Color(0xFF006367),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                'Donation',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ), // Re)d container
          ),
          Row(
            children: [
              CusTomizedCardWidget2(
                  title: 'Genral Donation',
                  imageIcon: donationIcon,
                  onTap: () {}),
              CusTomizedCardWidget2(
                  title: 'AL-AWWALIN\n(100 FOR 100)',
                  imageIcon: donationIcon,
                  onTap: () {}),
              CusTomizedCardWidget2(
                  title: 'Genral Donation',
                  imageIcon: donationIcon,
                  onTap: () {})
            ],
          )
        ],
      ),
    );
  }
}
