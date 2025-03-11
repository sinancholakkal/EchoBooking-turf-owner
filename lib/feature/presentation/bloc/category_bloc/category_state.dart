part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}
class CategoryLoadedState extends CategoryState{
  List<String>caregorys;
  CategoryLoadedState({required this.caregorys});
}