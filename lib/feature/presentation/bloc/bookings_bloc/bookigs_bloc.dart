import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:echo_booking_owner/domain/models/booking_turf_model.dart';
import 'package:echo_booking_owner/domain/repository/booking_service.dart';
import 'package:meta/meta.dart';

part 'bookigs_event.dart';
part 'bookigs_state.dart';

class BookigsBloc extends Bloc<BookigsEvent, BookigsState> {
  BookigsBloc() : super(BookigsInitial()) {
    on<FetchBookigsEvent>((event, emit) async{
      emit(FetchLoadingState());
      try{
        final List<BookingTurfmodel> turfs = await BookingService().fetchBookigsTurf();
        emit(FetchLoadedState(bookigTurfModels: turfs));
      }catch(e){
        log("Somthing wrong while fetching Booking turfs $e");
      }
    });
  }
}
