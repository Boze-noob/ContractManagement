import 'package:contract_management/_all.dart';

enum MyContractStateStatus {
  init,
  loading,
  loaded,
  contractAccepted,
  error,
}

class MyContractState {
  final MyContractStateStatus status;
  final CreateContractModel? model;
  final String? errorMessage;

  MyContractState({
    required this.status,
    this.model,
    this.errorMessage,
  });

  MyContractState copyWith({
    MyContractStateStatus? status,
    Optional<CreateContractModel?>? model,
    String? errorMessage,
  }) =>
      MyContractState(
        status: status ?? this.status,
        model: model != null ? model.value : this.model,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
