import 'package:contract_management/_all.dart';

enum GetContractRequestStateStatus {
  init,
  loading,
  loaded,
  error,
}

class GetContractRequestState {
  final GetContractRequestStateStatus status;
  final List<ContractRequestModel> model;
  final String? errorMessage;

  GetContractRequestState({
    required this.status,
    required this.model,
    this.errorMessage,
  });

  GetContractRequestState copyWith({
    GetContractRequestStateStatus? status,
    List<ContractRequestModel>? model,
    String? errorMessage,
  }) =>
      GetContractRequestState(
        status: status ?? this.status,
        model: model ?? this.model,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
