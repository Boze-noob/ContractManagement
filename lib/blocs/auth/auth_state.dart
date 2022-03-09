enum AuthStateStatus { Checking, Authenticated, Unauthenticated, Error }

class AuthState {
  AuthStateStatus status;
  final String? errorMessage;

  AuthState({
    required this.status,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStateStatus? status,
    String? errorMessage,
  }) =>
      AuthState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
