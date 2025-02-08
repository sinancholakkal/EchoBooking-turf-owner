part of 'time_slots_bloc.dart';

@immutable
sealed class TimeSlotsState {}

final class TimeSlotsInitial extends TimeSlotsState {}

class SuccessState extends TimeSlotsState{
  Map<String, List<Map<String, dynamic>>> timeSlots;
  SuccessState({required this.timeSlots});
}
