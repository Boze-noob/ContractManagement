import 'package:contract_management/_all.dart';

class DeleteContractRequestBloc extends Bloc<DeleteContractRequestEvent, DeleteContractRequestState> {
  final IContracts contractsRepo;

  DeleteContractRequestBloc(
    this.contractsRepo,
  ) : super(initialState()) {
    on<DeleteContractRequestInitEvent>(_init);
    on<DeleteContractRequestDeleteEvent>(_delete);
  }

  static DeleteContractRequestState initialState() => DeleteContractRequestState(
        status: DeleteContractRequestStateStatus.init,
      );

  void _init(DeleteContractRequestInitEvent event, Emitter<DeleteContractRequestState> emit) {
    emit(DeleteContractRequestState(
      status: DeleteContractRequestStateStatus.init,
    ));
  }

  void _delete(DeleteContractRequestDeleteEvent event, Emitter<DeleteContractRequestState> emit) async {
    emit(state.copyWith(status: DeleteContractRequestStateStatus.deleting));
    final result = await contractsRepo.deleteContractRequest(event.companyId);
    if (result == null)
      emit(state.copyWith(status: DeleteContractRequestStateStatus.successfullyDeleted));
    else
      emit(state.copyWith(status: DeleteContractRequestStateStatus.error, errorMessage: result));
  }
}
