import 'package:contract_management/_all.dart';

enum ContractsStateStatus {
  init,
  loading,
  loaded,
  error,
}

class ContractsState {
  final ContractsStateStatus status;
  final List<ContractsModel> contracts;
  final String? errorMessage;
  ContractsState({
    required this.status,
    required this.contracts,
    this.errorMessage,
  });

  ContractsState copyWith({
    ContractsStateStatus? status,
    List<ContractsModel>? contracts,
    String? errorMessage,
  }) =>
      ContractsState(
        status: status ?? this.status,
        contracts: contracts ?? this.contracts,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
