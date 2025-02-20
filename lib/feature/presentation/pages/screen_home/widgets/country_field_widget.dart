import 'package:echo_booking_owner/core/until/validation.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';

class CountryFieldWidget extends StatelessWidget {
  const CountryFieldWidget({
    super.key,
    required ValueNotifier<TextEditingController> country,
  }) : _country = country;

  final ValueNotifier<TextEditingController> _country;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ValueListenableBuilder(
        valueListenable: _country,
        builder: (context, value, child) {
          return TextFormWidget(
            validator: (value) {
              return Validation.stateAndCountryValidate(
                  value: value);
            },
            readOnly: true,
            controller: value,
            labelText: "Country",
            width: 400,
            enableBorderColor:
                const Color.fromRGBO(141, 188, 227, 1),
            focusBorderColor:
                const Color.fromRGBO(141, 188, 227, 1),
          );
        },
      ),
    );
  }
}

