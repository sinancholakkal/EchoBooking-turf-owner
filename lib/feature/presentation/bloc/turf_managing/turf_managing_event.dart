part of 'turf_managing_bloc.dart';

@immutable
sealed class TurfManagingEvent {}

class AddTurfEvent extends TurfManagingEvent{
  final TurfModel turfModel;
  AddTurfEvent({required this.turfModel});
}
