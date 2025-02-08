import 'dart:developer';

import 'package:echo_booking_owner/core/constent/size/size.dart';
import 'package:echo_booking_owner/core/constent/text/text.dart';
import 'package:echo_booking_owner/core/theme/colors.dart';
import 'package:echo_booking_owner/core/until/validation.dart';
import 'package:echo_booking_owner/domain/models/user_model.dart';
import 'package:echo_booking_owner/domain/repository/user_service.dart';
import 'package:echo_booking_owner/feature/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/screen_home.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_login/screen_login.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/heading_text.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/loading_widget.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/rich_text_widget.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/showDiolog.dart';
import 'package:echo_booking_owner/feature/presentation/widgets/text_form_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
    late TextEditingController _name;
  late TextEditingController _phone;
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _conformPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final _auth = AuthService();

  @override
  void initState() {
    _name = TextEditingController();
    _phone = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _conformPassword = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return bloc.BlocListener<AuthBlocBloc, AuthBlocState>(
        listener: (context, state)async {
          if (state is AuthLoadingState) {
            loadingWidget(context);
          } else if (state is AuthSuccessState) {
          await UserService().userStore(state.userMode);
            Get.off(
              () => ScreenHome(
                  // user: state.user,
                  ),
             // transition: transition.cupertino,
              duration: Duration(milliseconds: 1300),
            );
          } else if (state is AuthErrorState) {
            if (state.errorMessage == "email-already-in-use") {
              showDiolog(
                context: context,
                title: "Email Already in Use",
                content:
                    "This email is already registered. Please use a different email or sign in.",
              );
            }
          }
        },
        child: Scaffold(
          backgroundColor: backGroundColor,
          appBar: AppBar(
            backgroundColor: backGroundColor,
            title: HeadingText(text: appTitle),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: SizedBox(
                // width: screenWidth,
                // height: screenHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    height30,
                    Column(
                      //  mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        HeadingText(
                          text: "Create Account Now!",
                        ),
                        SizedBox(
                          height: screenHeight * 0.06,
                        ),
                        //name field------
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Text(
                          textName,
                          style: TextStyle(
                              color: kwhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        TextFormFieldWidget(
                          validator: (value) {
                            return Validation.nameValidate(value: value);
                          },
                          controller: _name,
                        ),
                        //phone number ----------------
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Text(
                          textPhone,
                          style: TextStyle(
                              color: kwhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        TextFormFieldWidget(
                          validator: (value) {
                            return Validation.phoneNumberValidate(value: value);
                          },
                          controller: _phone,
                        ),

                        //E-mail----------------
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Text(
                          textEmail,
                          style: TextStyle(
                              color: kwhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        TextFormFieldWidget(
                          validator: (value) {
                            return Validation.emailValidation(value);
                          },
                          controller: _email,
                        ),

                        //password-------------
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Text(
                          textPassword,
                          style: TextStyle(
                              color: kwhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        TextFormFieldWidget(
                          validator: (value) {
                            return Validation.passWordValidation(value);
                          },
                          controller: _password,
                        ),

                        //Conform password---------------
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Text(
                          conformPassword,
                          style: TextStyle(
                              color: kwhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        TextFormFieldWidget(
                          validator: (value) {
                            return Validation.conformPasswordValidation(
                                value: value,
                                password: _password.text,
                                conformPassword: _conformPassword.text);
                          },
                          controller: _conformPassword,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    //Signup button------------
                    Center(
                      child: CustomButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            print(" Validated--------------------");
                            UserModel userModel =UserModel(
                              name: _name.text,
                              phone: _phone.text,
                              email: _email.text,
                              password: _password.text
                            );
                            context.read<AuthBlocBloc>().add(SignUpEvent(
                                userModel: userModel,
                                context: context));
                          } else {
                            print("Not Validated--------------------");
                          }
                        },
                        screenWidth: screenWidth,
                        text: textSignUpButton,
                      ),
                    ),
                    SizedBox(
                      height: 08,
                    ),
                    //Have already account----------------
                    Center(
                      child: RichTextWidget(
                        text: "Have an account already?",
                        eventText: "Login",
                        onTap: () {
                          Get.off(ScreenLogin(),
                              //transition: Transition.cupertino
                              );
                        },
                      ),
                    ),
                    height20
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
