import 'package:contract_management/_all.dart';

class CreateContractBloc extends Bloc<CreateContractEvent, CreateContractState> {
  final IContracts contractsRepo;
  CreateContractBloc({
    required this.contractsRepo,
  }) : super(initialState()) {
    on<CreateContractInitEvent>(_init);
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
    initialState();
  }

  void _update(CreateContractUpdateEvent event, Emitter<CreateContractState> emit) {
    emit(
      state.copyWith(
        createContractModel: event.createContractModel,
      ),
    );
  }

  void _submit(CreateContractSubmitEvent event, Emitter<CreateContractState> emit) async {
    emit(state.copyWith(status: CreateContractStateStatus.submitting));
    final result = await contractsRepo.storeDate(state.createContractModel);
    if (result)
      emit(state.copyWith(status: CreateContractStateStatus.submitSuccessfully));
    else
      emit(state.copyWith(errorMessage: 'Error happen'));
  }
}
