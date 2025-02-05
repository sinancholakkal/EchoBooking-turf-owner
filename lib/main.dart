import 'package:echo_booking_owner/feature/presentation/pages/screen_login/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: ScreenLogin(),
    );
  }
}