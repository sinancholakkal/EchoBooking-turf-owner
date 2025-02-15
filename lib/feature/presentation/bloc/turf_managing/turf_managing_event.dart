part of 'turf_managing_bloc.dart';

@immutable
sealed class TurfManagingEvent {}

class AddTurfEvent extends TurfManagingEvent{
  final TurfModel turfModel;
  AddTurfEvent({required this.turfModel});
}
class FetchTurfsEvent extends TurfManagingEvent{}


class UpdateTurfEvent extends TurfManagingEvent{
  final TurfModel turfModel;
  UpdateTurfEvent({required this.turfModel}); 
}
class DeleteTurfEvent extends TurfManagingEvent{
  final String turfId;
  DeleteTurfEvent({required this.turfId});
}
