import 'package:echo_booking_owner/core/until/validation.dart';
import 'package:echo_booking_owner/domain/repository/location_service.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationFetchingPartWidget extends StatelessWidget {
  const LocationFetchingPartWidget({
    super.key,
    required ValueNotifier<TextEditingController> state,
    required this.name,
    required ValueNotifier<TextEditingController> country,
  }) : _state = state, _country = country;

  final ValueNotifier<TextEditingController> _state;
  final String? name;
  final ValueNotifier<TextEditingController> _country;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        ValueListenableBuilder(
          valueListenable: _state,
          builder: (context, value, child) {
            return TextFormWidget(
              controller: value,
              initialValue: name,
              readOnly: true,
              labelText: "State",
              width: 400,
              enableBorderColor:
                  const Color.fromRGBO(141, 188, 227, 1),
              focusBorderColor:
                  const Color.fromRGBO(141, 188, 227, 1),
              validator: (value) {
                return Validation.stateAndCountryValidate(
                    value: value);
              },
            );
          },
        ),
        //Location button--------------------
        SizedBox(
          width: 180,
          child: ElevatedButton.icon(
              icon: Icon(Icons.my_location),
              onPressed: () async {
                Position position =
                    await LocationRepo.getingPosition();
                await LocationRepo.getStreatNames(
                        position.latitude, position.longitude)
                    .then((value) {
                  _state.value.text = value["state"]!;
                  _country.value.text = value["country"]!;
                  _state.notifyListeners();
                });
              },
              label: Text("My Location")),
        ),
      ],
    );
  }
}