  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Future<dynamic> showDiolog({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Ok")),
            ],
          );
        });
  }



   Future<dynamic> alertBox({
    required BuildContext context,
    required Function() onPressed,
        required String title,
    required String content,
    String? type,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
           type==null? TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("cancel")):
            TextButton(onPressed: onPressed, child: Text("Ok"))
          ],
        );
      },
    );
  }