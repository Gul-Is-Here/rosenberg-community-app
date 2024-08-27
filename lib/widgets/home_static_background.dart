import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/image_constants.dart';

class HomeStaticBackground extends StatelessWidget {
  final String userFname;
  final String userLname;
  HomeStaticBackground({
    super.key,
    required this.userFname,
    required this.userLname,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    final screenHeight1 = MediaQuery.of(context).size.height;
    return screenHeight1 < 700
        ? Container(
            height: screenHeight * 0.3,
            width: double.infinity,
            decoration: const BoxDecoration(
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
                        maxRadius: 25,
                        minRadius: 10,
                        backgroundColor: Colors.white,
                        child: Icon(
                          size: 25,
                          Icons.person,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                    10.widthBox,
                    Text(
                      'Assalamualaikum \n$userFname $userLname',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ],
                ),
                VxSwiper.builder(
                  autoPlayCurve: Curves.easeInCirc,
                  autoPlay: true,
                  viewportFraction: .8,
                  height: 120,
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
          )
        : Container(
            height: screenHeight * 0.3,
            width: double.infinity,
            decoration: const BoxDecoration(
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
                    Text(
                      'Assalamualaikum \n$userFname $userLname',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                VxSwiper.builder(
                  autoPlayCurve: Curves.easeInCirc,
                  autoPlay: true,
                  viewportFraction: .8,
                  height: 145,
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
          );
  }
}
