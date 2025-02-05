import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  String text;
   HeadingText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 28),
    );
  }
}