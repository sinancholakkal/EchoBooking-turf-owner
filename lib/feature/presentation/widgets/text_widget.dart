
import 'dart:ui';

import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  TextWidget({
    super.key,
    required this.text,
    this.color = kwhite,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}
