import 'package:echo_booking_owner/core/constent/size/size.dart';
import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final String labelText;
  final TextInputType textInputType;
  final double width;
  final int maxLine;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool readOnly;
  final String? initialValue;
  final Color enableBorderColor;
  final Color focusBorderColor;
  const TextFormWidget({
    super.key,
    this.labelText = "",
    this.textInputType = TextInputType.text,
    this.width = 600,
    this.maxLine = 1,
    this.validator,
    this.controller,
    this.readOnly = false,
    this.initialValue,
    this.enableBorderColor = kblue,
    this.focusBorderColor = Colors.red
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        initialValue: initialValue,
        validator: validator,
        maxLines: maxLine,
        keyboardType: textInputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(color: kwhite),
        decoration: InputDecoration(
            labelText: labelText,
            enabledBorder: OutlineInputBorder(
              borderSide:  BorderSide(width: 3, color: enableBorderColor),
              borderRadius: radius,
            ),
            // Set border for focused state
            focusedBorder: OutlineInputBorder(
              borderSide:
                   BorderSide(width: borderWidth, color:focusBorderColor ),
              borderRadius: radius,
            ),
            errorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: borderWidth, color: Colors.red),
              borderRadius: radius,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: borderWidth, color: Colors.red),
              borderRadius: radius,
            )),
      ),
    );
  }
}
