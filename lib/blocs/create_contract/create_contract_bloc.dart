import 'package:contract_management/_all.dart';

class CreateContractBloc extends Bloc<CreateContractEvent, CreateContractState> {
  final IContracts contractsRepo;
  CreateContractBloc({
    required this.contractsRepo,
  }) : super(initialState()) {
    on<CreateContractInitEvent>(_init);
    on<CreateContractSetForUpdateEvent>(_prepare);
    on<CreateContractUpdateEvent>(_update);
    on<CreateContractSubmitEvent>(_submit);
  }

  static CreateContractState initialState() => CreateContractState(
        status: CreateContractStateStatus.init,
        createContractModel: CreateContractModel(
          contractName: '',
          contractItems: List.empty(),
          contractDescription: '',
        ),
      );

  void _init(CreateContractInitEvent event, Emitter<CreateContractState> emit) {
    emit(initialState());
  }

  void _prepare(CreateContractSetForUpdateEvent event, Emitter<CreateContractState> emit) {
    emit(
      state.copyWith(
          createContractModel: event.createContractModel,
          status: CreateContractStateStatus.updated,
          previousContractName: event.createContractModel.contractName),
    );
  }

  void _update(CreateContractUpdateEvent event, Emitter<CreateContractState> emit) {
    emit(
      state.copyWith(
        createContractModel: event.createContractModel,
        status: CreateContractStateStatus.updated,
      ),
    );
  }

  void _submit(CreateContractSubmitEvent event, Emitter<CreateContractState> emit) async {
    emit(state.copyWith(status: CreateContractStateStatus.submitting));
    final result = await contractsRepo.createContractTemplate(state.createContractModel, state.previousContractName);
    if (result) {
      emit(state.copyWith(status: CreateContractStateStatus.successfullySubmitted));
    } else
      emit(state.copyWith(errorMessage: 'Error happen'));
  }
}
