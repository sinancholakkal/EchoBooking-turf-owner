import 'package:echo_booking_owner/domain/models/turf_model.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_turf_update/screen_turf_update.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/showDiolog.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableRowWidget extends StatelessWidget {
  TableRowWidget({super.key, required this.data, required this.index});

  final dynamic data;
  int index;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(children: [
          //Item no----
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: TableCell(child: TextWidget(text: "${index + 1}"))),
          ),
          //Turf name-----
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: TableCell(child: TextWidget(text: data.turfName))),
          ),
          //Catogery--------
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: TableCell(child: TextWidget(text: data.catogery))),
          ),
          //Phone no----------
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Center(child: TableCell(child: TextWidget(text: data.phone))),
          ),
          //Price------------
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Center(child: TableCell(child: TextWidget(text: data.price))),
          ),
          //Review status--------
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: TableCell(
                  child: data.reviewStatus.startsWith("rejected")
                      ? ElevatedButton.icon(
                        icon: Icon(Icons.remove_red_eye),
                          onPressed: () {
                            alertBox(type: "hide cancel",context: context, onPressed: ()=>Navigator.of(context).pop(), title: "Status", content: data.reviewStatus.split("*")[1]);
                          }, label: Text("Rejected"))
                      : Text(
                          (data.reviewStatus == "true") ? "Live" : "Pending",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        )),
            ),
          ),
          //View button-----------
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: TableCell(
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(
                            () => ScreenTurfUpdate(turfModel: data),
                            transition: Transition.cupertino,
                            duration: Duration(milliseconds: 700),
                          );
                        },
                        child: Text("View")))),
          ),
        ])
      ],
    );
  }
}
