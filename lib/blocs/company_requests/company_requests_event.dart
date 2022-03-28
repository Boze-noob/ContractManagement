import 'package:contract_management/_all.dart';

abstract class CompanyRequestsEvent {}

class CompanyRequestsInitEvent extends CompanyRequestsEvent {}

class CompanyRequestsSendEvent extends CompanyRequestsEvent {
  final AdminRequestModel adminRequestModel;

  CompanyRequestsSendEvent({required this.adminRequestModel});
}

class CompanyRequestsGetEvent extends CompanyRequestsEvent {
  final String companyId;

  CompanyRequestsGetEvent({required this.companyId});
}
