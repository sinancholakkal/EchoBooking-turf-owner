
import 'dart:developer';

import 'package:echo_booking_owner/core/constent/size/size.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/date_range_revenue/date_range_revenue_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/widgets/text_form_widget.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateRangeRevanueSection extends StatelessWidget {
  const DateRangeRevanueSection({
    super.key,
    required this.dateRangeController,
  });

  final TextEditingController dateRangeController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 20,
      children: [
        BlocConsumer<DateRangeRevenueBloc, DateRangeRevenueState>(
            listener: (context, state) {
          if (state is DateRangeRevenueLoaded) {
            log(state.fromDate);
            dateRangeController.text = "${state.fromDate} to ${state.toDate}";
          }
        }, builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 10,
            children: [
              TextFormWidget(
                width: 400,
                readOnly: true,
                controller: dateRangeController,
              ),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<DateRangeRevenueBloc>()
                        .add(DateRangeRevenueFetchEvent(context: context));
                  },
                  child: Text("Date Range Pick"))
            ],
          );
        }),
        BlocBuilder<DateRangeRevenueBloc, DateRangeRevenueState>(
          builder: (context, state) {
            if(state is DateRangeRevenueLoading){
              return Column(
                children: [
                  height30,
                  CircularProgressIndicator(),
                ],
              );
            }
           else if (state is DateRangeRevenueLoaded) {
              log("DateRangeRevenueFetchEvent----------");
              return Container(
                padding: EdgeInsets.all(12),
                width: 400,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.deepOrange
                  )
                ),
                child: Center( 
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(text: "Date",size: 16,fontWeight: FontWeight.bold,),
                          TextWidget(text: "Revenue",size: 16,fontWeight: FontWeight.bold,)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(text: "${state.fromDate} to ${state.toDate}",size: 15,color: Colors.white70,),
                          TextWidget(text: "₹${state.revenueAmount}",size: 15,color: Colors.white70,)
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else {
              log("revenue container instead of sizedbox");
              return SizedBox();
            }
          },
        )
      ],
    );
  }
}
