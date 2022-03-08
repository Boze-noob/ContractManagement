import 'package:contract_management/_all.dart';

abstract class EditProfileEvent {}

class EditProfileInitEvent extends EditProfileEvent {
  final UserModel userModel;

  //TODO kad user dode na ovaj page prosljedit mi trenutni user model
  EditProfileInitEvent({required this.userModel});
}

class EditProfileUpdateEvent extends EditProfileEvent {
  final UserModel userModel;

  EditProfileUpdateEvent({required this.userModel});
}

class EditProfileSubmitEvent extends EditProfileEvent {}
