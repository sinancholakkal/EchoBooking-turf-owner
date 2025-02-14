import 'package:echo_booking_owner/domain/models/turf_model.dart';
import 'package:echo_booking_owner/domain/repository/time_slotes_servises.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/turf_managing/turf_managing_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/tabs/tab_turf_upload.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/widgets/image_add_part_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenTurfUpdate extends StatefulWidget {
  final TurfModel turfModel;
   ScreenTurfUpdate({super.key,required this.turfModel});

  @override
  State<ScreenTurfUpdate> createState() => _ScreenTurfUpdateState();
}

class _ScreenTurfUpdateState extends State<ScreenTurfUpdate> {
  @override
  void dispose() {
    TimeSlotesServises().timeSlots.clear();
    images.value.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: TabTurfUpload(type: ActionType.editTurf,turfModel: widget.turfModel,),
    );

  }
}