
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';

class TimeSlotesServises {
  Map<String, List<Map<String, dynamic>>> timeSlots = {};
  Future<Map<String, List<Map<String, dynamic>>>> generateInitialDate() async {
    String todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
    timeSlots[todayKey] = [];
    return timeSlots;
  }

  Future<Map<String, List<Map<String, dynamic>>>> addDate(
      BuildContext content) async {
    List<String> dateKeys = timeSlots.keys.toList();
    DateTime? picked = await showDatePicker(
      context: content,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
      lastDate: DateTime(2100),
    );
    if(picked !=null){
      String newDateKey =DateFormat("yyyy-MM-dd").format(picked);
      log(newDateKey);
    timeSlots[newDateKey] = [];
    }
    return timeSlots;
  }

  Future<Map<String, List<Map<String, dynamic>>>> addTimeSlot(
      String selectedKey, BuildContext context) async {
    TimeRange? result = await showTimeRangePicker(context: context,minDuration: Duration(hours: 1),maxDuration: Duration(hours: 1));
    if (result != null) {
      String startTime = result.startTime.toString();
      String endTime = result.endTime.toString();
      String time =
          "${startTime.substring(10, 15)} to ${endTime.substring(10, 15)}";

      timeSlots[selectedKey]!.add(
        {
          "time": time,
          "isAvailable": true,
        },
      );

      print(result);
    }
    return timeSlots;
  }

  Map<String, List<Map<String, dynamic>>> removeTimeSlot(
      String selectedKey, int index) {
    timeSlots[selectedKey]!.removeAt(index);
    return timeSlots;
  }
}
