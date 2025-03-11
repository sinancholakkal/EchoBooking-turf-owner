import 'package:echo_booking_owner/feature/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/bookings_bloc/bookigs_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/dash_board_bloc/dash_board_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/turf_managing/turf_managing_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/turf_upload_tab/turf_upload_tab_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_splash/screen_splash.dart';
import 'package:echo_booking_owner/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nominatim_geocoding/nominatim_geocoding.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  ); 
  await NominatimGeocoding.init(reqCacheNum: 20);
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
        BlocProvider(
          create: (context) => TurfUploadTabBloc(),
        ),
        BlocProvider(
          create: (context) => TurfManagingBloc(),
        ),
        BlocProvider(
          create: (context) => BookigsBloc(),
        ),
        BlocProvider(
          create: (context) => DashBoardBloc(),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScreenSplash(),
      )
    );
  }
}