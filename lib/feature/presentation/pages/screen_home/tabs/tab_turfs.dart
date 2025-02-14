import 'dart:developer';

import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:echo_booking_owner/domain/models/turf_model.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/turf_managing/turf_managing_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/tabs/tab_turf_upload.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_turf_update/screen_turf_update.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';

class TabTurfs extends StatefulWidget {
  const TabTurfs({super.key});

  @override
  State<TabTurfs> createState() => _TabTurfsState();
}

class _TabTurfsState extends State<TabTurfs> {
  @override
  void initState() {
    context.read<TurfManagingBloc>().add(FetchTurfsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              Container(
                padding: EdgeInsets.only(top: 10),
                height: 40,
                color: Colors.blue,
                child: Table(
                  border: TableBorder.all(
                    color: kblue,
                    width: 3,
                    //style: BorderStyle.solid,
                  ),
                  children: [
                    TableRow(children: [
                      Column(
                        children: [
                          TextWidget(text: "No"),
                        ],
                      ),
                      Column(
                        children: [
                          TextWidget(text: "Name"),
                        ],
                      ),
                      Column(
                        children: [
                          TextWidget(text: "Category"),
                        ],
                      ),
                      Column(
                        children: [
                          TextWidget(text: "Phone"),
                        ],
                      ),
                      Column(
                        children: [
                          TextWidget(text: "Price"),
                        ],
                      ),
                      Column(
                        children: [
                          TextWidget(text: "Review"),
                        ],
                      ),
                      Column(
                        children: [
                          TextWidget(text: "Action"),
                        ],
                      ),
                    ]),
                  ],
                ),
              ),
              bloc.BlocBuilder<TurfManagingBloc, TurfManagingState>(
                builder: (context, state) {
                  if (state is FetchLoadingState) {
                    return SizedBox();
                  } else if (state is FetchLoadedState) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.listTurfModel.length,
                      itemBuilder: (context, index) {
                        TurfModel data = state.listTurfModel[index];
                        log(data.turfName);
                        return Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: TableCell(
                                        child:
                                            TextWidget(text: "${index + 1}"))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: TableCell(
                                        child:
                                            TextWidget(text: data.turfName))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: TableCell(
                                        child:
                                            TextWidget(text: data.catogery))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: TableCell(
                                        child: TextWidget(text: data.phone))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: TableCell(
                                        child: TextWidget(text: data.price))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: TableCell(
                                      child: Text(
                                    "Pendig",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: TableCell(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Get.to(
                                                () => ScreenTurfUpdate(
                                                    turfModel: data),
                                                transition:
                                                    Transition.cupertino,
                                                duration:
                                                    Duration(milliseconds: 700),
                                              );
                                            },
                                            child: Text("View")))),
                              ),
                            ])
                          ],
                        );
                      },
                    );
                  } else {
                    return SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
