part of 'turf_upload_tab_bloc.dart';

@immutable
sealed class TurfUploadTabState {}

final class TimeSlotsInitial extends TurfUploadTabState {}

class SuccessState extends TurfUploadTabState{
  Map<String, List<Map<String, dynamic>>> timeSlots;
  int selectIndex;
  SuccessState({required this.timeSlots,required this.selectIndex});
}
class ImagePickerSuccessState extends TurfUploadTabState{
    Uint8List image;
  ImagePickerSuccessState({required this.image});
}
