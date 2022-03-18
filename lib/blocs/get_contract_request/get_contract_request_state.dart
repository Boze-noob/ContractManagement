import 'package:contract_management/_all.dart';

enum GetContractRequestStateStatus {
  init,
  loading,
  loaded,
  error,
}

class GetContractRequestState {
  final GetContractRequestStateStatus status;
  final String? errorMessage;

  GetContractRequestState({
    required this.status,
    this.errorMessage,
  });

  GetContractRequestState copyWith({
    GetContractRequestStateStatus? status,
    List<ContractRequestModel>? model,
    String? errorMessage,
  }) =>
      GetContractRequestState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
