import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void fluttertoast({required String msg}){
  Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
        
    );
}