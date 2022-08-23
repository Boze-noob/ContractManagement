import 'package:contract_management/_all.dart';

abstract class CurrentUserEvent {}

class CurrentUserInitEvent extends CurrentUserEvent {}

class CurrentUserGetEvent extends CurrentUserEvent {}

class CurrentUserUpdateEvent extends CurrentUserEvent {
  UserModel userModel;
  CurrentUserUpdateEvent({required this.userModel});
}
