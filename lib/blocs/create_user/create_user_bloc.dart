import 'package:contract_management/_all.dart';
import 'package:contract_management/common/enumerations/role_type.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  IAccount accountRepo;
  CreateUserBloc({
    required this.accountRepo,
  }) : super(
          CreateUserState(
            status: CreateUserStateStatus.init,
            userModel: UserModel(id: '', email: '', password: '', role: RoleType.getValue(0).translate()),
          ),
        ) {
    on<CreateUserUpdateModelEvent>(_updateState);
    on<CreateUserSubmitEvent>(_submit);
  }

  void _updateState(CreateUserUpdateModelEvent event, Emitter<CreateUserState> emit) async {
    print('updating user state');
    emit(
      state.copyWith(
        userModel: event.userModel,
      ),
    );
  }

  void _submit(CreateUserSubmitEvent event, Emitter<CreateUserState> emit) async {
    print('submitting user state');
    emit(
      state.copyWith(status: CreateUserStateStatus.submitting),
    );
    final result = await accountRepo.createAccount(state.userModel.email, state.userModel.password, state.userModel.role);
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
