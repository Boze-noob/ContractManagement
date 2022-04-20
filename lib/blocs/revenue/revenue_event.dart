import 'package:contract_management/_all.dart';

abstract class RevenueEvent {}

class RevenueInitEvent extends RevenueEvent {}

class RevenueLoadEvent extends RevenueEvent {}

class RevenueProfitEvent extends RevenueEvent {
  final int profit;

  RevenueProfitEvent({required this.profit});
}

class RevenueUpdateModelEvent extends RevenueEvent {
  final RevenueModel revenueModel;

  RevenueUpdateModelEvent({required this.revenueModel});
}
