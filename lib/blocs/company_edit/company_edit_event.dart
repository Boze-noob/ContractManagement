import 'package:contract_management/_all.dart';

abstract class CompanyEditEvent {}

class CompanyEditInitEvent extends CompanyEditEvent {
  final UserModel companyModel;

  CompanyEditInitEvent({required this.companyModel});
}

class CompanyEditUpdateEvent extends CompanyEditEvent {
  final UserModel companyModel;

  CompanyEditUpdateEvent({required this.companyModel});
}

class CompanyEditSubmitEvent extends CompanyEditEvent {}
