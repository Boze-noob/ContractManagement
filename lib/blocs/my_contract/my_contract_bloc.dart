import 'package:contract_management/_all.dart';

class MyContractBloc extends Bloc<MyContractEvent, MyContractState> {
  final IContracts contractsRepo;
  MyContractBloc({
    required this.contractsRepo,
  }) : super(initialState()) {
    on<MyContractInitEvent>(_init);
    on<MyContractGetEvent>(_loadCurrent);
  }

  static MyContractState initialState() => MyContractState(
        status: MyContractStateStatus.init,
        model: CreateContractModel(contractDescription: '', contractItems: List.empty(), contractName: ''),
      );

  void _init(MyContractInitEvent event, Emitter<MyContractState> emit) {
    emit(
      MyContractState(
        status: MyContractStateStatus.init,
        model: CreateContractModel(contractDescription: '', contractItems: List.empty(), contractName: ''),
      ),
    );
  }

  void _loadCurrent(MyContractGetEvent event, Emitter<MyContractState> emit) async {
    emit(state.copyWith(status: MyContractStateStatus.loading));
    final result = await contractsRepo.getContractRequest(event.companyId);
    if (result != null) {
      final contractModel = await contractsRepo.loadSingleContractTemplate(result.contractId);
      if (contractModel != null) {
        for (int number in contractModel.contractItems) {
          print("number is " + number.toString());
        }
        emit(state.copyWith(status: MyContractStateStatus.loaded, model: contractModel));
      } else
        emit(state.copyWith(status: MyContractStateStatus.error, errorMessage: 'Error happen'));
    } else
      emit(state.copyWith(status: MyContractStateStatus.error, errorMessage: 'Error happen'));
  }
}
