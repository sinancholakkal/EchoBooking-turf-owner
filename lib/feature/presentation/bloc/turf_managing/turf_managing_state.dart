part of 'turf_managing_bloc.dart';

@immutable
sealed class TurfManagingState {}

final class TurfManagingInitial extends TurfManagingState {}

class AddLoadingState extends TurfManagingState{}

class AddSuccessState extends TurfManagingState{}

class FetchLoadingState extends TurfManagingState{}

class FetchLoadedState extends TurfManagingState{
  final List<TurfModel> listTurfModel;
  FetchLoadedState({required this.listTurfModel});
}

class UpdateLoadingState extends TurfManagingState{}

class UpdateLoadedState extends TurfManagingState{}

class DeleteLoadingState extends TurfManagingState{}

class DeleteLoadedState extends TurfManagingState{}