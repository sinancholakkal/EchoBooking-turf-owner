part of 'turf_upload_tab_bloc.dart';

@immutable
sealed class TurfUploadTabEvent {}

class AddDateInitialEvent extends TurfUploadTabEvent{}

class AddDateEvent extends TurfUploadTabEvent{
 final int index;
 final BuildContext context;
 AddDateEvent({required this.index,required this.context});
}

class AddTimeSlotEvent extends TurfUploadTabEvent{
  final String selectedKey;
  final BuildContext context;
   final int index;
  AddTimeSlotEvent({required this.selectedKey,required this.context,required this.index});
}
class RemoveTimeSlotEvent extends TurfUploadTabEvent{
  final String selectedKey;
  final int index;
  RemoveTimeSlotEvent({required this.selectedKey,required this.index});
}
class DateSelectIdxEvent extends TurfUploadTabEvent{
  int selectIndex;
  DateSelectIdxEvent({required this.selectIndex});
}
class UpdateInitialDateEvent extends TurfUploadTabEvent{
  final Map<String,List<Map<String,dynamic>>> timeSlots;
  UpdateInitialDateEvent({required this.timeSlots});
}
class ImagePickerEvent extends TurfUploadTabEvent{
}
class ResetStateEvent extends TurfUploadTabEvent{}
