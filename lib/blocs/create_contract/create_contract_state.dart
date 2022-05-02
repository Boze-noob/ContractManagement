import 'package:contract_management/_all.dart';

enum CreateContractStateStatus {
  init,
  submitting,
  successfullySubmitted,
  error,
  updated,
}

class CreateContractState {
  final CreateContractStateStatus status;
  final CreateContractModel createContractModel;
  final String? previousContractName;
  final String? errorMessage;

  CreateContractState({
    required this.status,
    required this.createContractModel,
    this.previousContractName,
    this.errorMessage,
  });

  CreateContractState copyWith({
    CreateContractStateStatus? status,
    CreateContractModel? createContractModel,
    String? previousContractName,
    String? errorMessage,
  }) =>
      CreateContractState(
        status: status ?? this.status,
        createContractModel: createContractModel ?? this.createContractModel,
        previousContractName: previousContractName ?? this.previousContractName,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
