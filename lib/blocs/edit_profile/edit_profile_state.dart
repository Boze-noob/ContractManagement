import 'package:contract_management/_all.dart';

enum EditProfileStateStatus {
  init,
  submitting,
  submitSuccess,
  error,
}

class EditProfileState {
  final EditProfileStateStatus status;
  final UserModel userModel;

  EditProfileState({
    required this.status,
    required this.userModel,
  });

  EditProfileState copyWith({
    EditProfileStateStatus? status,
    UserModel? userModel,
  }) =>
      EditProfileState(
        status: status ?? this.status,
        userModel: userModel ?? this.userModel,
      );
}
