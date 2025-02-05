import 'package:echo_booking_owner/feature/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_login/screen_login.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_splash/screen_splash.dart';
import 'package:echo_booking_owner/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  ); 
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBlocBloc(),
        ),
        // BlocProvider(
        //   create: (context) => SubjectBloc(),
        // ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScreenSplash(),
      )
    );
  }
}