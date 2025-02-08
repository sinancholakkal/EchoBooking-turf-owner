part of 'time_slots_bloc.dart';

@immutable
sealed class TimeSlotsEvent {}

class AddDateInitialEvent extends TimeSlotsEvent{}

class AddDateEvent extends TimeSlotsEvent{}

class AddTimeSlotEvent extends TimeSlotsEvent{
  final String selectedKey;
  final BuildContext context;
  AddTimeSlotEvent({required this.selectedKey,required this.context});
}
class RemoveTimeSlotEvent extends TimeSlotsEvent{
  final String selectedKey;
  final int index;
  RemoveTimeSlotEvent({required this.selectedKey,required this.index});
}