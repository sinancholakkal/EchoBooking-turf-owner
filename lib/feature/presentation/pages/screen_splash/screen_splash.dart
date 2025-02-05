
import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/screen_home.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_login/screen_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    context.read<AuthBlocBloc>().add(CheckLoginStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    return bloc.BlocListener<AuthBlocBloc, AuthBlocState>(
      listener: (context, state) {
       if(state is AuthSuccessState){
        Get.off(() => ScreenHome(), transition: Transition.cupertino);
       }else if(state is AuthUnSuccessState){
         Get.off(() => ScreenLogin(), transition: Transition.cupertino);
       }
      },
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: Center(
          child: Text(
            "Loading",
            style: TextStyle(color: kwhite, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
