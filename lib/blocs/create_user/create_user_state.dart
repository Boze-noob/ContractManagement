import 'package:contract_management/_all.dart';

enum CreateUserStateStatus {
  init,
  submitting,
  submitSuccess,
  error,
}

class CreateUserState {
  final CreateUserStateStatus status;
  final UserModel userModel;
  final String? errorMessage;

  CreateUserState({
    required this.status,
    required this.userModel,
    this.errorMessage,
  });

  CreateUserState copyWith({
    CreateUserStateStatus? status,
    UserModel? userModel,
    String? errorMessage,
  }) =>
      CreateUserState(
        status: status ?? this.status,
        userModel: userModel ?? this.userModel,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
