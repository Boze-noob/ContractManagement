import 'package:contract_management/_all.dart';

class ContractsCounterBloc extends Bloc<ContractsCounterEvent, ContractsCounterState> {
  final IContracts contractsRepo;

  ContractsCounterBloc({
    required this.contractsRepo,
  }) : super(initialState()) {
    on<ContractsCounterInitEvent>(_init);
    on<ContractsCounterLoadEvent>(_load);
  }

  static ContractsCounterState initialState() => ContractsCounterState(
        status: ContractsCounterStateStatus.init,
        contractsCounterModel: ContractsCounterModel(
          active: 0,
          completed: 0,
          requests: 0,
          terminated: 0,
        ),
      );

  void _init(ContractsCounterInitEvent event, Emitter<ContractsCounterState> emit) {
    initialState();
  }

  void _load(ContractsCounterLoadEvent event, Emitter<ContractsCounterState> emit) async {
    emit(state.copyWith(status: ContractsCounterStateStatus.loading));
    final model = await contractsRepo.loadContractsCount();
    if (model != null)
      emit(state.copyWith(status: ContractsCounterStateStatus.loaded, contractsCounterModel: model));
    else
      emit(
        state.copyWith(
          status: ContractsCounterStateStatus.error,
          errorMessage: 'Error happen',
        ),
      );
  }
}
