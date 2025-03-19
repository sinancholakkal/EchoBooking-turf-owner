import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'date_range_revenue_event.dart';
part 'date_range_revenue_state.dart';

class DateRangeRevenueBloc extends Bloc<DateRangeRevenueEvent, DateRangeRevenueState> {
  DateRangeRevenueBloc() : super(DateRangeRevenueInitial()) {
     on<DateRangeRevenueFetchEvent>((event, emit)async{
      String? startD;
      String? endD;
      try{
        await showCustomDateRangePicker(
            event.context,
            dismissible: true,
            minimumDate: DateTime.now().subtract(const Duration(days: 30)),
            maximumDate: DateTime.now().add(const Duration(days: 30)),
            backgroundColor: Colors.white,
            primaryColor: Colors.green,
            onApplyClick: (start, end) {
              log("$start to $end");
              startD = start.toString().substring(0,10);
              endD = end.toString().substring(0,10);
              Navigator.pop(event.context);
              

            },
            onCancelClick: () {
              
            },
          );
          emit(DateRangeRevenueLoading());
          if(startD !=null){
            await Future.delayed(Duration(seconds: 3));
            emit(DateRangeRevenueLoaded(fromDate: startD!, toDate: endD!, revenueAmount: "673773"));
          }
      }catch(e){
        log("Somthing issue while fetching date range revenue $e");
      }
    },);
  }
}
