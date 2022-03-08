import 'package:contract_management/_all.dart';

enum CurrentUserStateStatus {
  init,
  getting,
  success,
  error,
}

class CurrentUserState {
  final CurrentUserStateStatus status;
  final UserModel? userModel;

  CurrentUserState({
    required this.status,
    this.userModel,
  });

  CurrentUserState copyWith({
    CurrentUserStateStatus? status,
    UserModel? userModel,
  }) =>
      CurrentUserState(
        status: status ?? this.status,
        userModel: userModel ?? this.userModel,
      );
}
