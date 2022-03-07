import 'package:contract_management/_all.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IUserAuth userAuth;

  AuthBloc({required this.userAuth})
      : super(
          AuthState(
            //TODO zakucano, vratit na checking
            status: AuthStateStatus.Authenticated,
          ),
        ) {
    on<AuthCheckAuthenticationEvent>(_checkAuth);
    on<AuthSignInEvent>(_signIn);
    on<AuthRegisterEvent>(_register);
    on<AuthSignOutEvent>(_signOut);
  }

  void _checkAuth(AuthCheckAuthenticationEvent event, Emitter<AuthState> emit) async {
    final state = this.state;
    emit(state.copyWith(status: AuthStateStatus.Checking));
    final isAuthenticated = await userAuth.isAuthenticated();
    emit(state.copyWith(status: isAuthenticated ? AuthStateStatus.Authenticated : AuthStateStatus.Unauthenticated));
  }

  void _signIn(AuthSignInEvent event, Emitter<AuthState> emit) async {
    final state = this.state;
    final result = await userAuth.signIn(
      event.email,
      event.password,
    );
    if (result) {
      emit(
        state.copyWith(status: AuthStateStatus.Authenticated),
      );
    } else {
      emit(
        state.copyWith(status: AuthStateStatus.Error),
      );
    }
  }

  void _register(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    final result = await userAuth.register(
      event.email,
      event.password,
      event.role,
    );
    if (result) {
      emit(
        state.copyWith(status: AuthStateStatus.Authenticated),
      );
    } else {
      emit(
        state.copyWith(status: AuthStateStatus.Error),
      );
    }
  }

  void _signOut(AuthSignOutEvent event, Emitter<AuthState> emit) async {
    final result = await userAuth.signOut();
    if (result) {
      emit(
        state.copyWith(status: AuthStateStatus.Unauthenticated),
      );
    } else {
      emit(
        state.copyWith(status: AuthStateStatus.Authenticated),
      );
    }
  }
}
