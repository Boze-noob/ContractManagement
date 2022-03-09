abstract class AuthEvent {}

class AuthCheckAuthenticationEvent extends AuthEvent {}

class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;

  AuthSignInEvent({
    required this.email,
    required this.password,
    required this.rememberMe,
  });
}

class AuthSignOutEvent extends AuthEvent {}
