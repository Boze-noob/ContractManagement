import 'dart:async';

import 'package:contract_management/_all.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IUserAuth userAuthRepo;

  AuthBloc({
    required this.userAuthRepo,
  }) : super(initialState()) {
    on<AuthInitEvent>(_init);
    on<AuthCheckAuthenticationEvent>(_checkAuth);
    on<AuthSignInEvent>(_signIn);
    on<AuthSignOutEvent>(_signOut);
  }

  static AuthState initialState() => AuthState(status: AuthStateStatus.Unauthenticated);

  void _init(AuthInitEvent event, Emitter<AuthState> emit) async {
    emit(
      AuthState(status: AuthStateStatus.Unauthenticated),
    );
    //initialState();
  }

  void _checkAuth(AuthCheckAuthenticationEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStateStatus.Checking));
    final isAuthenticated = await userAuthRepo.isAuthenticated();
    emit(state.copyWith(status: isAuthenticated ? AuthStateStatus.Authenticated : AuthStateStatus.Unauthenticated));
  }

  void _signIn(AuthSignInEvent event, Emitter<AuthState> emit) async {
    final state = this.state;
    final result = await userAuthRepo.signIn(
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
    final result = await userAuthRepo.signOut();
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
