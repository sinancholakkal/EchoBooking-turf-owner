import 'package:echo_booking_owner/domain/repository/auth_service.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_login/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AuthService().signOut();
          Get.off(
            () => ScreenLogin(),
            //transition: Transition.cupertino,
          );
        },
        child: Icon(Icons.logout),
      ),
      body: Center(
        child: Image.asset(
          height: 60,
          "asset/loading.gif",
        ),
      ),
    );
  }
}
