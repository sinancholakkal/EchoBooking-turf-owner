import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final String labelText;
  final TextInputType textInputType;
  final double width;
  final int maxLine;
  TextFormWidget({
    super.key,
    this.labelText = "",
    this.textInputType = TextInputType.text,
    this.width = 600,
    this.maxLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        maxLines: maxLine,
        keyboardType: textInputType,
        style: TextStyle(color: kwhite),
        decoration: InputDecoration(
            labelText: labelText,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.blue),
              borderRadius: BorderRadius.circular(15),
            ),
            // Set border for focused state
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            )),
      ),
    );
  }
}
