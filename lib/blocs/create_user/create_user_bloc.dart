import 'package:contract_management/_all.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  IAccount accountRepo;
  CreateUserBloc({
    required this.accountRepo,
  }) : super(
          CreateUserState(
            status: CreateUserStateStatus.init,
            userModel:
                UserModel(id: '', email: '', password: '', displayName: '', role: RoleType.getValue(0).translate()),
          ),
        ) {
    on<CreateUserInitEvent>(_init);
    on<CreateUserUpdateModelEvent>(_updateState);
    on<CreateUserSubmitEvent>(_submit);
  }

  void _init(CreateUserInitEvent event, Emitter<CreateUserState> emit) async {
    emit(state.copyWith(status: CreateUserStateStatus.init));
  }

  void _updateState(CreateUserUpdateModelEvent event, Emitter<CreateUserState> emit) async {
    emit(
      state.copyWith(
        userModel: event.userModel,
        status: CreateUserStateStatus.updating,
      ),
    );
  }

  void _submit(CreateUserSubmitEvent event, Emitter<CreateUserState> emit) async {
    emit(
      state.copyWith(status: CreateUserStateStatus.submitting),
    );
    final result = await accountRepo.createAccount(
      state.userModel.email,
      //default password user can change it later
      state.userModel.password ?? 'Password1!',
      state.userModel.role,
      state.userModel.displayName,
    );
    if (result == null) {
      emit(
        state.copyWith(status: CreateUserStateStatus.submitSuccess),
      );
    } else {
      emit(
        state.copyWith(status: CreateUserStateStatus.error, errorMessage: result),
      );
    }
  }
}
