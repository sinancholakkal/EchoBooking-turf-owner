
import 'dart:developer';

import 'package:echo_booking_owner/domain/models/booking_turf_model.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/dash_board_bloc/dash_board_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TableRowPartWidget extends StatelessWidget {
  const TableRowPartWidget({
    super.key,
    required this.selectedIndex,
  });

  final ValueNotifier<int> selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedIndex,
      builder: (context, selected, child) {
        return BlocBuilder<DashBoardBloc, DashBoardState>(
          builder: (context, state) {
            if (state is FetchLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FetchLoadedState) {
              var entryList = state.bookigTurfModels.entries.toList();
              List<BookingTurfmodel> turfs = entryList[selected].value;
              log(turfs.length.toString());
              if (turfs.isEmpty) {
                return Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 300,
                child: Image.asset(
                  "asset/no-data.png",
                ),
              ),
            );
              } else {
                return ListView.builder(
                  shrinkWrap: true, // Important to avoid infinite height issue
                  physics:
                      NeverScrollableScrollPhysics(), // Disable internal scrolling
                  itemCount: turfs.length,
                  itemBuilder: (context, index) {
                    BookingTurfmodel data = turfs[index];
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
                                            child: (value.contains("*"))
                                                ? TextWidget(
                                                    text:
                                                        "${value.split("*")[0]}\n${value.split("*")[1]}")
                                                : TextWidget(text: value))),
                                  ))
                              .toList(),
                        ),
                      ],
                    );
                  },
                );
              }
            } else {
              return SizedBox();
            }
          },
        );
      },
    );
  }
}
