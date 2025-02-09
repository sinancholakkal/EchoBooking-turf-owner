import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking_owner/domain/models/turf_model.dart';
import 'package:echo_booking_owner/domain/repository/turf_service.dart';
import 'package:meta/meta.dart';

part 'turf_managing_event.dart';
part 'turf_managing_state.dart';

class TurfManagingBloc extends Bloc<TurfManagingEvent, TurfManagingState> {
  TurfService turfService = TurfService();
  TurfManagingBloc() : super(TurfManagingInitial()) {
    on<AddTurfEvent>((event, emit) async{
      emit(TurfLoadingState());
      try{
        await turfService.addTurf(event.turfModel);
        emit(TurfLoadedState());
      }on FirebaseException catch(e){
        log(e.code);
      }
    });
  }
}
