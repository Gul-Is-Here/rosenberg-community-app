import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/image_constants.dart';

class HomeStaticBackground extends StatelessWidget {
  HomeStaticBackground({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    // Get the HomeController instance using Get.find to ensure we don't create multiple instances
    final homeController = Get.find<HomeController>();
    final screenHeight1 = MediaQuery.of(context).size.height;

    return screenHeight1 < 700
        ? Container(
            height: screenHeight * 0.24,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(homeBg),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                VxSwiper.builder(
                  autoPlayCurve: Curves.easeInCirc,
                  autoPlay: true,
                  viewportFraction: .8,
                  height: 120,
                  itemCount: bannerList.length,
                  itemBuilder: (context, index) {
                    return Image.asset(bannerList[index])
                        .box
                        .rounded
                        .color(asColor)
                        .make()
                        .p16();
                  },
                ),
              ],
            ),
          )
        : Container(
            height: screenHeight * 0.24,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(homeBg),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                10.heightBox,
                VxSwiper.builder(
                  autoPlayCurve: Curves.easeInCirc,
                  autoPlay: true,
                  viewportFraction: .8,
                  height: 160,
                  itemCount: bannerList.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Text(
                        "Index $index",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ).box.rounded.color(asColor).make().p16();
                  },
                ),
              ],
            ),
          );
  }
}
