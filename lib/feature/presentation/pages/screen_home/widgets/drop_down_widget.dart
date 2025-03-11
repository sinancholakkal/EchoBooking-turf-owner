import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    super.key,
    required this.initialDropDown,
    required this.items,
  });

  final ValueNotifier<String> initialDropDown;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Select catogery:",
          style: TextStyle(color: Colors.white),
        ),
        ValueListenableBuilder(
          valueListenable: initialDropDown,
          builder: (context, value, child) {
            return SizedBox(
              width: 290,
              child: DropdownButton(
                focusColor: Colors.white,
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down),
                value: items.contains(value)?value:items.first,
                items: items.toSet().map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                          fontSize: 14,
                          color: (initialDropDown.value == item)
                              ? kwhite
                              : Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  initialDropDown.value = val!;
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
