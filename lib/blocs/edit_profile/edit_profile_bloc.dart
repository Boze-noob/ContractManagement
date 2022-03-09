import 'package:contract_management/_all.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  IAccount accountRepo;
  EditProfileBloc({
    required this.accountRepo,
  }) : super(
          initialState(),
        ) {
    on<EditProfileInitEvent>(_init);
    on<EditProfileUpdateEvent>(_updateState);
    on<EditProfileSubmitEvent>(_submit);
  }

  static EditProfileState initialState() => EditProfileState(
        status: EditProfileStateStatus.init,
        userModel: UserModel(
          email: '',
          role: '',
          displayName: '',
          id: '',
        ),
      );

  void _init(EditProfileInitEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(status: EditProfileStateStatus.loading));
    await Future.delayed(Duration(seconds: 1));
    emit(
      state.copyWith(
        userModel: event.userModel,
        status: EditProfileStateStatus.init,
      ),
    );
  }

  void _updateState(EditProfileUpdateEvent event, Emitter<EditProfileState> emit) async {
    emit(
      state.copyWith(
        userModel: event.userModel,
      ),
    );
  }

  void _submit(EditProfileSubmitEvent event, Emitter<EditProfileState> emit) async {
    emit(
      state.copyWith(status: EditProfileStateStatus.submitting),
    );
    final result = await accountRepo.editAccount(state.userModel);
    if (result)
      emit(state.copyWith(
        status: EditProfileStateStatus.submitSuccess,
      ));
    else
      emit(state.copyWith(
        status: EditProfileStateStatus.error,
      ));
  }
}
