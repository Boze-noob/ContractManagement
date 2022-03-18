abstract class ContractsTemplateListEvent {}

class ContractsTemplateListInitEvent extends ContractsTemplateListEvent {}

class ContractsTemplateListDeleteEvent extends ContractsTemplateListEvent {
  final String contractName;

  ContractsTemplateListDeleteEvent({required this.contractName});
}
