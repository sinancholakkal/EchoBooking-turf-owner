import 'dart:developer';

import 'package:echo_booking_owner/core/constent/size/size.dart';
import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:echo_booking_owner/domain/repository/time_slotes_servises.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/time_slots/time_slots_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/widgets/text_form_widget.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/heading_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';

class TabTurfUpload extends StatefulWidget {
  TabTurfUpload({super.key});

  @override
  State<TabTurfUpload> createState() => _TabTurfUploadState();
}

class _TabTurfUploadState extends State<TabTurfUpload> {
  final ValueNotifier<String> initialDropDown = ValueNotifier("Text 1");
  int selectedDateIndex = 0;

  final List<String> items = [
    'Text 1',
    'Text 2',
    'Text 3',
    'Text 4',
  ];


  @override
  void initState() {
    context.read<TimeSlotsBloc>().add(AddDateInitialEvent());
    super.initState();
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
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height10,
              HeadingText(text: "Details about Turf"),
              TextFormWidget(
                labelText: "Turf name",
                textInputType: TextInputType.name,
              ),
              TextFormWidget(
                labelText: "Phone",
                textInputType: TextInputType.phone,
              ),
              TextFormWidget(
                labelText: "Email",
                textInputType: TextInputType.emailAddress,
              ),
              TextFormWidget(
                labelText: "Price for Hour",
              ),
              Row(
                spacing: 10,
                children: [
                  TextFormWidget(
                    labelText: "State",
                    width: 400,
                  ),
                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                        onPressed: () {}, child: Text("My Location")),
                  ),
                ],
              ),
              SizedBox(
                child: TextFormWidget(
                  labelText: "City",
                  width: 400,
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
              BlocBuilder<TimeSlotsBloc, TimeSlotsState>(
                builder: (context, state) {
                  if(state is SuccessState){
                    List<String> dateKeys = state.timeSlots.keys.toList();
                    return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //Add date Button and displaying dates-------------------------
                      SizedBox(
                        height: 70,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: dateKeys.length +
                              1, // Extra item for "Add Date" button
                          itemBuilder: (context, index) {
                            if (index == dateKeys.length) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<TimeSlotsBloc>().add(AddDateEvent());
                                  },
                                  child: Text("Add Date"),
                                ),
                              );
                            }

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedDateIndex = index;
                                });
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
                                //addTimeSlot(dateKeys[selectedDateIndex]);
                                //addTimeSlot(dateKeys[selectedDateIndex]);
                                context.read<TimeSlotsBloc>().add(AddTimeSlotEvent(selectedKey: dateKeys[selectedDateIndex], context: context));
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
                                        .timeSlots[dateKeys[selectedDateIndex]]
                                        ?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  var slot = state.timeSlots[
                                      dateKeys[selectedDateIndex]]![index];
                                  return ElevatedButton(
                                      onPressed: () {},
                                      onLongPress: () {
                                        showDialog(context: context, builder: (context) {
                                          return AlertDialog(
                                            title: Text("Remove"),
                                            content: Text("Are you sure want to remove time slot?"),
                                            actions: [
                                              TextButton(onPressed: (){
                                                Get.back();
                                              }, child: Text("cancel")),
                                              TextButton(onPressed: (){
                                                context.read<TimeSlotsBloc>().add(RemoveTimeSlotEvent(selectedKey: dateKeys[selectedDateIndex], index: index));
                                                Get.back();
                                              }, child: Text("Ok"))
                                            ],
                                          );
                                        },);
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
                  }else{
                    return SizedBox();
                  }
                  
                },
              ),

              //Includes------------------
              Text(
                "Includes",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              TextFormWidget(
                maxLine: 5,
              ),

              //landmark Location------
              //Includes------------------
              Text(
                "Landmark",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              TextFormWidget(
                maxLine: 3,
              ),
              height20
            ],
          ),
        ),
      ),
    );
  }
}

