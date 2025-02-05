part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {}

class AuthBlocInitial extends AuthBlocState {}

class AuthLoadingState extends AuthBlocState {}

// class AuthLoginedState extends AuthBlocState {}

// class AuthUnLoginedState extends AuthBlocState {}

class AuthErrorState extends AuthBlocState {
  final String errorMessage;
  AuthErrorState({required this.errorMessage});
}

class AuthSuccessState extends AuthBlocState {
  final user;
  final userMode;
  AuthSuccessState({this.user,this.userMode});
}
class AuthUnSuccessState extends AuthBlocState {}
