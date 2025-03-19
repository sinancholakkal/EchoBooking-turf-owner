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
    if (picked != null) {
      String newDateKey = DateFormat("yyyy-MM-dd").format(picked);
      log(newDateKey);
      timeSlots[newDateKey] = [];
    }
    return timeSlots;
  }

  Future<Map<String, List<Map<String, dynamic>>>> addTimeSlot(
      String selectedKey, BuildContext context) async {
    TimeRange? result = await showTimeRangePicker(
      use24HourFormat: false,
      context: context,
      minDuration: Duration(hours: 1),
      maxDuration: Duration(hours: 1),
    );
    if (result != null) {
      String startTime = DateFormat.jm().format(DateTime(0, 1, 1, result.startTime.hour, result.startTime.minute));
      String endTime = DateFormat.jm().format(DateTime(0, 1, 1, result.endTime.hour, result.endTime.minute));
      String time ="$startTime to $endTime";

      timeSlots[selectedKey]!.add(
        {
          "time": time,
          "isAvailable": true,
        },
      );

      log(startTime);
      log(endTime);
    }
    return timeSlots;
  }

  Map<String, List<Map<String, dynamic>>> removeTimeSlot(
      String selectedKey, int index) {
    timeSlots[selectedKey]!.removeAt(index);
    return timeSlots;
  }
}
