import 'package:contract_management/_all.dart';

class GetContractRequestBloc extends Bloc<GetContractRequestEvent, GetContractRequestState> {
  final IContracts contractsRepo;
  GetContractRequestBloc({
    required this.contractsRepo,
  }) : super(initialState()) {
    on<GetContractRequestInitEvent>(_init);
    on<GetContractForCurrentCompanyRequest>(_loadCurrent);
  }

  static GetContractRequestState initialState() => GetContractRequestState(status: GetContractRequestStateStatus.init, model: List.empty());

  void _init(GetContractRequestInitEvent event, Emitter<GetContractRequestState> emit) {
    emit(
      GetContractRequestState(status: GetContractRequestStateStatus.init, model: List.empty()),
    );
  }

  void _loadCurrent(GetContractForCurrentCompanyRequest event, Emitter<GetContractRequestState> emit) async {
    emit(state.copyWith(status: GetContractRequestStateStatus.loading));
    final result = await contractsRepo.getContractRequest(event.companyId);
    if (result != null)
      emit(state.copyWith(status: GetContractRequestStateStatus.loaded, model: result));
    else
      emit(state.copyWith(status: GetContractRequestStateStatus.error, errorMessage: 'Error happen'));
  }
}
