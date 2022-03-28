import 'package:contract_management/_all.dart';

class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  final IContracts contractsRepo;

  ContractsBloc({
    required this.contractsRepo,
  }) : super(initialState()) {
    on<ContractsLoadEvent>(_load);
    on<ContractsInitEvent>(_init);
    on<ContractsCheckDateEvent>(_checkDate);
    on<ContractsTerminateEvent>(_terminate);
  }

  static ContractsState initialState() => ContractsState(
        status: ContractsStateStatus.init,
        contracts: List.empty(),
      );

  void _init(ContractsInitEvent event, Emitter<ContractsState> emit) {
    initialState();
  }

  void _load(ContractsLoadEvent event, Emitter<ContractsState> emit) async {
    emit(
      state.copyWith(status: ContractsStateStatus.loading),
    );

    final contracts = await contractsRepo.loadContracts(
      event.contractType,
    );
    if (contracts != null) {
      emit(
        state.copyWith(status: ContractsStateStatus.loaded, contracts: contracts),
      );
    } else
      emit(
        state.copyWith(status: ContractsStateStatus.error, errorMessage: 'No data found'),
      );
  }

  void _checkDate(ContractsCheckDateEvent event, Emitter<ContractsState> emit) async {
    final contracts = await contractsRepo.loadContracts(ContractType.active);
    if (contracts != null)
      for (ContractModel contractModel in contracts) {
        if (contractModel.completionDateTime == DateTime.now()) await contractsRepo.completeContract(contractModel);
      }
  }

  void _terminate(ContractsTerminateEvent event, Emitter<ContractsState> emit) async {
    emit(state.copyWith(status: ContractsStateStatus.loading));
    final result = await contractsRepo.terminateContract(event.contractModel, event.userRoleType);
    if (result == null)
      emit(
        state.copyWith(status: ContractsStateStatus.terminated),
      );
    else emit(state.copyWith(status: ContractsStateStatus.error, errorMessage: 'Error happen'));
  }
}
