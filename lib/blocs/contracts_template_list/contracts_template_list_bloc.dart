import 'package:contract_management/_all.dart';

class ContractsTemplateListBloc extends Bloc<ContractsTemplateListEvent, ContractsTemplateListState> {
  final IContracts contractsRepo;
  ContractsTemplateListBloc({
    required this.contractsRepo,
  }) : super(initialState()) {
    on<ContractsTemplateListInitEvent>(_init);
    on<ContractsTemplateListDeleteEvent>(_delete);
  }

  static ContractsTemplateListState initialState() => ContractsTemplateListState(status: ContractsTemplateStateStatus.initializing, createContractModel: List.empty());

  void _init(ContractsTemplateListInitEvent event, Emitter<ContractsTemplateListState> emit) async {
    emit(state.copyWith(status: ContractsTemplateStateStatus.initializing));
    //Not good practice to delay but for UX reasons I added it
    await Future.delayed(Duration(milliseconds: 500));

    final result = await contractsRepo.loadContractsTemplates();
    if (result != null)
      emit(state.copyWith(status: ContractsTemplateStateStatus.init, createContractModel: result));
    else
      emit(state.copyWith(status: ContractsTemplateStateStatus.error, errorMessage: 'Error happen'));
  }

  void _delete(ContractsTemplateListDeleteEvent event, Emitter<ContractsTemplateListState> emit) async {
    final result = await contractsRepo.deleteContractTemplate(event.contractName);
    if (result == null)
      emit(state.copyWith(status: ContractsTemplateStateStatus.successfullyDeleted));
    else
      emit(state.copyWith(status: ContractsTemplateStateStatus.error, errorMessage: result));
  }
}
