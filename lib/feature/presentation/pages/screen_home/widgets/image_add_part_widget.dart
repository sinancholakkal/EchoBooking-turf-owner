import 'dart:typed_data';

import 'package:echo_booking_owner/core/constent/size/size.dart';
import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageAddingPart extends StatelessWidget {
  ImageAddingPart({super.key});
  ValueNotifier<List<Uint8List>> images = ValueNotifier([]);

  Future<void> imagePicking() async {
    ImagePicker imagePicker = ImagePicker();
    final imagePicked =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      final Uint8List bytes = await imagePicked.readAsBytes();
      images.value.add(bytes);
      images.notifyListeners();
    }
  }

  ValueNotifier<List<Uint8List>> get getImages => images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: ValueListenableBuilder(
        valueListenable: images,
        builder: (context, value, child) {
          return Column(
            children: [
              //main image container-----------------
              Row(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: (value.isEmpty)?Colors.red : kblue, width: borderWidth),
                        borderRadius: radius),
                    child: (value.isNotEmpty)
                        ? ClipRRect(
                            borderRadius: radius,
                            child: Image.memory(
                              value.last,
                              fit: BoxFit.cover,
                            ),
                          )
                        : null,
                  ),
                  //image add button------------------
                  IconButton(
                      onPressed: imagePicking,
                      icon: Icon(
                        Icons.add,
                        color: kwhite,
                      )),
                ],
              ),
              //image children container--------------------
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: 600,
                  child: Wrap(
                      spacing: 10,
                      direction: Axis.horizontal,
                      children: List.generate(value.length, (index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: kblue,
                            ),
                            borderRadius: radius,
                          ),
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: radius,
                            child: Image.memory(
                              value[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      })),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}