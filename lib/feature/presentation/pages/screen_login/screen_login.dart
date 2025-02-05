import 'package:echo_booking_owner/core/constent/size/size.dart';
import 'package:echo_booking_owner/core/constent/text/text.dart';
import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_sign_up/screen_sign_up.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/heading_text.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/rich_text_widget.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: HeadingText(
          text: appTitle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadingText(
                  text: loginTitle,
                ),
                height30,
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //E-mail textform field
                Text(
                  textEmail,
                  style: TextStyle(
                      color: kwhite, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                height10,
                TextFormFieldWidget(),
                    
                //password-----
                height20,
                Text(
                  textPassword,
                  style: TextStyle(
                      color: kwhite, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                height10,
                TextFormFieldWidget(),
                    ],
                  ),
                ),
                height20,
                    
                //Login button------------
                      Center(
                        child: CustomButton(
                          onTap: () {
                            // if (_formKey.currentState!.validate()) {
                            //   print(" Validated--------------------");
                            //   context.read<AuthBlocBloc>().add(SignInEvent(
                            //       email: _email.text,
                            //       password: _password.text,
                            //       context: context));
                            //   // _signIn(context);
                            // } else {
                            //   print("Not Validated--------------------");
                            // }
                          },
                          screenWidth: screenWidth,
                          text: textLoginButton,
                        ),
                      ),
                      height10,
                       //Rich text --------------------------------
                  RichTextWidget(
                    text: "Don’t have an account?",
                    
                    eventText: "Sign up",
                    onTap: () {
                      Get.off(ScreenSignUp(),
                          transition: Transition.cupertino);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
