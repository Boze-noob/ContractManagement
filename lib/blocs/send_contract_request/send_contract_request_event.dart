import 'package:contract_management/_all.dart';

abstract class SendContractRequestEvent {}

class SendContractRequestInitEvent extends SendContractRequestEvent {}

class SendContractRequestSubmitEvent extends SendContractRequestEvent {
  final ContractRequestModel contractRequestModel;

  SendContractRequestSubmitEvent({
    required this.contractRequestModel,
  });
}
