part of 'date_range_revenue_bloc.dart';

@immutable
sealed class DateRangeRevenueEvent {}
class DateRangeRevenueFetchEvent extends DateRangeRevenueEvent{
  final BuildContext context;
  DateRangeRevenueFetchEvent({required this.context});
}