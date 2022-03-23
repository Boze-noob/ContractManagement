enum DeleteContractRequestStateStatus {
  init,
  deleting,
  successfullyDeleted,
  error,
}

class DeleteContractRequestState {
  final DeleteContractRequestStateStatus status;
  final String? errorMessage;

  DeleteContractRequestState({required this.status, this.errorMessage});

  DeleteContractRequestState copyWith({
    final DeleteContractRequestStateStatus? status,
    final String? errorMessage,
  }) =>
      DeleteContractRequestState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
