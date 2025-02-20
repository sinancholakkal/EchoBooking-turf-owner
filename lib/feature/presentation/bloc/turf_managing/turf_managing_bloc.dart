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
      emit(AddLoadingState());
      try{
        await turfService.addTurf(event.turfModel);
        emit(AddSuccessState());
      }on FirebaseException catch(e){
        log(e.code);
      }
    });
     on<FetchTurfsEvent>((event, emit) async{
      emit(FetchLoadingState());
      log("Event called======================");
      try{
       List<TurfModel> listTurfModel = await turfService.fetchturfs();
       log(listTurfModel.length.toString());
        emit(FetchLoadedState(listTurfModel: listTurfModel));
      }on FirebaseException catch(e){
        log(e.code);
      }
    });



    on<UpdateTurfEvent>((event, emit) async{
      emit(UpdateLoadingState());
      log("update Event called======================");
      try{
       await turfService.updateTurf(event.turfModel);
       emit(UpdateLoadedState());
       List<TurfModel> listTurfModel = await turfService.fetchturfs();
        emit(FetchLoadedState(listTurfModel: listTurfModel));
      }on FirebaseException catch(e){
        log(e.code);
      }
    });
    
    on<DeleteTurfEvent>((event, emit) async{
      emit(DeleteLoadingState());
      try{

        await turfService.deleteTurf(event.turfId);

        emit(DeleteLoadedState());
        emit(FetchLoadingState());
        List<TurfModel> listTurfModel = await turfService.fetchturfs();
        emit(FetchLoadedState(listTurfModel: listTurfModel));
      }catch(e){
        log(e.toString());
      }
    },);
    
  }
}
