import 'package:echo_booking_owner/core/constent/text/text.dart';
import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:echo_booking_owner/domain/models/booking_turf_model.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SortingCardWidget extends StatelessWidget {
  const SortingCardWidget({
    super.key,
    required this.selectedIndex,
    required this.entryList,
  });

  final ValueNotifier<int> selectedIndex;
  final List<MapEntry<String, List<BookingTurfmodel>>> entryList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}