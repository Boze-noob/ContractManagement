import 'package:contract_management/_all.dart';

enum MyContractStateStatus {
  init,
  loading,
  loaded,
  error,
}

class MyContractState {
  final MyContractStateStatus status;
  final CreateContractModel model;
  final String? errorMessage;

  MyContractState({
    required this.status,
    required this.model,
    this.errorMessage,
  });

  MyContractState copyWith({
    MyContractStateStatus? status,
    CreateContractModel? model,
    String? errorMessage,
  }) =>
      MyContractState(
        status: status ?? this.status,
        model: model ?? this.model,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
