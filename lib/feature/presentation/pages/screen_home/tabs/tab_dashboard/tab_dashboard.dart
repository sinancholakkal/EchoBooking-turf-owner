import 'package:echo_booking_owner/core/constent/text/text.dart';
import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/dash_board_bloc/dash_board_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/tabs/tab_dashboard/widget/card_and_pie_chart_builder.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/tabs/tab_dashboard/widget/revenue_section.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/tabs/tab_dashboard/widget/table_row_part_widget.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/widgets/table_heading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabDashboard extends StatefulWidget {
  const TabDashboard({super.key});
  @override
  State<TabDashboard> createState() => _TabDashboardState();
}

class _TabDashboardState extends State<TabDashboard> {
  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  @override
  void initState() {
    context.read<DashBoardBloc>().add(FetchingDashBoardEvent());
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
          color: tabBackgroundColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Card and pie chart bloc builder--------
              CardAndPieChartBuilder(selectedIndex: selectedIndex),
              //Revanue section----------
              RevenueSection(),
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

