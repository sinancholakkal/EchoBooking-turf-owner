import 'package:echo_booking_owner/core/constent/text/text.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/dash_board_bloc/dash_board_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FullRevanueSection extends StatelessWidget {
  const FullRevanueSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashBoardBloc, DashBoardState>(
      builder: (context, state) {
        if (state is FetchLoadedState) {
          var entryList = state.bookigTurfModels.entries.toList();
    
          return Container(
            margin: EdgeInsets.only(bottom: 20),
            // height: 60,
            width: 500,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.lightBlue),
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Divider();
                },
                separatorBuilder: (context, index) {
                  var values = entryList[index].value;
                  double price = 0.0;
                  for (var data in values) {
                    price += double.parse(data.price);
                  }
                  return ListTile(
                    title: TextWidget(text: dashBoardCardText[index]),
                    trailing: TextWidget(
                      text: "₹${price.toString()}",
                      size: 16,
                    ),
                  );
                },
                itemCount: dashBoardCardText.length + 1),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}