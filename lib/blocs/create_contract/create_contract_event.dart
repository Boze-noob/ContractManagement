import 'package:contract_management/_all.dart';

abstract class CreateContractEvent {}

class CreateContractInitEvent extends CreateContractEvent {}

class CreateContractUpdateEvent extends CreateContractEvent {
  final CreateContractModel createContractModel;
  CreateContractUpdateEvent({
    required this.createContractModel,
  });
}

class CreateContractSubmitEvent extends CreateContractEvent {}
