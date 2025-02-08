import 'package:bloc/bloc.dart';
import 'package:echo_booking_owner/domain/repository/time_slotes_servises.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'time_slots_event.dart';
part 'time_slots_state.dart';

class TimeSlotsBloc extends Bloc<TimeSlotsEvent, TimeSlotsState> {
  TimeSlotesServises timeSlotesServises = TimeSlotesServises();
  TimeSlotsBloc() : super(TimeSlotsInitial()) {
    on<AddDateInitialEvent>((event, emit) async{
      Map<String, List<Map<String, dynamic>>>timeSlots =await timeSlotesServises.generateInitialDate();
      emit(SuccessState(timeSlots: timeSlots));
    });

    on<AddDateEvent>((event, emit) async{
      Map<String, List<Map<String, dynamic>>>timeSlots = timeSlotesServises.addDate();
      emit(SuccessState(timeSlots: timeSlots));
    });
    on<AddTimeSlotEvent>((event, emit) async{
      Map<String, List<Map<String, dynamic>>>timeSlots = await timeSlotesServises.addTimeSlot(event.selectedKey,event.context);
      emit(SuccessState(timeSlots: timeSlots));
    });

    on<RemoveTimeSlotEvent>((event, emit) async{
      Map<String, List<Map<String, dynamic>>>timeSlots =  timeSlotesServises.removeTimeSlot(event.selectedKey,event.index);
      emit(SuccessState(timeSlots: timeSlots));
    });
    
  }
}
