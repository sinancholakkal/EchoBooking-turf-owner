part of 'turf_managing_bloc.dart';

@immutable
sealed class TurfManagingState {}

final class TurfManagingInitial extends TurfManagingState {}

class TurfLoadingState extends TurfManagingState{}

class TurfLoadedState extends TurfManagingState{}
