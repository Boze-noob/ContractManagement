import 'package:contract_management/_all.dart';

abstract class AdminRequestsEvent {}

class AdminRequestsInitEvent extends AdminRequestsEvent {}

class AdminRequestsSendEvent extends AdminRequestsEvent {
  final AdminRequestModel adminRequestModel;

  AdminRequestsSendEvent({required this.adminRequestModel});
}

class AdminRequestsGetEvent extends AdminRequestsEvent {
  final String companyId;

  AdminRequestsGetEvent({required this.companyId});
}
