import 'package:contract_management/_all.dart';

abstract class RevenueEvent {}

class RevenueInitEvent extends RevenueEvent {}

class RevenueLoadEvent extends RevenueEvent {}

class RevenueUpdateEvent extends RevenueEvent {
  final RevenueModel revenueModel;

  RevenueUpdateEvent({required this.revenueModel});
}
