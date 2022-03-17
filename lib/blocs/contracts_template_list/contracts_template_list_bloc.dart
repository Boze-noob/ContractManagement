import 'package:contract_management/_all.dart';

class ContractsTemplateListBloc extends Bloc<ContractsTemplateListEvent, ContractsTemplateListState> {
  final IContracts contractsRepo;
  ContractsTemplateListBloc({
    required this.contractsRepo,
  }) : super(initialState()) {
    on<ContractsTemplateListInitEvent>(_init);
  }

  static ContractsTemplateListState initialState() => ContractsTemplateListState(status: ContractsTemplateStateStatus.initializing, createContractModel: List.empty());

  void _init(ContractsTemplateListInitEvent event, Emitter<ContractsTemplateListState> emit) async {
    emit(state.copyWith(status: ContractsTemplateStateStatus.initializing));

    final result = await contractsRepo.loadContractsTemplates();
    if (result != null)
      emit(state.copyWith(status: ContractsTemplateStateStatus.init, createContractModel: result));
    else
      emit(state.copyWith(status: ContractsTemplateStateStatus.error, errorMessage: 'Error happen'));
  }
}
