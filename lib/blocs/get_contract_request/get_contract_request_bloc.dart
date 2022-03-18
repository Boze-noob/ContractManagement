import 'package:contract_management/_all.dart';

class GetContractRequestBloc extends Bloc<GetContractRequestEvent, GetContractRequestState> {
  final IContracts contractsRepo;
  GetContractRequestBloc({
    required this.contractsRepo,
  }) : super(initialState()) {
    on<GetContractRequestInitEvent>(_init);
  }

  static GetContractRequestState initialState() => GetContractRequestState(status: GetContractRequestStateStatus.init);

  void _init(GetContractRequestInitEvent event, Emitter<GetContractRequestState> emit) {
    emit(
      GetContractRequestState(status: GetContractRequestStateStatus.init),
    );
  }
}
