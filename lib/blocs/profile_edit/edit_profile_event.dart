import 'package:contract_management/_all.dart';

abstract class EditProfileEvent {}

class EditProfileInitEvent extends EditProfileEvent {
  final UserModel userModel;

  EditProfileInitEvent({required this.userModel});
}

class EditProfileUpdateEvent extends EditProfileEvent {
  final UserModel userModel;

  EditProfileUpdateEvent({required this.userModel});
}

class EditProfileDeleteEvent extends EditProfileEvent {
  String uid;
  EditProfileDeleteEvent({required this.uid});
}

class EditProfileSubmitEvent extends EditProfileEvent {}
