import 'package:contract_management/_all.dart';

enum CreateContractStateStatus {
  init,
  submitting,
  submitSuccessfully,
  error,
  updated,
}

class CreateContractState {
  final CreateContractStateStatus status;
  final CreateContractModel createContractModel;
  final List<bool> isChecked;
  final String? errorMessage;

  CreateContractState({
    required this.status,
    required this.createContractModel,
    required this.isChecked,
    this.errorMessage,
  });

  CreateContractState copyWith({
    CreateContractStateStatus? status,
    CreateContractModel? createContractModel,
    List<bool>? isChecked,
    String? errorMessage,
  }) =>
      CreateContractState(
        status: status ?? this.status,
        createContractModel: createContractModel ?? this.createContractModel,
        isChecked: isChecked ?? this.isChecked,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
