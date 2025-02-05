part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocEvent {}

class CheckLoginStatusEvent extends AuthBlocEvent{}

class SignUpEvent extends AuthBlocEvent{
  final UserModel userModel;

  final BuildContext context;
  SignUpEvent({required this.userModel,required this.context});
}

class SignInEvent extends AuthBlocEvent{
  final String email;
  final String password;
  final BuildContext context;
  SignInEvent({required this.email,required this.password,required this.context});
}

class SignOutEvent extends AuthBlocEvent{}