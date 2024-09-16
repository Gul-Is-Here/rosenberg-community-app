import 'package:community_islamic_app/app_classes/app_class.dart';
import 'package:community_islamic_app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomizedSurahWidget extends StatelessWidget {
  const CustomizedSurahWidget({
    super.key,
    required this.onTap1,
    required this.onTapNavigation,
    required this.onTap2,
    required this.surahOnTap,
    required this.firstIcon,
    required this.secondIcon,
    required this.surahTxet,
    required this.thirdIcon,
    required this.surahNumber,
  });
  final void Function() onTapNavigation;
  final void Function() onTap1;
  final void Function() onTap2;
  final void Function() surahOnTap;
  final String firstIcon;
  final IconData secondIcon;
  final String surahTxet;
  final String thirdIcon;
  final int surahNumber;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapNavigation,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: GestureDetector(
                  onTap: onTap1,
                  child: Center(
                      child: Image.asset(
                    firstIcon,
                    height: 35,
                    width: 35,
                    fit: BoxFit.cover,
                    color: primaryColor,
                  )),
                ),
              ),
            ),
          ),
          10.widthBox,
          Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: onTap2,
                    icon: Icon(
                      secondIcon,
                      size: 24,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          10.widthBox,
          Expanded(
            child: Text(
              surahTxet,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: jameelNori2),
            ),
          ),
          10.widthBox,
          Image.asset(
            thirdIcon,
            height: 24,
            fit: BoxFit.cover,
          ),
          10.widthBox,
          Text(surahNumber.toString(),
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: popinsRegulr))
        ],
      ),
    );
  }
}
