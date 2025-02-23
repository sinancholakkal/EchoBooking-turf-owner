import 'dart:developer';

import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:echo_booking_owner/domain/models/turf_model.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/turf_managing/turf_managing_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/tabs/tab_turf_upload.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/widgets/table_heading_widget.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/widgets/table_row_widget.dart';
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
              //Table heading----------------------
              TableHeadingWidget(),
              bloc.BlocBuilder<TurfManagingBloc, TurfManagingState>(
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
                    if (state.listTurfModel.isEmpty) {
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
                      shrinkWrap: true,
                      itemCount: state.listTurfModel.length,
                      itemBuilder: (context, index) {
                        TurfModel data = state.listTurfModel[index];
                        log(data.turfName);
                        return TableRowWidget(data: data,index: index,);
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

