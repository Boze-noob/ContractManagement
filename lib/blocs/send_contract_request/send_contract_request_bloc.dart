import 'package:contract_management/_all.dart';

class SendContractRequestBloc extends Bloc<SendContractRequestEvent, SendContractRequestState> {
  final IContracts contractsRepo;
  SendContractRequestBloc({
    required this.contractsRepo,
  }) : super(initialState()) {
    on<SendContractRequestInitEvent>(_init);
    on<SendContractRequestSubmitEvent>(_submit);
  }

  static SendContractRequestState initialState() => SendContractRequestState(status: SendContractRequestStateStatus.init);

  void _init(SendContractRequestInitEvent event, Emitter<SendContractRequestState> emit) {
    emit(SendContractRequestState(status: SendContractRequestStateStatus.init));
  }

  void _submit(SendContractRequestSubmitEvent event, Emitter<SendContractRequestState> emit) async {
    final result = await contractsRepo.sendContractRequest(event.contractRequestModel);
    if (result)
      emit(state.copyWith(status: SendContractRequestStateStatus.successfullySubmitted, contractRequestModel: event.contractRequestModel));
    else
      emit(state.copyWith(status: SendContractRequestStateStatus.error, errorMessage: 'Error happen'));
  }
}
