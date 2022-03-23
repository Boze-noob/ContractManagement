abstract class MyContractEvent {}

class MyContractInitEvent extends MyContractEvent {}

class MyContractGetEvent extends MyContractEvent {
  final String companyId;

  MyContractGetEvent({required this.companyId});
}
