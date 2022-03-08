abstract class AuthEvent {}

class AuthCheckAuthenticationEvent extends AuthEvent {}

class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignInEvent({
    required this.email,
    required this.password,
  });
}

class AuthSignOutEvent extends AuthEvent {}
