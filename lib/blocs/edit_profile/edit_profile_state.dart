import 'package:contract_management/_all.dart';

enum EditProfileStateStatus {
  init,
  loading,
  submitting,
  submitSuccess,
  userSuccessfullyDeleted,
  error,
}

class EditProfileState {
  final EditProfileStateStatus status;
  final UserModel userModel;
  final String? errorMessage;

  EditProfileState({
    required this.status,
    required this.userModel,
    this.errorMessage,
  });

  EditProfileState copyWith({
    EditProfileStateStatus? status,
    UserModel? userModel,
    String? errorMessage,
  }) =>
      EditProfileState(
        status: status ?? this.status,
        userModel: userModel ?? this.userModel,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
