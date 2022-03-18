enum SendContractRequestStateStatus {
  init,
  submitting,
  successfullySubmitted,
  error,
}

class SendContractRequestState {
  final SendContractRequestStateStatus status;
  final String? errorMessage;

  SendContractRequestState({required this.status, this.errorMessage});

  SendContractRequestState copyWith({
    SendContractRequestStateStatus? status,
    String? errorMessage,
  }) =>
      SendContractRequestState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
