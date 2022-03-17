import 'package:contract_management/_all.dart';

enum ContractsTemplateStateStatus {
  initializing,
  init,
  error,
}

class ContractsTemplateListState {
  final ContractsTemplateStateStatus status;
  final List<CreateContractModel> createContractModel;
  final String? errorMessage;

  ContractsTemplateListState({required this.status, required this.createContractModel, this.errorMessage});

  ContractsTemplateListState copyWith({
    ContractsTemplateStateStatus? status,
    List<CreateContractModel>? createContractModel,
    String? errorMessage,
  }) =>
      ContractsTemplateListState(
        status: status ?? this.status,
        createContractModel: createContractModel ?? this.createContractModel,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
