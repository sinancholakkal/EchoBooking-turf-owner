import 'dart:developer';

import 'package:echo_booking_owner/domain/models/booking_turf_model.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/bookings_bloc/bookigs_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
class TableDataWidget extends StatelessWidget {
  const TableDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return bloc.BlocBuilder<BookigsBloc, BookigsState>(
      builder: (context, state) {
        if (state is FetchLoadingState) {
          return const Center(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                CircularProgressIndicator(),
              ],
            ),
          );
        } else if (state is FetchLoadedState) {
          log("Booking loaded state");
          log(state.bookigTurfModels[0].turfName);
          if (state.bookigTurfModels.isEmpty) {
            return Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 300,
                child: Image.asset(
                  "asset/no-data.png",
                ),
              ),
            );
          }
          //Table row--------------
          return ListView.builder(
            shrinkWrap:
                true, // Important to avoid infinite height issue
            physics:
                NeverScrollableScrollPhysics(), // Disable internal scrolling
            itemCount: state.bookigTurfModels.length,
            itemBuilder: (context, index) {
              BookingTurfmodel data = state.bookigTurfModels[index];
              log(data.turfName);
    
              List<String> values = [
                "${index + 1}",
                data.userName,
                data.userPhone,
                data.turfName,
                data.bookingDate,
                "${data.bookingTime}*${data.slotDate}",
                data.price,
                data.paymentId
              ];
              return Table(
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: values
                        .map((value) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: TableCell(
                                      child:
                                      (value.contains("*"))?TextWidget(text: "${value.split("*")[0]}\n${value.split("*")[1]}"):
                                          TextWidget(text: value))),
                            ))
                        .toList(),
                  ),
                ],
              );
            },
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
