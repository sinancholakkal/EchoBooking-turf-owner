
import 'package:echo_booking_owner/core/constent/size/size.dart';
import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int maxLine;
  const TextFormFieldWidget({
    super.key,
    this.controller,
    this.validator,
    this.maxLine =1
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: (screenWidth>500)? registerTextxFormFieldWidth : screenWidth *0.85,
      child: TextFormField(
        maxLines: maxLine,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          
          border: InputBorder.none,
          filled: true,
          fillColor: kwhite,
          //border: UnderlineInputBorder(),
      
          //label: Text(textUserName),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
      ),
    );
  }
}
