import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:echo_booking_owner/core/constent/text/text.dart';
import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:echo_booking_owner/domain/repository/auth_service.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/tabs/profile.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/tabs/tab_bookings.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/tabs/tab_dashboard.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/tabs/tab_turf_upload.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/tabs/tab_turfs.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_login/screen_login.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/heading_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  late List<SideMenuItem> items;
  @override
  void initState() {
    items = [
      sideMenuItem(title: "Dashboard", icon: Icons.home),
      sideMenuItem(title: "Turfs", icon: Icons.sports_football),
      sideMenuItem(title: "Bookings", icon: Icons.book),
      sideMenuItem(title: "Turf upload", icon: Icons.upload_file),
      sideMenuItem(title: "Profile", icon: Icons.account_circle),
    ];
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  SideMenuItem sideMenuItem({required String title, required IconData icon}) {
    return SideMenuItem(
        title: title,
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: Icon(icon));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AuthService().signOut();
          Get.offAll(
            () => ScreenLogin(),
            //transition: Transition.cupertino,
          );
        },
        child: Icon(Icons.logout),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 24, 51),
        title: HeadingText(text: appTitle),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            style: SideMenuStyle(
                selectedColor: Colors.blue,
                selectedTitleTextStyle: TextStyle(color: kwhite),
                selectedIconColor: kwhite,
                unselectedTitleTextStyle: TextStyle(color: Colors.white60),
                unselectedIconColor: Colors.white60,
                backgroundColor: const Color.fromARGB(255, 23, 24, 51)),
            items: items,
            controller: sideMenu,
            title: Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  "asset/beckham-david-male-males-wallpaper-preview-removebg-preview.png",
                ),
              ),
            ),
            onDisplayModeChanged: (mode) {
              print(mode);
            },
          ),
          Expanded(
              child: PageView(
            controller: pageController,
            children: [
              TabDashboard(),
              TabTurfs(),
              TabBookings(),
              TabTurfUpload(),
              TabProfile()
            ],
          ))
        ],
      ),
    );
  }
}
