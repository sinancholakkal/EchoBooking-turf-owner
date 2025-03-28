import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:echo_booking_owner/domain/models/booking_turf_model.dart';
import 'package:echo_booking_owner/domain/repository/dash_board_service.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'dash_board_event.dart';
part 'dash_board_state.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
  DashBoardBloc() : super(DashBoardInitial()) {
    on<FetchingDashBoardEvent>((event, emit) async{
      emit(FetchLoadingState());
      try{
        final Map<String,List<BookingTurfmodel>> turfs = await DashBoardService().fetchDashBoard();
        emit(FetchLoadedState(bookigTurfModels: turfs));
      }catch(e){
        log("Somthing wrong while fetching Dashboard bookings turfs $e");
      }
    });

   
  }
}
