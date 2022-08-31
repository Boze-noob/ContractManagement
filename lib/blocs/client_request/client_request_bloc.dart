import 'package:contract_management/_all.dart';

class ClientRequestBloc extends Bloc<ClientRequestEvent, ClientRequestState> {
  IClients clientsRepo;

  ClientRequestBloc({
    required this.clientsRepo,
  }) : super(
          initialState(),
        ) {
    on<ClientRequestInitEvent>(_init);
    on<ClientRequestUpdateEvent>(_updateState);
    on<ClientRequestSubmitEvent>(_submit);
    on<ClientRequestInitUserDataEvent>(_initUserData);
  }

  static ClientRequestState initialState() => ClientRequestState(
        status: ClientRequestStateStatus.init,
        requestModel: ClientRequestModel(
          id: '',
          createdDateTime: DateTime.now(),
          clientId: firebaseAuthInstance.currentUser!.uid,
          requestType: RequestType.activate,
          location: '',
          email: firebaseAuthInstance.currentUser!.email!,
          displayName: '',
          description: '',
        ),
      );

  void _init(ClientRequestInitEvent event, Emitter<ClientRequestState> emit) async {
    emit(state.copyWith(status: ClientRequestStateStatus.loading));
    await Future.delayed(
      Duration(milliseconds: 10),
    );
    emit(initialState());
  }

  void _initUserData(ClientRequestInitUserDataEvent event, Emitter<ClientRequestState> emit) async {
    emit(
      state.copyWith(
        requestModel: state.requestModel.copyWith(location: event.location, phoneNumber: event.phoneNumber),
      ),
    );
  }

  void _updateState(ClientRequestUpdateEvent event, Emitter<ClientRequestState> emit) async {
    emit(
      state.copyWith(requestModel: event.clientRequestModel),
    );
  }

  void _submit(ClientRequestSubmitEvent event, Emitter<ClientRequestState> emit) async {
    emit(
      state.copyWith(status: ClientRequestStateStatus.submitting),
    );

    final result = await clientsRepo.sendClientRequest(state.requestModel.copyWith(id: generateRandomId()));
    if (result) {
      emit(
        state.copyWith(status: ClientRequestStateStatus.submittedSuccessfully),
      );
      initialState();
    } else
      emit(
        state.copyWith(status: ClientRequestStateStatus.error, errorMessage: 'Error happen'),
      );
  }
}
