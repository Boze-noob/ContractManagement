import 'package:contract_management/_all.dart';

enum CreateContractStateStatus {
  init,
  submitting,
  submitSuccessfully,
  error,
}

class CreateContractState {
  final CreateContractStateStatus status;
  final CreateContractModel createContractModel;
  final String? errorMessage;

  CreateContractState({
    required this.status,
    required this.createContractModel,
    this.errorMessage,
  });

  CreateContractState copyWith({
    CreateContractStateStatus? status,
    CreateContractModel? createContractModel,
    String? errorMessage,
  }) =>
      CreateContractState(
        status: status ?? this.status,
        createContractModel: createContractModel ?? this.createContractModel,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
