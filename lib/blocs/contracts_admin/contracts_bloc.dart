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
    emit(initialState());
  }

  void _load(ContractsLoadEvent event, Emitter<ContractsState> emit) async {
    print('We enter into load contract');
    emit(
      state.copyWith(status: ContractsStateStatus.loading),
    );

    final contracts = await contractsRepo.loadContracts(
      event.contractType,
    );
    if (contracts != null) {
      print('We enter into load contract successfully');
      emit(
        state.copyWith(status: ContractsStateStatus.loaded, contracts: contracts),
      );
    } else {
      print('we enter into list empty in contractsbloc');
      emit(
        state.copyWith(status: ContractsStateStatus.error, errorMessage: 'No data found', contracts: List.empty()),
      );
    }
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
    print('Result in terminate is $result -----------------------');
    if (result == null) {
      print('Contract has been terminated properly');
      emit(
        state.copyWith(status: ContractsStateStatus.terminated),
      );
    } else {
      print('Contract has not been terminated properly');
      emit(state.copyWith(status: ContractsStateStatus.error, errorMessage: 'Error happen'));
    }
  }
}
