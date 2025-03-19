part of 'date_range_revenue_bloc.dart';

@immutable
sealed class DateRangeRevenueState {}

final class DateRangeRevenueInitial extends DateRangeRevenueState {}

class DateRangeRevenueLoading extends DateRangeRevenueState{}

class DateRangeRevenueLoaded extends DateRangeRevenueState{
  String fromDate;
  String toDate;
  String revenueAmount;
  DateRangeRevenueLoaded({required this.fromDate,required this.toDate,required this.revenueAmount});
}
