import 'package:contract_management/_all.dart';

abstract class ContractsEvent {}

class ContractsInitEvent extends ContractsEvent {}

class ContractsLoadEvent extends ContractsEvent {
  final ContractsType contractsType;

  ContractsLoadEvent({required this.contractsType});
}
