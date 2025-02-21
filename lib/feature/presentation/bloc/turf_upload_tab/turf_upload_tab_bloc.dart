import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:echo_booking_owner/domain/repository/time_slotes_servises.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'turf_upload_tab_event.dart';
part 'turf_upload_tab_state.dart';

class TurfUploadTabBloc extends Bloc<TurfUploadTabEvent, TurfUploadTabState> {
  TimeSlotesServises timeSlotesServises = TimeSlotesServises();
  TurfUploadTabBloc() : super(TimeSlotsInitial()) {
    on<AddDateInitialEvent>((event, emit) async {
      Map<String, List<Map<String, dynamic>>> timeSlots =
          await timeSlotesServises.generateInitialDate();
      emit(SuccessState(timeSlots: timeSlots, selectIndex: 0));
    });

    on<AddDateEvent>((event, emit) async {
      Map<String, List<Map<String, dynamic>>> timeSlots =
          await timeSlotesServises.addDate(event.context);
      emit(SuccessState(timeSlots: timeSlots, selectIndex: event.index));
    });
    on<AddTimeSlotEvent>((event, emit) async {
      Map<String, List<Map<String, dynamic>>> timeSlots =
          await timeSlotesServises.addTimeSlot(
              event.selectedKey, event.context);
              log(timeSlots.toString());
              log("=====================================");
      emit(SuccessState(timeSlots: timeSlots, selectIndex: event.index));
    });

    on<RemoveTimeSlotEvent>((event, emit) async {
      Map<String, List<Map<String, dynamic>>> timeSlots =
          timeSlotesServises.removeTimeSlot(event.selectedKey, event.index);
      emit(SuccessState(timeSlots: timeSlots, selectIndex: event.index));
    });

    on<DateSelectIdxEvent>((event, emit) async {
      //emit(DateSelectedState(selectIndex: event.selectIndex));

      emit(SuccessState(
          timeSlots: timeSlotesServises.timeSlots,
          selectIndex: event.selectIndex));
    });
    on<ImagePickerEvent>(
      (event, emit) async {
        ImagePicker imagePicker = ImagePicker();
        final imagePicked =
            await imagePicker.pickImage(source: ImageSource.gallery);
        if (imagePicked != null) {
          final Uint8List bytes = await imagePicked.readAsBytes();
           log(timeSlotesServises.timeSlots.toString());
          emit(ImagePickerSuccessState(image: bytes));
          emit(SuccessState(timeSlots: timeSlotesServises.timeSlots, selectIndex: 0));
        }
      },
    );
    on<UpdateInitialDateEvent>(
      (event, emit) async {
        timeSlotesServises.timeSlots = event.timeSlots;
        log(event.timeSlots.toString());
        log("=====================================");
        emit(SuccessState(timeSlots: event.timeSlots, selectIndex: 0));
      },
    );

     on<ResetStateEvent>(
      (event, emit) async {
        timeSlotesServises.timeSlots.clear();
        emit(SuccessState(timeSlots: timeSlotesServises.timeSlots, selectIndex: 0));
      },
    );
  }
}
