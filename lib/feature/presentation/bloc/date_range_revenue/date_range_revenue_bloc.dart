import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:echo_booking_owner/domain/repository/dash_board_service.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'date_range_revenue_event.dart';
part 'date_range_revenue_state.dart';

class DateRangeRevenueBloc
    extends Bloc<DateRangeRevenueEvent, DateRangeRevenueState> {
  DateRangeRevenueBloc() : super(DateRangeRevenueInitial()) {
    on<DateRangeRevenueFetchEvent>(
      (event, emit) async {
        String? startD;
        String? endD;
        try {
          await showCustomDateRangePicker(
            event.context,
            dismissible: true,
            minimumDate: DateTime.now().subtract(const Duration(days: 30)),
            maximumDate: DateTime.now().add(const Duration(days: 30)),
            backgroundColor: Colors.white,
            primaryColor: Colors.green,
            onApplyClick: (start, end) {
             // log("$start to $end");

              startD = formatDate(start);
              endD = formatDate(end);
              Navigator.pop(event.context);
            },
            onCancelClick: () {},
          );
          
          if (startD != null) {
            emit(DateRangeRevenueLoading());
            final String revanue = await DashBoardService().fetchRevanueDateRange(startD: startD!,endD: endD!);
            emit(DateRangeRevenueLoaded(
                fromDate: formatMonth(startD!), toDate: formatMonth(endD!), revenueAmount: revanue));
          }
        } catch (e) {
          log("Somthing issue while fetching date range revenue $e");
        }
      },
    );
  }
}

String formatDate(DateTime date) {
  return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
}
String formatMonth(String d) {
  DateTime date = DateFormat("dd-MM-yyyy").parse(d);
  return "${date.day} ${DateFormat('MMMM').format(date)} ${date.year}";
}
