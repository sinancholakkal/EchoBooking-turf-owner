import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TableHeadingWidget extends StatelessWidget {
  TableHeadingWidget({
    super.key,
    required this.headigs,
  });
  List<String> headigs;
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
          TableRow(
            children: List.generate(headigs.length, (index){
              return Column(
                children: [
                  TextWidget(text: headigs[index]),
                ],
              );
            })
          ),
        ],
      ),
    );
  }
}
