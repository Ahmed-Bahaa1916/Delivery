import 'package:flutter/material.dart';

class CustomConatiner extends StatelessWidget {
  const CustomConatiner({
    super.key,
    required this.varible1,
    required this.varible2,
    required this.color,

  });

  final String varible1;
  final String varible2;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          varible1,
          style: TextStyle(
            color: Color(0xff808080),
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          varible2,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
