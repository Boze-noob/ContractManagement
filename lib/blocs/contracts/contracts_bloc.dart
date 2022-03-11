import 'package:contract_management/_all.dart';

class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  final IContracts contractsRepo;

  ContractsBloc({
    required this.contractsRepo,
  }) : super(initialState()) {
    on<ContractsLoadEvent>(_load);
    on<ContractsInitEvent>(_init);
  }

  static ContractsState initialState() => ContractsState(
        status: ContractsStateStatus.init,
        contracts: List.empty(),
      );

  void _load(ContractsLoadEvent event, Emitter<ContractsState> emit) async {
    emit(
      state.copyWith(status: ContractsStateStatus.loading),
    );

    final contracts = await contractsRepo.load(
      event.contractsType,
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

  void _init(ContractsInitEvent event, Emitter<ContractsState> emit) {
    initialState();
  }
}
