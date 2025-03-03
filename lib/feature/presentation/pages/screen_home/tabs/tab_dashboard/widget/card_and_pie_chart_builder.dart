
import 'package:echo_booking_owner/feature/presentation/bloc/dash_board_bloc/dash_board_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/tabs/tab_dashboard/widget/pie_chart_widget.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/tabs/tab_dashboard/widget/sorting_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardAndPieChartBuilder extends StatelessWidget {
  const CardAndPieChartBuilder({
    super.key,
    required this.selectedIndex,
  });

  final ValueNotifier<int> selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashBoardBloc, DashBoardState>(
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
              SortingCardWidget(selectedIndex: selectedIndex, entryList: entryList),
              //Display Pie chart------
              PieChartWidget(entryList: entryList)
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}



