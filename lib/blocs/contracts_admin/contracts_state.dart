import 'package:contract_management/_all.dart';

enum ContractsStateStatus {
  init,
  loading,
  loaded,
  error,
  terminated,
}

class ContractsState {
  final ContractsStateStatus status;
  final List<ContractModel> contracts;
  final List<CreateContractModel> templates;
  final String? errorMessage;
  ContractsState({
    required this.status,
    required this.contracts,
    required this.templates,
    this.errorMessage,
  });

  ContractsState copyWith({
    ContractsStateStatus? status,
    List<ContractModel>? contracts,
    final List<CreateContractModel>? templates,
    String? errorMessage,
  }) =>
      ContractsState(
        status: status ?? this.status,
        contracts: contracts ?? this.contracts,
        templates: templates ?? this.templates,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
