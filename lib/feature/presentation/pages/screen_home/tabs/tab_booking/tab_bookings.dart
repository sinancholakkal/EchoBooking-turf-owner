import 'package:echo_booking_owner/core/constent/text/text.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/bookings_bloc/bookigs_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/tabs/tab_booking/widget/table_booking_data_widget.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/widgets/table_heading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;

class TabBookings extends StatelessWidget {
  TabBookings({super.key});
  
  @override
  Widget build(BuildContext context) {
    context.read<BookigsBloc>().add(FetchBookigsEvent());
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 23, 24, 51),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Table heading----------------------
              TableHeadingWidget(
                headigs: headigsOfbookigs,
              ),
              //Table datas-------
              TableDataWidget()
            ],
          ),
        ),
      ),
    );
  }
}

