abstract class DeleteContractRequestEvent {}

class DeleteContractRequestInitEvent extends DeleteContractRequestEvent {}

class DeleteContractRequestDeleteEvent extends DeleteContractRequestEvent {
  final String companyId;

  DeleteContractRequestDeleteEvent({required this.companyId});
}
