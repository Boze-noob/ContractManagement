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

class AuthRegisterEvent extends AuthEvent {
  final String? email;
  final String? password;
  final String? role;

  AuthRegisterEvent({
    this.email,
    this.password,
    this.role,
  });
}

class AuthSignOutEvent extends AuthEvent {}
