import 'dart:developer';

import 'package:echo_booking_owner/core/constent/text/text.dart';
import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:echo_booking_owner/domain/models/booking_turf_model.dart';
import 'package:echo_booking_owner/domain/repository/dash_board_service.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/dash_board_bloc/dash_board_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/widgets/table_heading_widget.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/text_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabDashboard extends StatefulWidget {
  const TabDashboard({super.key});

  @override
  State<TabDashboard> createState() => _TabDashboardState();
}

class _TabDashboardState extends State<TabDashboard> {
  

  List<int> values = [0, 1, 2, 3, 4];

  ValueNotifier<int> selectedIndex = ValueNotifier(0);

  @override
  void initState() {
    context.read<DashBoardBloc>().add(FetchingDashBoardEvent());
    //DashBoardService().fetchDashBoard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: tabBackgroundColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<DashBoardBloc, DashBoardState>(
                builder: (context, state) {
                  if (state is FetchLoadingState) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                          height: 600,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                            
                          ),
                          CircularProgressIndicator()
                        ],
                      ),
                    );
                  } else if (state is FetchLoadedState) {
                    var entryList = state.bookigTurfModels.entries.toList();
                    return Row(
                      children: [
                        //Display the cards-----
                        SizedBox(
                          width: 600,
                          height: 600,
                          child: Wrap(
                            children: List.generate(5, (index) {
                              return ValueListenableBuilder(
                                valueListenable: selectedIndex,
                                builder: (context, selected, child) {
                                  return GestureDetector(
                                    onTap: () {
                                      selectedIndex.value = index;
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(20),
                                      padding: EdgeInsets.all(20),
                                      width: selected == index ? 220 : 210,
                                      height: selected == index ? 160 : 150,
                                      decoration: BoxDecoration(
                                          color: dashBoardColors[index],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: selected == index
                                              ? [
                                                  BoxShadow(
                                                      color: Colors.brown,
                                                      blurRadius: 20,
                                                      spreadRadius: 10)
                                                ]
                                              : []),
                                      child: Column(
                                        spacing: 20,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextWidget(
                                            text: dashBoardCardText[index],
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            size: 18,
                                          ),
                                          TextWidget(
                                            text: entryList[index].value.isEmpty
                                                ? "0"
                                                : entryList[index]
                                                    .value
                                                    .length
                                                    .toString(),
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            size: 18,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                          ),
                        ),
                        //Display the chart------
                        Expanded(
                          child: SizedBox(
                            height: 400,
                            child: Center(
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  child: PieChart(
                                  
                                    PieChartData(
                                      centerSpaceRadius: 100,
                                      sections: [
                                    PieChartSectionData(
                                        value: entryList[0].value.isEmpty
                                            ? 0
                                            : entryList[0]
                                                .value
                                                .length
                                                .toDouble(),
                                        color: Colors.redAccent,),
                                    PieChartSectionData(
                                        value: entryList[1].value.isEmpty
                                            ? 0
                                            : entryList[1]
                                                .value
                                                .length
                                                .toDouble(),
                                        color: Colors.orangeAccent),
                                    PieChartSectionData(
                                      value: entryList[2].value.isEmpty
                                          ? 0
                                          : entryList[2]
                                              .value
                                              .length
                                              .toDouble(),
                                      color: Colors.blueAccent,
                                    ),
                                    PieChartSectionData(
                                        value: entryList[3].value.isEmpty
                                            ? 0
                                            : entryList[3]
                                                .value
                                                .length
                                                .toDouble(),
                                        color: Colors.greenAccent),
                                    PieChartSectionData(
                                        value: entryList[4].value.isEmpty
                                            ? 0
                                            : entryList[4]
                                                .value
                                                .length
                                                .toDouble(),
                                        color: Colors.pinkAccent)
                                  ])),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              //Table heading----
              TableHeadingWidget(headigs: headigsOfbookigs),
              //Table rows---------
              TableRowPartWidget(selectedIndex: selectedIndex)
            ],
          ),
        ),
      ),
    );
  }
}

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
