import 'package:flutter/material.dart';

class ImageText extends StatelessWidget {
  const ImageText({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    
    final List<String> images = [
      'assets/images/handmoney.png',
      'assets/images/bills.png',
      'assets/images/taskpad.png',
    ];

    final List<String> titles = [
      'Gain total control of your money',
      'Know where your money goes',
      'Planning Ahead',
    ];
    final List<String> subTitles = [
      'Become your own money manager\nand make every cent count',
      'Track your transaction easily,\nwith categories and financial report ',
      'Setup your budget for each category\nso you in control',
    ];
    return Column(
      children: [
        Image.asset(images[index]),
        Text(
          titles[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          subTitles[index],
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
