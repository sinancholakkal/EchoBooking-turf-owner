import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TableHeadingWidget extends StatelessWidget {
  const TableHeadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

