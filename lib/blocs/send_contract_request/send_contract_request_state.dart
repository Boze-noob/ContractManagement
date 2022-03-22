import 'package:contract_management/_all.dart';

enum SendContractRequestStateStatus {
  init,
  submitting,
  successfullySubmitted,
  error,
}

class SendContractRequestState {
  final SendContractRequestStateStatus status;
  final ContractRequestModel? contractRequestModel;
  final String? errorMessage;

  SendContractRequestState({
    required this.status,
    this.errorMessage,
    this.contractRequestModel,
  });

  SendContractRequestState copyWith({
    SendContractRequestStateStatus? status,
    ContractRequestModel? contractRequestModel,
    String? errorMessage,
  }) =>
      SendContractRequestState(
        status: status ?? this.status,
        contractRequestModel: contractRequestModel ?? this.contractRequestModel,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
