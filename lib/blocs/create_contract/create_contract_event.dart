import 'package:contract_management/_all.dart';

abstract class CreateContractEvent {}

class CreateContractInitEvent extends CreateContractEvent {}

class CreateContractSetForUpdateEvent extends CreateContractEvent {
  final CreateContractModel createContractModel;

  CreateContractSetForUpdateEvent({required this.createContractModel});
}

class CreateContractUpdateEvent extends CreateContractEvent {
  final CreateContractModel createContractModel;
  CreateContractUpdateEvent({
    required this.createContractModel,
  });
}

class CreateContractSubmitEvent extends CreateContractEvent {}

class CreateContractDeleteEvent extends CreateContractEvent {
  final String contractName;

  CreateContractDeleteEvent({required this.contractName});
}
