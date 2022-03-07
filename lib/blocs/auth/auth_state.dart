enum AuthStateStatus { Checking, Authenticated, Unauthenticated, Error }

class AuthState {
  AuthStateStatus status;

  AuthState({required this.status});

  AuthState copyWith({AuthStateStatus? status}) => AuthState(
        status: status ?? this.status,
      );
}
