part of 'dash_board_bloc.dart';

@immutable
sealed class DashBoardState {}

final class DashBoardInitial extends DashBoardState {}
class FetchLoadingState extends DashBoardState{}
class FetchLoadedState extends DashBoardState{
  Map<String,List<BookingTurfmodel>>bookigTurfModels;
  FetchLoadedState({required this.bookigTurfModels});
}