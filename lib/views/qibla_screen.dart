import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class QiblahScreen extends StatefulWidget {
  const QiblahScreen({Key? key});

  @override
  State<QiblahScreen> createState() => _QiblahScreenState();
}

Animation<double>? animation;
AnimationController? _animationController;
double begin = 0.0;

class _QiblahScreenState extends State<QiblahScreen>
    with SingleTickerProviderStateMixin {
  String? locationCountry;
  String? locationCity;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
    _getLocation();
    super.initState();
  }

  Future<void> _getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // _showSnackBar('Please grant location permission.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      setState(() {
        locationCountry = placemarks[0].country;
        locationCity = placemarks[0].locality;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(width: 1, color: Colors.green)),
                child: Container(
                  height: 45,
                  // padding: const EdgeInsets.symmetric(horizontal: ),
                  color:  Colors.white,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color:  Colors.green,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      const SizedBox(width: 50),
                      const Text(
                        "Qibla Direction",
                        style: TextStyle(
                          color:  Colors.grey,
                          fontSize: 15,
                          // fontFamily: medium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 45,
                child: Card(
                  elevation: 0,
                  // margin: EdgeInsets.symmetric(horizontal: 4),
                  color:  Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      'Compass'
                          .text
                          
                          .color(Colors.white)
                          .size(15)
                          .make(),
                      'Location'
                          .text
                          // .fontFamily(medium)
                          .color( Colors.white)
                          .size(15)
                          .make(),
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: FlutterQiblah.qiblahStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                      ));
                }

                final qiblahDirection = snapshot.data;
                animation = Tween(
                        begin: begin,
                        end: (qiblahDirection!.qiblah * (pi / 180) * -1))
                    .animate(_animationController!);
                begin = (qiblahDirection.qiblah * (pi / 180) * -1);
                _animationController!.forward(from: 0);

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${qiblahDirection.direction.toInt()}°",
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Text(
                                    ' $locationCountry, $locationCity',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  5.widthBox,
                                  "|".text.color(Colors.green).size(20).make(),
                                  5.widthBox,
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.green,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .53,
                              width: MediaQuery.of(context).size.width * 1,
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(''),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height *
                                .26, // Adjust the positioning of the image as needed
                            left: MediaQuery.of(context).size.height *
                                .20, // Adjust the positioning of the image as needed
                            child: AnimatedBuilder(
                              animation: animation!,
                              builder: (context, child) => Transform.rotate(
                                angle: animation!.value,
                                child: SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: Center(
                                    child: Image.asset(
                                      '',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}