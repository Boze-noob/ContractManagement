abstract class AdminRequestsEvent {}

class AdminRequestsInitEvent extends AdminRequestsEvent{}

class AdminRequestsGetEvent extends AdminRequestsEvent{
  final String companyId;

  AdminRequestsGetEvent({required this.companyId});
}