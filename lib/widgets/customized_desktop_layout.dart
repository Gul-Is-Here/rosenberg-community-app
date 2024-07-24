import 'package:community_islamic_app/views/qibla_screen.dart';
import 'package:community_islamic_app/widgets/customized_card_widget.dart';
import 'package:community_islamic_app/widgets/customized_prayertext_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/image_constants.dart';
import 'customized_prayertime_widget.dart';

class CustomizedDesktopLayout extends StatelessWidget {
  final double screenHeight;
  final String formattedTime;
  const CustomizedDesktopLayout(
      {super.key, required this.formattedTime, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: screenHeight * 0.35,
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
                  const Text(
                    'Assalamualaikum \nGul Faraz',
                    style: TextStyle(color: Colors.white),
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
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: screenHeight * 0.70,
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
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          elevation: 5,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          margin: EdgeInsets.zero,
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                image: DecorationImage(
                                    image: AssetImage(
                                      namazQiblaBg,
                                    ),
                                    fit: BoxFit.cover)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                5.heightBox,
                                const Text(
                                  'NAMAZ & IQAMA',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                const CustomizedPrayerTextWidget(
                                    iconColor: Colors.white,
                                    color: Colors.white,
                                    title: 'PRAYER: ',
                                    prayerName: 'ASR'),
                                const CustomizedPrayerTextWidget(
                                    iconColor: Colors.white,
                                    color: Colors.white,
                                    icon: Icons.timelapse,
                                    title: "NAMAZ",
                                    prayerName: ': 3 hours 45 mins'),
                                const CustomizedPrayerTextWidget(
                                    iconColor: Colors.white,
                                    color: Colors.white,
                                    icon: Icons.timelapse,
                                    title: "IQAMA",
                                    prayerName: ': 3 hours 45 mins'),
                                10.heightBox,
                                const Text(
                                  "Jun 27 2024  الخميس 20 ذو الحجة 1445هـ ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 9),
                                ),
                                10.heightBox,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomizedPrayerTimeWidget(
                                        text: 'ASR',
                                        time: formattedTime,
                                        image: sunriseIcon),
                                    15.widthBox,
                                    CustomizedPrayerTimeWidget(
                                        text: 'ASR',
                                        time: formattedTime,
                                        image: sunriseIcon),
                                    15.widthBox,
                                    CustomizedPrayerTimeWidget(
                                        text: 'ASR',
                                        time: formattedTime,
                                        image: sunriseIcon),
                                    15.widthBox,
                                    CustomizedPrayerTimeWidget(
                                        text: 'ASR',
                                        time: formattedTime,
                                        image: sunriseIcon),
                                    15.widthBox,
                                    CustomizedPrayerTimeWidget(
                                        text: 'ASR',
                                        time: formattedTime,
                                        image: sunriseIcon),
                                  ],
                                ),
                                10.heightBox,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                width: 2, color: Colors.white)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          child: Column(
                                            children: [
                                              const Text(
                                                "JUMUAH KHUTBA",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11),
                                              ),
                                              Text(
                                                formattedTime,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.white, width: 2)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          child: Column(
                                            children: [
                                              const Text(
                                                "JUMUAH IQAMAH",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11),
                                              ),
                                              Text(
                                                formattedTime,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
