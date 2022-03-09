import 'package:contract_management/_all.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IUserAuth userAuth;

  AuthBloc({required this.userAuth})
      : super(
          AuthState(
            status: AuthStateStatus.Unauthenticated,
          ),
        ) {
    on<AuthCheckAuthenticationEvent>(_checkAuth);
    on<AuthSignInEvent>(_signIn);
    on<AuthSignOutEvent>(_signOut);
  }

  void _checkAuth(AuthCheckAuthenticationEvent event, Emitter<AuthState> emit) async {
    print('Usli smo u check auth function');
    emit(state.copyWith(status: AuthStateStatus.Checking));
    final isAuthenticated = await userAuth.isAuthenticated();
    print('isAuthenticated je $isAuthenticated');
    emit(state.copyWith(status: isAuthenticated ? AuthStateStatus.Authenticated : AuthStateStatus.Unauthenticated));
    print('trenutni state je ${state.status}');
  }

  void _signIn(AuthSignInEvent event, Emitter<AuthState> emit) async {
    final state = this.state;
    final result = await userAuth.signIn(
      event.email,
      event.password,
      event.rememberMe,
    );
    if (result == null) {
      emit(
        state.copyWith(status: AuthStateStatus.Authenticated),
      );
    } else {
      emit(
        state.copyWith(
          status: AuthStateStatus.Error,
          errorMessage: result,
        ),
      );
      await Future.delayed(Duration(seconds: 1));

      emit(
        state.copyWith(status: AuthStateStatus.Unauthenticated),
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
