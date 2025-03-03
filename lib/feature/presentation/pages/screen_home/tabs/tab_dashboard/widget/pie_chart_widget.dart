import 'package:echo_booking_owner/domain/models/booking_turf_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({
    super.key,
    required this.entryList,
  });

  final List<MapEntry<String, List<BookingTurfmodel>>> entryList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
