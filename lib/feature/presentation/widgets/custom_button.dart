import 'package:echo_booking_owner/core/constent/size/size.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? screenWidth;
  String text;
  double? width;
  double? height;
  double radius;
  TextStyle textStyle;
  Color color;
  void Function()? onTap;
  CustomButton({
    super.key,
     this.screenWidth,
    required this.text,
    this.onTap,
    this.width = 80,
    this.height = 50,
    this.radius = 30,
    this.color = const Color.fromARGB(255, 157, 198, 144),
    this.textStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width:screenWidth!=null? screenWidth !* .80 : width,
        width: (screenWidth!>500)? registerTextxFormFieldWidth : screenWidth !*0.85,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: color),
        child: Center(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
