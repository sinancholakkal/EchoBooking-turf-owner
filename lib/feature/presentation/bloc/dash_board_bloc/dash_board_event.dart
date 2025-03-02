part of 'dash_board_bloc.dart';

@immutable
sealed class DashBoardEvent {}

class FetchingDashBoardEvent extends DashBoardEvent{}