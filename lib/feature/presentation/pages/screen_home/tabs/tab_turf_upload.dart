import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:echo_booking_owner/core/constent/size/size.dart';
import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:echo_booking_owner/core/until/validation.dart';
import 'package:echo_booking_owner/domain/repository/location_service.dart';
import 'package:echo_booking_owner/domain/repository/time_slotes_servises.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/time_slots/turf_upload_tab_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/widgets/image_add_part_widget.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/widgets/text_form_widget.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/heading_text.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/showDiolog.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';

class TabTurfUpload extends StatefulWidget {
  TabTurfUpload({super.key});

  @override
  State<TabTurfUpload> createState() => _TabTurfUploadState();
}

class _TabTurfUploadState extends State<TabTurfUpload> {
  final ValueNotifier<String> initialDropDown = ValueNotifier("Text 1");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _turfName;
  late TextEditingController _phone;
  late TextEditingController _email;
  late TextEditingController _price;
  late TextEditingController _inclueds;
  late TextEditingController _landmark;
  late ValueNotifier<TextEditingController> _state;
  late ValueNotifier<TextEditingController> _country;
  String? name;

  final List<String> items = [
    'Text 1',
    'Text 2',
    'Text 3',
    'Text 4',
  ];

  @override
  void initState() {
    context.read<TurfUploadTabBloc>().add(AddDateInitialEvent());
    _turfName = TextEditingController();
    _phone = TextEditingController();
    _email = TextEditingController();
    _price = TextEditingController();
    _inclueds = TextEditingController();
    _landmark = TextEditingController();
    _state = ValueNotifier(TextEditingController());
    _country = ValueNotifier(TextEditingController());
    super.initState();
  }

  @override
  void dispose() {
    _turfName.dispose();
    _phone.dispose();
    _email.dispose();
    _price.dispose();
    _inclueds.dispose();
    _landmark.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 23, 24, 51),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height10,
                HeadingText(text: "Details about Turf"),
                //Turf name field-----------------------
                TextFormWidget(
                  controller: _turfName,
                  labelText: "Turf name",
                  textInputType: TextInputType.name,
                  validator: (value) {
                    return Validation.nameValidate(value: value);
                  },
                ),
                //phone number field---------------
                TextFormWidget(
                  controller: _phone,
                  labelText: "Phone",
                  textInputType: TextInputType.phone,
                  validator: (value) {
                    return Validation.phoneNumberValidate(value: value);
                  },
                ),
                //Email field------------
                TextFormWidget(
                  controller: _email,
                  labelText: "Email",
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    return Validation.emailValidation(value);
                  },
                ),
                //Price field------------------
                TextFormWidget(
                  controller: _price,
                  labelText: "Price for Hour",
                  textInputType: TextInputType.number,
                  validator: (value) {
                    return Validation.priceValidate(value: value);
                  },
                ),
                //State and location button====================================
                Row(
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
                          enableBorderColor: const Color.fromRGBO(141, 188, 227, 1),
                          focusBorderColor: const Color.fromRGBO(141, 188, 227, 1),
                          validator: (value){
                            return Validation.stateAndCountryValidate(value: value);
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
                            log(position.latitude.toString());
                            await LocationRepo.getStreatNames(
                                    position.latitude, position.longitude)
                                .then((value) {
                              log(value.toString());
                              _state.value.text = value["state"]!;
                              _country.value.text = value["country"]!;
                              _state.notifyListeners();
                            });
                          },
                          label: Text("My Location")),
                    ),
                  ],
                ),
                //country formField---------------------------------
                SizedBox(
                  child: ValueListenableBuilder(
                    valueListenable: _country,
                    builder: (context, value, child) {
                      return TextFormWidget(
                        validator: (value){
                          return Validation.stateAndCountryValidate(value: value);
                        },
                        readOnly: true,
                      controller: value,
                      labelText: "City",
                      width: 400,
                      enableBorderColor: const Color.fromRGBO(141, 188, 227, 1),
                          focusBorderColor: const Color.fromRGBO(141, 188, 227, 1),
                    );
                    },
                    
                  ),
                ),
                //DropDown menu button for catogery-----------
                Row(
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
                            value: value,
                            items: items.map((String item) {
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
                ),
                BlocBuilder<TurfUploadTabBloc, TurfUploadTabState>(
                  builder: (context, state) {
                    if (state is SuccessState) {
                      int selectedDateIndex = state.selectIndex;
                      log(selectedDateIndex.toString());

                      List<String> dateKeys = state.timeSlots.keys.toList();
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //Add date Button and displaying dates-------------------------
                          SizedBox(
                            height: 70,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dateKeys.length + 1,
                              itemBuilder: (context, index) {
                                if (index == dateKeys.length) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.read<TurfUploadTabBloc>().add(
                                            AddDateEvent(
                                                index: selectedDateIndex));
                                      },
                                      child: Text("Add Date"),
                                    ),
                                  );
                                }

                                return GestureDetector(
                                  onTap: () {
                                    context.read<TurfUploadTabBloc>().add(
                                        DateSelectIdxEvent(selectIndex: index));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: selectedDateIndex == index
                                          ? Colors.blue.withOpacity(0.2)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          DateFormat('dd MMM').format(
                                              DateFormat('yyyy-MM-dd')
                                                  .parse(dateKeys[index])),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: selectedDateIndex == index
                                                ? Colors.blue
                                                : kwhite,
                                          ),
                                        ),
                                        if (selectedDateIndex == index)
                                          Container(
                                            margin: EdgeInsets.only(top: 4),
                                            height: 4,
                                            width: 20,
                                            color: Colors.blue,
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                //Time slot add button--------------------
                                ElevatedButton(
                                  onPressed: () async {
                                    context.read<TurfUploadTabBloc>().add(
                                        AddTimeSlotEvent(
                                            selectedKey:
                                                dateKeys[selectedDateIndex],
                                            context: context,
                                            index: selectedDateIndex));
                                  },
                                  child: Text("Add Time Slot"),
                                ),
                                height10,
                                //time slots displaying------------------
                                SizedBox(
                                  width: 500,
                                  child: GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      childAspectRatio: 4,
                                    ),
                                    itemCount: state
                                            .timeSlots[
                                                dateKeys[selectedDateIndex]]
                                            ?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      var slot = state.timeSlots[
                                          dateKeys[selectedDateIndex]]![index];
                                      return ElevatedButton(
                                          onPressed: () {},
                                          onLongPress: () {
                                            alertBox(
                                                context: context,
                                                onPressed: () {
                                                  context
                                                      .read<TurfUploadTabBloc>()
                                                      .add(RemoveTimeSlotEvent(
                                                          selectedKey: dateKeys[
                                                              selectedDateIndex],
                                                          index: index));
                                                  Get.back();
                                                });
                                          },
                                          child: Text(slot["time"]));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),

                //Includes------------------
                Text(
                  "Includes",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                TextFormWidget(
                  controller: _inclueds,
                  maxLine: 5,
                  validator: (value) {
                    return Validation.includeValidate(value: value);
                  },
                ),

                //landmark Location------
                TextWidget(
                  text: "Landmark",
                ),
                TextFormWidget(
                  controller: _landmark,
                  maxLine: 3,
                  validator: (value) {
                    return Validation.landMarkValidate(value: value);
                  },
                ),
                height20,
                //Image adding part----------------------------
                TextWidget(text: "Image"),
                ImageAddingPart(),
                height10,

                //Add turf button-------------------------------
                Center(
                    child: CustomButton(
                  text: "Add Turf",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      print(" Validated--------------------");
                    } else {
                      print("Not Validated--------------------");
                    }
                  },
                  width: 250,
                )),
                height20
              ],
            ),
          ),
        ),
      ),
    );
  }
}
