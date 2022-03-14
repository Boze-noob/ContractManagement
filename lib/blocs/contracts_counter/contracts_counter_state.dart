import 'package:contract_management/_all.dart';

enum ContractsCounterStateStatus {
  init,
  loading,
  loaded,
  error,
}

class ContractsCounterState {
  final ContractsCounterStateStatus status;
  final ContractsCounterModel contractsCounterModel;
  final String? errorMessage;

  ContractsCounterState({
    required this.status,
    required this.contractsCounterModel,
    this.errorMessage,
  });

  ContractsCounterState copyWith({
    ContractsCounterStateStatus? status,
    ContractsCounterModel? contractsCounterModel,
    String? errorMessage,
  }) =>
      ContractsCounterState(
        status: status ?? this.status,
        contractsCounterModel: contractsCounterModel ?? this.contractsCounterModel,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
