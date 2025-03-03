import 'dart:typed_data';

import 'package:echo_booking_owner/core/constent/size/size.dart';
import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/flutter_toast.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/showDiolog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

//ValueNotifier<List<Uint8List>> images = ValueNotifier([]);
ValueNotifier<List<dynamic>> images = ValueNotifier([]);

class ImageAddingPart extends StatelessWidget {
  const ImageAddingPart({super.key});

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
                  InkWell(
                    onLongPress: () {
                      alertBox(
                          context: context,
                          onPressed: () {
                            images.value.removeLast();
                            images.notifyListeners();
                            Navigator.pop(context);
                            fluttertoast(msg: "Image removed");
                          },
                          title: "Remove",
                          content: "Are you sure want to remove this image?");
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: (value.isEmpty) ? Colors.red : kblue,
                              width: borderWidth),
                          borderRadius: radius),
                      child: (value.isNotEmpty)
                          ? ClipRRect(
                              borderRadius: radius,
                              child: (value.last is String)
                                  ? InstaImageViewer(
                                    child: Image(
                                       fit: BoxFit.cover,
                                        image: Image.network(
                                          value.last,
                                         
                                        ).image,
                                      ),
                                  )
                                  : InstaImageViewer(
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: Image.memory(
                                          value.last,
                                          
                                        ).image,
                                    ),
                                  ))
                          : null,
                    ),
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
                        return InkWell(
                          onLongPress: () {
                            alertBox(
                                context: context,
                                onPressed: () {
                                  images.value.removeAt(index);
                                  images.notifyListeners();
                                  Navigator.pop(context);
                                  fluttertoast(msg: "Image removed");
                                },
                                title: "Remove",
                                content:
                                    "Are you sure want to remove this image?");
                          },
                          child: Container(
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
                              child: (value[index] is String)
                                  ? InstaImageViewer(
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: Image.network(
                                          value[index],
                                          
                                        ).image,
                                    ),
                                  )
                                  : InstaImageViewer(
                                    
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: Image.memory(
                                          value[index],
                                          
                                        ).image,
                                    ),
                                  ),
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
