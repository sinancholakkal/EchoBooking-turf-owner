import 'package:echo_booking_owner/core/constent/size/size.dart';
import 'package:echo_booking_owner/core/constent/text/text.dart';
import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:echo_booking_owner/core/until/validation.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/screen_home.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_sign_up/screen_sign_up.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/heading_text.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/loading_widget.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/rich_text_widget.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/showDiolog.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  late TextEditingController _email;
  late TextEditingController _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return bloc.BlocListener<AuthBlocBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            loadingWidget(context);
          } else if (state is AuthSuccessState) {
            Get.off(
              () => ScreenHome(),
              // transition: Transition.cupertino,
              duration: Duration(milliseconds: 1300),
            );
          } else if (state is AuthErrorState) {
            if (state.errorMessage == "invalid-credential") {
              Navigator.pop(context);
              showDiolog(
                context: context,
                title: "Incorrect Password",
                content:
                    "The password you entered is incorrect.\nPlease try again.",
              );
            }
          }
        },
        child: Scaffold(
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
                child: Form(
                  key: _formKey,
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
                                  color: kwhite,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            height10,
                            TextFormFieldWidget(
                              validator: (value) {
                                return Validation.emailValidation(value);
                              },
                              controller: _email,
                            ),

                            //password-----
                            height20,
                            Text(
                              textPassword,
                              style: TextStyle(
                                  color: kwhite,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            height10,
                            TextFormFieldWidget(
                              validator: (value) {
                                return Validation.passWordValidation(value);
                              },
                              controller: _password,
                            ),
                          ],
                        ),
                      ),
                      height20,

                      //Login button------------
                      Center(
                        child: CustomButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              print(" Validated--------------------");
                              context.read<AuthBlocBloc>().add(SignInEvent(
                                  email: _email.text,
                                  password: _password.text,
                                  context: context));
                              // _signIn(context);
                            } else {
                              print("Not Validated--------------------");
                            }
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
                          Get.off(
                            ScreenSignUp(),
                            // transition: Transition.cupertino,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
