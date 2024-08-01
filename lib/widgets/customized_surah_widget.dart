import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomizedSurahWidget extends StatelessWidget {
  const CustomizedSurahWidget({
    super.key,
    required this.onTap1,
    required this.onTap2,
    required this.surahOnTap,
    required this.firstIcon,
    required this.secondIcon,
    required this.surahTxet,
    required this.thirdIcon,
    required this.surahNumber,
  });

  final void Function() onTap1;
  final void Function() onTap2;
  final void Function() surahOnTap;
  final IconData firstIcon;
  final IconData secondIcon;
  final String surahTxet;
  final String thirdIcon;
  final int surahNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.green,
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
                  onPressed: onTap1,
                  icon: Icon(
                    firstIcon,
                    size: 32,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        ),
        10.widthBox,
        Container(
          decoration: BoxDecoration(
            color: Colors.green,
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
                    size: 32,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        ),
        10.widthBox,
        Expanded(
          child: Text(
            'سُورَةُ $surahTxet',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        10.widthBox,
        Image.asset(
          thirdIcon,
          height: 40,
          fit: BoxFit.cover,
        ),
        10.widthBox,
        Text(
          surahNumber.toString(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
      
    );
  }
}
