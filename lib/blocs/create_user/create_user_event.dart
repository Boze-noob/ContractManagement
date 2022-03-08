import 'package:contract_management/_all.dart';

abstract class CreateUserEvent {}

class CreateUserUpdateModelEvent extends CreateUserEvent {
  final UserModel userModel;

  CreateUserUpdateModelEvent({
    required this.userModel,
  });
}

class CreateUserSubmitEvent extends CreateUserEvent {}
