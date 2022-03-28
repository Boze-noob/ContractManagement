import 'package:contract_management/_all.dart';

abstract class ContractsEvent {}

class ContractsInitEvent extends ContractsEvent {}

class ContractsLoadEvent extends ContractsEvent {
  final ContractType contractType;

  ContractsLoadEvent({required this.contractType});
}

class ContractsCheckDateEvent extends ContractsEvent {}

class ContractsTerminateEvent extends ContractsEvent {
  final ContractModel contractModel;
  final String userRoleType;

  ContractsTerminateEvent({required this.contractModel, required this.userRoleType});
}
