
import 'dart:ui';

import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  const TextWidget({
    super.key,
    required this.text,
    this.color = kwhite,
    this.fontWeight = FontWeight.bold,
    this.size
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontWeight: fontWeight,fontSize: size),
    );
  }
}
