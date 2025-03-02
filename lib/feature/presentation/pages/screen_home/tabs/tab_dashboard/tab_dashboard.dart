import 'package:echo_booking_owner/core/constent/text/text.dart';
import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:echo_booking_owner/domain/repository/dash_board_service.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/widgets/table_heading_widget.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TabDashboard extends StatefulWidget {
  TabDashboard({super.key});

  @override
  State<TabDashboard> createState() => _TabDashboardState();
}

class _TabDashboardState extends State<TabDashboard> {
  List<Color> color = [
    Colors.redAccent,
    Colors.orangeAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.pinkAccent
  ];

  List<int> values = [0, 1, 2, 3, 4, 5];

  ValueNotifier<int>selectedIndex = ValueNotifier(0);

@override
  void initState() {
    DashBoardService().fetchDashBoard();
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
              SizedBox(
                width: 600,
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
                          width:selected==index?220: 210,
                          height:selected==index?160: 150,
                          decoration: BoxDecoration(
                            color: color[index],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: selected==index?[
                              BoxShadow(color: Colors.brown,blurRadius: 20,spreadRadius: 10)
                            ]:[]
                          ),
                          child: Column(
                            spacing: 20,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextWidget(
                                text: "Tootal Bookigs",
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                size: 18,
                              ),
                              TextWidget(
                                text: "5",
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
              TableHeadingWidget(headigs: headigsOfbookigs),
              ValueListenableBuilder(
                valueListenable: selectedIndex,
                builder: (context, value, child) {
                  return TextWidget(
                  text: values[value].toString(),
                  color: kwhite,
                );
                },
                
              )
              //     ListView.builder(
              //   shrinkWrap:
              //       true, // Important to avoid infinite height issue
              //   physics:
              //       NeverScrollableScrollPhysics(), // Disable internal scrolling
              //   itemCount: state.bookigTurfModels.length,
              //   itemBuilder: (context, index) {
              //     BookingTurfmodel data = state.bookigTurfModels[index];
              //     log(data.turfName);

              //     List<String> values = [
              //       "${index + 1}",
              //       data.userName,
              //       data.userPhone,
              //       data.turfName,
              //       data.bookingDate,
              //       "${data.bookingTime}*${data.slotDate}",
              //       data.price,
              //       data.paymentId
              //     ];
              //     return Table(
              //       border: TableBorder.all(),
              //       children: [
              //         TableRow(
              //           children: values
              //               .map((value) => Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Center(
              //                         child: TableCell(
              //                             child:
              //                             (value.contains("*"))?TextWidget(text: "${value.split("*")[0]}\n${value.split("*")[1]}"):
              //                                 TextWidget(text: value))),
              //                   ))
              //               .toList(),
              //         ),
              //       ],
              //     );
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
