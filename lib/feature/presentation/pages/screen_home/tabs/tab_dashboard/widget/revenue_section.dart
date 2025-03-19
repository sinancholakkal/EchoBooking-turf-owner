import 'package:echo_booking_owner/feature/presentation/pages/screen_home/tabs/tab_dashboard/widget/date_range_revanue_section.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/tabs/tab_dashboard/widget/full_revanue_section.dart';
import 'package:flutter/material.dart';
class RevenueSection extends StatefulWidget {
  const RevenueSection({
    super.key,
  });
  @override
  State<RevenueSection> createState() => _RevenueSectionState();
}

class _RevenueSectionState extends State<RevenueSection> {
  late TextEditingController dateRangeController;
  @override
  void initState() {
    dateRangeController = TextEditingController(text: "Pick Date");
    super.initState();
  }

  @override
  void dispose() {
    dateRangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //Full revenue Section------------
        FullRevanueSection(),
        //Date pick range reveneu------------
        DateRangeRevanueSection(dateRangeController: dateRangeController)
      ],
    );
  }
}


