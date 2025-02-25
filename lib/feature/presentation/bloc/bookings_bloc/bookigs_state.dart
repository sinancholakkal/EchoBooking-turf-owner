part of 'bookigs_bloc.dart';

@immutable
sealed class BookigsState {}

final class BookigsInitial extends BookigsState {}
class FetchLoadingState extends BookigsState{}
class FetchLoadedState extends BookigsState{
  List<BookingTurfmodel>bookigTurfModels;
  FetchLoadedState({required this.bookigTurfModels});
}